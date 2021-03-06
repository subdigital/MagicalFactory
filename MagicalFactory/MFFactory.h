//
//  Magical_Factory.h
//  Magical Factory
//
//  Created by Ben Scheirman on 2/21/12.
//  Copyright (c) 2012 Fickle Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MFFactory;

typedef void (^MFFactoryBlock)(MFFactory *);
typedef NSString * (^SequenceBlock)(int i);

@interface MFFactory : NSObject


/* The name of the factory, which is used to uniquely distinguish it from other factories. */
@property (nonatomic, copy) NSString *factoryName;

/* The class of the subject */
@property (nonatomic, copy) Class factoryClass;

/*
 Defines a factory for a given class.  The factory name is implicitly defined as the name of the class.
 
 Arguments:
    class -     The class of the object that will be created
    block -     The block that will define the created object
 
 */
+ (void)defineFactoryForClass:(Class)class withBlock:(MFFactoryBlock)block;

/*
 Defines a factory for a given class.  The factory name is implicitly defined as the name of the class.
 
 Arguments:
 class -     The class of the object that will be created
 name  -     The name of the factory.  Factories can be retrieved by name later on.
 block -     The block that will define the created object
 
 */
+ (void)defineFactoryForClass:(Class)class named:(NSString *)name withBlock:(MFFactoryBlock)block;

/*
 Returns a built object using the factory for the given class.
 (Note: throws an exception if this factory is not defined)
*/
+ (id)objectOfClass:(Class)class;

/*
 Returns a built object using the named factory.
 (Note: throws an exception if this factory is not defined)
 */
+ (id)objectWithFactoryName:(NSString *)name;

/* Removes all registered factories & sequences. */
+ (void)reset;

/* Returns the registered factories in a dictionary */
+ (NSMutableDictionary *)factories;

/*
 Defines a numerical sequence for the given property name.
 Arguments:
 propertyName -     The name of the property that the sequence will apply to.  Must be key-value-coding compliant for this property.
 sequenceBlock -    The block that you use to set the value of the property.  The sequence number is passed in as an argument.  You
                    must return a format string with %d in it, where the sequence number will be substituded.
 
 Example:
    [factory sequenceFor:@"foo" do:^(int i) {
        return @"foo-%d";
    }]
 */
- (void)sequenceFor:(NSString *)propertyName do:(SequenceBlock)sequenceBlock;

@end
