//
//  Worker.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPWorker.h"
#import "IDPCar.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPWorker ()
@property (nonatomic, assign) NSUInteger  salary;
@property (nonatomic, assign) NSUInteger  experience;
@property (nonatomic, assign) NSUInteger  cash;

@end

@implementation IDPWorker

@synthesize state = _state;

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state {
    if (_state != state) {
        _state = state;
        [self notifyOfState:state];
    }
}

#pragma mark -
#pragma mark Public

// should be overriden in subclasses
- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    
}

- (void)processObject:(id)object {
    self.state = IDPWorkerBusy;
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    [self didFinishProcessingObject:object];
    [self didFinishWork];
}

- (void)didFinishWork {
    self.state = IDPWorkerReadyForProcessing;
}

- (void)didFinishProcessingObject:(IDPWorker *)worker {
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
    NSUInteger money = self.cash;
    self.cash = 0;
    
    return money;
}

- (void)takeMoney:(NSUInteger)money {
    self.cash += money;
}

- (void)takeMoneyFromObject:(id<IDPMoneyFlow>)object {
    [self takeMoney:[object giveMoney]];
}

#pragma mark -
#pragma mark IDPWorkerObserver methods

- (void)workerDidBecomeReadyForProcessing:(IDPWorker *)worker; {
    [self processObject:worker];
}



@end
