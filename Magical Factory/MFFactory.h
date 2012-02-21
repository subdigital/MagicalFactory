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

@interface MFFactory : NSObject

/*
 Defines a factory for a given class.  The factory name is implicitly defined as the name of the class.
 
 Arguments:
    class -     The class of the object that will be created
    block -     The block that will define the created object
 
 */
+ (void)defineFactoryForClass:(Class)class_ withBlock:(MFFactoryBlock)block;

/*
 Defines a factory for a given class.  The factory name is implicitly defined as the name of the class.
 
 Arguments:
 class -     The class of the object that will be created
 name  -     The name of the factory.  Factories can be retrieved by name later on.
 block -     The block that will define the created object
 
 */
+ (void)defineFactoryForClass:(Class)class_ named:(NSString *)name withBlock:(MFFactoryBlock)block;

/*
 Returns a built object using the factory for the given class.
 (Note: throws an exception if this factory is not defined)
*/
+ (id)objectOfClass:(Class)class_;

/*
 Returns a built object using the named factory.
 (Note: throws an exception if this factory is not defined)
 */
+ (id)objectWithFactoryName:(NSString *)name;

/* Removes all registered factories. */
+ (void)removeAllFactories;

/* Returns the registered factories in a dictionary */
+ (NSMutableDictionary *)factories;

@end
