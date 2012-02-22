//
//  Customer.h
//  Magical Factory
//
//  Created by Ben Scheirman on 2/21/12.
//  Copyright (c) 2012 Fickle Bits. All rights reserved.
//

typedef enum {
    CustomerStatusNormal = 1,
    CustomerStatusDelinquent
} CustomerStatus;

@interface Customer : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic) CustomerStatus status;

@end
