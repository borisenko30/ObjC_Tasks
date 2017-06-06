//
//  Boss.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPDirector.h"

@interface IDPDirector ()
@property (nonatomic, assign) NSUInteger cash;

@end

@implementation IDPDirector

@dynamic cash;

#pragma mark -
#pragma mark Public

- (void)makeProfit {
    //usleep(1000 * arc4random_uniform(1000));
    NSLog(@"Boss has got some profit: %lu", self.cash);
}

- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    [self makeProfit];
}

- (void)finishedWork {
    self.state = IDPWorkerReadyForWork;
}

@end
