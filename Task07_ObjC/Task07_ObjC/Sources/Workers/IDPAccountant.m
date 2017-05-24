//
//  Accountant.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPAccountant.h"

@implementation IDPAccountant

#pragma mark -
#pragma mark Public

- (void)countMoney {
    NSLog(@"Counted money: %lu", self.cash);
}

- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    @synchronized (self) {
        [self countMoney];
    }
}

@end
