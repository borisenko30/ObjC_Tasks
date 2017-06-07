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

#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"

IDPStaticConstant(NSString *, IDPQueueName, @"WorkerQueue")

@interface IDPWorker ()
@property (nonatomic, assign) NSUInteger  salary;
@property (nonatomic, assign) NSUInteger  experience;
@property (nonatomic, assign) NSUInteger  cash;

- (void)performSelectorInBackground:(id)object;
- (void)performSelectorOnMainThread:(id)object;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Public

// should be overriden in subclasses
- (void)performWorkWithObject:(id<IDPMoneyFlow>)object {
    
}

- (void)processObject:(id)object {
    self.state = IDPWorkerBusy;
    [self performSelectorInBackground:object];
}

#pragma mark -
#pragma mark Private

- (void)performSelectorInBackground:(id)object {
    //[self performSelectorInBackground:@selector(performWorkWithObjectInBackground:)
    //                       withObject:object];
    dispatch_queue_t queue = dispatch_queue_create([IDPQueueName cStringUsingEncoding:NSUTF8StringEncoding],
                                                   DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [self performWorkWithObjectInBackground:object];
    });
    
    dispatch_release(queue);
    
}

- (void)performSelectorOnMainThread:(id)object {
//    [self performSelectorOnMainThread:@selector(performWorkWithObjectOnMain:)
//                           withObject:object
//                        waitUntilDone:NO];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performWorkWithObjectOnMain:object];
    });
    
}

- (void)performWorkWithObjectInBackground:(id)object {
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    [self performSelectorOnMainThread:object];
}

- (void)performWorkWithObjectOnMain:(id)object {
    [self finishedProcessingObject:object];
    [self finishedWork];
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
