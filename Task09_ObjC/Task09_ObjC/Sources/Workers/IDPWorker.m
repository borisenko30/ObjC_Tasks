//
//  Worker.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPWorker.h"
#import "IDPCar.h"
#import "IDPQueue.h"

#import "IDPGCD.h"
#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"

@interface IDPWorker ()
@property (nonatomic, assign) NSUInteger  salary;
@property (nonatomic, assign) NSUInteger  experience;
@property (nonatomic, assign) NSUInteger  cash;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Public

// should be overriden in subclasses
- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    
}

- (void)processObject:(id)object {
    self.state = IDPWorkerBusy;
    [self processObjectWithGCD:object];
}

#pragma mark -
#pragma mark Private

- (void)processObjectWithGCD:(id)object {
    IDPDispatchAsyncInBackground(^{
        [self takeMoneyFromObject:object];
        [self performWorkWithObject:object];
        
        IDPDispatchOnMainQueue(^{
            [self finishedProcessingObject:object];
            [self finishedWork];
        });
    });
}

- (void)finishedWork {
    self.state = IDPWorkerReadyForProcessing;
}

- (void)finishedProcessingObject:(IDPWorker *)worker {
    worker.state = IDPWorkerReadyForWork;
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPWorkerReadyForWork:
            return @selector(workerDidBecomeReadyForWork:);
        case IDPWorkerBusy:
            return @selector(workerDidBecomeBusy:);
        case IDPWorkerReadyForProcessing:
            return @selector(workerDidBecomeReadyForProcessing:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark IDPMoneyFlow methods

- (NSUInteger)giveMoney {
    @synchronized (self) {
        NSUInteger money = self.cash;
        self.cash = 0;
        
        return money;
    }
}

- (void)takeMoney:(NSUInteger)money {
    @synchronized (self) {
        self.cash += money;
    }
}

- (void)takeMoneyFromObject:(id<IDPMoneyFlow>)object {
    [self takeMoney:[object giveMoney]];
}

@end
