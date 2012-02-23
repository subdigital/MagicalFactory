#import "Kiwi.h"
#import "Customer.h"
#import "MFFactory.h"

SPEC_BEGIN(MFFactorySpecs)

describe(@"MFFactory", ^{
        
    it(@"should initially have no factories", ^{
        int count = [[MFFactory factories] count];
        [[theValue(count) should] equal:theValue(0)];
    });
    
    it(@"registering a factory should increase the count", ^{
        [MFFactory defineFactoryForClass:[Customer class] withBlock:^(MFFactory *customer) {           
        }];

        int count = [[MFFactory factories] count];
        [[theValue(count) should] equal:theValue(1)];
    });
    
    it(@"Removing factories should clear the defined factories", ^{
        [MFFactory defineFactoryForClass:[Customer class] withBlock:^(MFFactory *customer) {           
        }];
        [MFFactory reset];
        int count = [[MFFactory factories] count];
        [[theValue(count) should] equal:theValue(0)];
    });
    
    context(@"A simple factory for the Customer class", ^{
        beforeEach(^{
            [MFFactory reset];
            [MFFactory defineFactoryForClass:[Customer class] withBlock:^(id customer) {
                // Kind of awkward that you can't use properties here.  The type of 'customer' is really an MFFactory instance...
                // if it is typed as such in the block signature, you get warnings because setName: doesn't exist on MFFactory.
                [customer setName:@"Test Customer"];
            }];
        });
        
        it(@"should save the factory under the key 'Customer'", ^{
            id savedFactory = [[MFFactory factories] objectForKey:@"Customer"];
            [[savedFactory shouldNot] beNil];            
        });
        
        it(@"should save the factory with the correct class", ^{
            MFFactory *savedFactory = [[MFFactory factories] objectForKey:@"Customer"];
            [[savedFactory.factoryClass should] equal:[Customer class]];
        });
        
        it(@"should build a simple customer", ^{
            Customer *customer = [MFFactory objectOfClass:[Customer class]];
            [[customer.name should] equal:@"Test Customer"];
        });
    });
    
    context(@"A factory with sequences", ^{
        beforeEach(^{
            [MFFactory reset];
            [MFFactory defineFactoryForClass:[Customer class] withBlock:^(id customer) {
                [customer sequenceFor:@"name" do:^(int i) {
                    return @"customer-%d";
                }];
            }];
        });
        
        it(@"should generate customer-1 for the first customer name", ^{
            Customer *customer = [MFFactory objectOfClass:[Customer class]];
            [[[customer name] should] equal:@"customer-1"];
        });
        
        it(@"should generate customer-2 for the second customer name", ^{
            Customer *customer = [MFFactory objectOfClass:[Customer class]];
            customer = [MFFactory objectOfClass:[Customer class]];
            [[[customer name] should] equal:@"customer-2"];
        });
        
        it(@"should generate customer-42 for the 42nd customer name", ^{
            for (int i = 0; i<41; i++) {
                [MFFactory objectOfClass:[Customer class]];
            }
            
            Customer *customer = [MFFactory objectOfClass:[Customer class]];
            [[[customer name] should] equal:@"customer-42"];
        });
    });
    
    context(@"Named factories", ^{
        beforeEach(^{
            [MFFactory reset];
            [MFFactory defineFactoryForClass:[Customer class] withBlock:^(id customer) { 
            }];
            [MFFactory defineFactoryForClass:[Customer class] named:@"delinquent_customer" withBlock:^(id customer) {
                [customer setName:@"Joe Bad Debt"];
                [customer setStatus:CustomerStatusDelinquent];
            }];
        });
        
        it(@"should give me a customer with a status of delinquent", ^{
            Customer *customer = [MFFactory objectWithFactoryName:@"delinquent_customer"];
            [[theValue([customer status]) should] equal:theValue(CustomerStatusDelinquent)];
        });
        
        it(@"should still allow getting the default factory for customer", ^{
            Customer *customer = [MFFactory objectOfClass:[Customer class]];
            [[theValue([customer status]) shouldNot] equal:theValue(CustomerStatusDelinquent)];
        });
    });
});

SPEC_END