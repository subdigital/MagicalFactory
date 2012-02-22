//
//  Magical_Factory.m
//  Magical Factory
//
//  Created by Ben Scheirman on 2/21/12.
//  Copyright (c) 2012 Fickle Bits. All rights reserved.
//

#import "MFFactory.h"

static NSMutableDictionary *__factories;
static NSMutableDictionary *__sequences;

@interface MFFactory () 

@property (nonatomic, retain) id subject;
@property (nonatomic, copy) MFFactoryBlock factoryBlock;

- (id)initWithName:(NSString *)name class:(Class)class block:(MFFactoryBlock)block;
- (id)buildSubject;

@end

@implementation MFFactory

@synthesize subject = _subject;
@synthesize factoryName = _factoryName;
@synthesize factoryClass = _factoryClass;
@synthesize factoryBlock = _factoryBlock;

#pragma mark - Class methods

+ (NSMutableDictionary *)factories {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __factories = [[NSMutableDictionary alloc] init];
    });
    
    return __factories;
}

+ (NSMutableDictionary *)sequences {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sequences = [[NSMutableDictionary alloc] init];
    });
    
    return __sequences;
}

+ (void)defineFactoryForClass:(Class)class withBlock:(MFFactoryBlock)block {
    [self defineFactoryForClass:class named:[class description] withBlock:block];
}

+ (void)defineFactoryForClass:(Class)class named:(NSString *)name withBlock:(MFFactoryBlock)block {
    MFFactory *factory = [[[MFFactory alloc] initWithName:name class:class block:block] autorelease];
    [__factories setObject:factory forKey:name];
}

+ (id)objectOfClass:(Class)class {
    return [MFFactory objectWithFactoryName:[class description]];
}

+ (id)objectWithFactoryName:(NSString *)name {
    MFFactory *factory = [__factories objectForKey:name];
    factory.factoryBlock(factory);
    return factory.subject;
}

+ (void)reset {
    [__factories removeAllObjects];
    [__sequences removeAllObjects];
}

#pragma mark - Instance methods

- (id)initWithName:(NSString *)name class:(Class)class block:(MFFactoryBlock)block {
    self = [super init];
    if (self) {
        self.factoryName = name;
        self.factoryClass = class;
        self.factoryBlock = block;
    }
    
    return self;
}

- (void)dealloc {
    [_subject release];
    [_factoryName release];
    [_factoryClass release];
    Block_release(_factoryBlock);
    
    [super dealloc];
}

- (id)buildSubject {
    id instance = [[self.factoryClass alloc] init];
    return instance;
}

- (id)subject {
    if (!_subject) {
        [self setSubject:[self buildSubject]];
    }
    
    return _subject;
}

- (void)sequenceFor:(NSString *)propertyName do:(SequenceBlock)sequenceBlock {
    NSString *key = [NSString stringWithFormat:@"%@:%@", [self factoryName], propertyName];
    int number;
    if ([[MFFactory sequences] objectForKey:key]) {
        NSNumber *num = [[MFFactory sequences] objectForKey:key];
        number = [num intValue];
    } else {
        number = 1;
    }
    
    NSString *formatString = sequenceBlock(number);
    NSString *value = [NSString stringWithFormat:formatString, number];
    [self.subject setValue:value forKey:propertyName];
    
    NSNumber *nextSequenceNumber = [NSNumber numberWithInt:number + 1];
    [[MFFactory sequences] setObject:nextSequenceNumber forKey:key];
}

#pragma mark - Message Forwarding to Subject

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    if (![self respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self.subject];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }
    
    return [self.factoryClass instanceMethodSignatureForSelector:aSelector];
}

@end
