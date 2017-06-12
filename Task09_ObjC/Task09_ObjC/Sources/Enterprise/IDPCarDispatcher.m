//
//  IDPCarFlow.m
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/30/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPCarDispatcher.h"

#import "IDPEnterprise.h"
#import "IDPCar.h"
#import "IDPQueue.h"
#import "IDPTimerProxy.h"

#import "IDPGCD.h"
#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

IDPStaticConstant(NSUInteger, IDPCarsQuantity, 10)
IDPStaticConstant(NSString *, IDPTimerQueue, @"IDPTimerQueue")
IDPStaticConstant(CGFloat, IDPTimerInterval, 1.0f)

@interface IDPCarDispatcher ()
@property (nonatomic, retain) IDPEnterprise     *enterprise;
@property (nonatomic, retain) dispatch_queue_t  queue;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.enterprise = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.enterprise = [IDPEnterprise object];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(dispatch_queue_t)queue {
    if (queue == _queue) {
        return;
    }
    
    if (queue) {
        dispatch_retain(queue);
    }
    
    if (_queue) {
        dispatch_release(_queue);
    }
    
    _queue = queue;
}

- (void)setRunning:(BOOL)running {
    if (running == _running) {
        return;
    }
    
    if (running) {
        [self start];
    } else {
        [self stop];
    }
    
    _running = running;
}

#pragma mark -
#pragma mark Private

- (void)start {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, IDPTimerInterval * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^(void){
        [self startInBackground];
        if (self.running) {
            [self start];
        }
    });
}

- (void)startInBackground {
    IDPDispatchAsyncInBackground(^{
        [self addCars];
    });
}

- (void)stop {
    self.queue = nil;
}

- (void)addCars {
    [self.enterprise washCars:[IDPCar objectsWithCount:IDPCarsQuantity]];
}

@end
