#import "Kiwi.h"
#import "MFFactory.h"

SPEC_BEGIN(MFFactorySpecs)

describe(@"MFFactory", ^{
    it(@"should initially have no factories", ^{
        int count = [[MFFactory factories] count];
        [[theValue(count) should] equal:theValue(0)];
    });
});

SPEC_END