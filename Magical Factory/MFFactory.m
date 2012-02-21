//
//  Magical_Factory.m
//  Magical Factory
//
//  Created by Ben Scheirman on 2/21/12.
//  Copyright (c) 2012 Fickle Bits. All rights reserved.
//

#import "MFFactory.h"

static NSMutableDictionary *__factories;

@implementation MFFactory

#pragma mark - Class methods

+ (NSMutableDictionary *)factories {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __factories = [[NSMutableDictionary alloc] init];
    });
    
    return __factories;
}

+ (void)defineFactoryForClass:(Class)class_ withBlock:(MFFactoryBlock)block {
    [self defineFactoryForClass:class_ named:[class_ description] withBlock:block];
}

+ (void)defineFactoryForClass:(Class)class_ named:(NSString *)name withBlock:(MFFactoryBlock)block {
    
}

+ (id)objectOfClass:(Class)class_ {
    return nil;
}

+ (id)objectWithFactoryName:(NSString *)name {
    return nil;
}

+ (void)removeAllFactories {
    
}

#pragma mark - Instance methods

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
