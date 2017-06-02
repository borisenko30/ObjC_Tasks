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

#import "NSObject+IDPExtensions.h"

@interface IDPWorker ()
@property (nonatomic, assign) NSUInteger  salary;
@property (nonatomic, assign) NSUInteger  experience;
@property (nonatomic, assign) NSUInteger  cash;
@property (nonatomic, retain) IDPQueue    *workers;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.workers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.workers = [IDPQueue object];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)setState:(NSUInteger)state {
    [super setState:state];
    
    id object = [self.workers popObject];
    if (object) {
        [self processObject:object];
    }
}

// should be overriden in subclasses
- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    
}

- (void)performWorkWithObjectInBackground:(id)object {
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    [self performSelectorOnMainThread:@selector(performWorkWithObjectOnMain:)
                           withObject:object
                        waitUntilDone:NO];
}

- (void)performWorkWithObjectOnMain:(id)object {
    [self finishedProcessingObject:object];
    
    IDPQueue *queue = self.workers;
    @synchronized (self) {
        id queueObject = [queue popObject];
        
        if (queueObject) {
            [self performSelectorInBackground:@selector(performWorkWithObjectInBackground:)
                                   withObject:queueObject];
        } else {
            [self finishedWork];
        }
    }
}

- (void)processObject:(id)object {
    @synchronized (self) {
        if (self.state == IDPWorkerReadyForWork) {
            self.state = IDPWorkerBusy;
            [self performSelectorInBackground:@selector(performWorkWithObjectInBackground:)
                                   withObject:object];
        } else {
            [self.workers pushObject:object];
        }
    }
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

#pragma mark -
#pragma mark IDPWorkerObserver methods

- (void)workerDidBecomeReadyForProcessing:(IDPWorker *)worker {
    [self processObject:worker];
}

@end
