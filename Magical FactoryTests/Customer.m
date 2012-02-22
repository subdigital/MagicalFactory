//
//  Customer.m
//  Magical Factory
//
//  Created by Ben Scheirman on 2/21/12.
//  Copyright (c) 2012 Fickle Bits. All rights reserved.
//

#import "Customer.h"

@implementation Customer

@synthesize name = _name;
@synthesize email = _email;
@synthesize status = _status;

- (void)dealloc {
    [_name release];
    [_email release];
    [super dealloc];
}

@end
