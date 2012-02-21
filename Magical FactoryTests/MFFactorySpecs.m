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
        [MFFactory removeAllFactories];
        int count = [[MFFactory factories] count];
        [[theValue(count) should] equal:theValue(0)];
    });
    
    context(@"A simple factory for the Customer class", ^{
        beforeEach(^{
            [MFFactory removeAllFactories];
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
});

SPEC_END