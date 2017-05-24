//
//  Worker.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPWorker.h"
#import "IDPConstants.h"
#import "IDPEnterprise.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPWorker ()
@property (nonatomic, assign) NSUInteger        cash;
@property (nonatomic, retain) NSHashTable       *observers;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.state = IDPWorkerReadyForWork;
    self.observers = [NSHashTable weakObjectsHashTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(IDPWorkerState)state {
    if (_state != state) {
        _state = state;
        if (state != IDPWorkerBusy) {
            [self notifyObservers];
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

- (void)processObject:(id<IDPMoneyFlow>)object {
    //@synchronized (self) {
        self.state = IDPWorkerBusy;
        [self takeMoneyFromObject:object];
        [self performWorkWithObject:object];
        //sleep(IDPWorkTime);
        self.state = IDPWorkerReadyForProcessing;
    //}
}

#pragma mark -
#pragma mark IDPObservable methods

- (void)addObserver:(id)observer {
    if (observer) {
        [self.observers addObject:observer];
    }
}

- (void)removeObserver:(id)observer {
    [self.observers removeObject:observer];
}

- (void)notifyObservers {
    for (id<IDPObserver> observer in self.observers) {
        switch (self.state) {
            case IDPWorkerReadyForWork:
                if ([observer isKindOfClass:[IDPEnterprise class]]) {
                    [observer objectIsReadyForWork:self];
                }
                break;
            case IDPWorkerReadyForProcessing:
                if ([observer isKindOfClass:[IDPWorker class]]) {
                    [observer objectIsReadyForProcessing:self];
                }
                break;
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark IDPObserver methods

- (void)objectIsReadyForProcessing:(IDPWorker *)worker {
    //[self performSelectorInBackground:@selector(processObject:) withObject:worker];
    if (worker.cash) {
        [self processObject:worker];
        worker.state = IDPWorkerReadyForWork;
    }
}

@end
