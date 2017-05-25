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
@property (nonatomic, assign) NSUInteger        cash;
@property (nonatomic, assign) IDPWorkerState    state;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializations

- (void)dealloc {
    self.delegate = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.state = IDPWorkerReadyForWork;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(IDPWorkerState)state {
    if (_state != state) {
        _state = state;
        if (state == IDPWorkerReadyForProcessing) {
            [self.delegate workerDidBecomeReadyForProcessing:self];
        }
    }
}

#pragma mark -
#pragma mark Public

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

// should be overriden in subclasses
- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    
}

- (void)processObject:(id)object {
    self.state = IDPWorkerBusy;
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    [self workerDidFinishWork];
    [self workerIsReadyForWork:object];
}

- (void)workerDidFinishWork {
    self.state = IDPWorkerReadyForProcessing;
}

- (void)workerIsReadyForWork:(IDPWorker *)worker {
    worker.state = IDPWorkerReadyForWork;
}

#pragma mark -
#pragma mark IDPWorkerDelegate methods

- (void)workerDidBecomeReadyForProcessing:(IDPWorker *)worker; {
    [self processObject:worker];
}

@end
