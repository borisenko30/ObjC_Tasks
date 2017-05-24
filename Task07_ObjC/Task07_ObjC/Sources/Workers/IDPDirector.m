//
//  Boss.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPDirector.h"

@implementation IDPDirector

#pragma mark -
#pragma mark Public

- (void)makeProfit {
    NSLog(@"Boss has got some profit: %lu", self.cash);
}

- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    [self makeProfit];
    self.state = IDPWorkerReadyForProcessing;
}

#pragma mark -
#pragma mark IDPObserver methods

//- (void)objectIsReadyForProcessing:(IDPWorker *)worker {
//    //[self performSelectorInBackground:@selector(processObject:) withObject:worker];
//    [self processObject:worker];
//    worker.state = IDPWorkerReadyForProcessing;
//}

@end
