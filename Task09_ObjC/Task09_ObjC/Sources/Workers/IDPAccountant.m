//
//  Accountant.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPAccountant.h"

#import "IDPRandom.h"

@implementation IDPAccountant

#pragma mark -
#pragma mark Public

- (void)countMoney {
    //usleep(1000 * arc4random_uniform(5));
    NSLog(@"Counted money: %lu", self.cash);
}

- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    //NSLog(@"Got money from: %@", object);
    [self countMoney];
}

@end
