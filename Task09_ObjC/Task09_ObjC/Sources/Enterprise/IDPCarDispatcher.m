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

#import "IDPDispatchQueue.h"
#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"
#import "NSTimer+IDPExtensions.h"

IDPStaticConstant(NSUInteger, IDPCarsQuantity, 10)
IDPStaticConstant(size_t, IDPTimerIterationCount, 10)
IDPStaticConstant(NSString *, IDPTimerQueue, @"IDPTimerQueue")

@interface IDPCarDispatcher ()
@property (nonatomic, retain) NSTimer           *timer;
@property (nonatomic, retain) IDPEnterprise     *enterprise;
@property (nonatomic, retain) dispatch_queue_t  queue;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.timer = nil;
    self.enterprise = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.enterprise = [IDPEnterprise object];
    self.timer = [[NSTimer new] autorelease];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setTimer:(NSTimer *)timer {
    if (timer != _timer) {
        [_timer invalidate];
        [_timer release];
        
        _timer = [timer retain];
    }
}

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
    self.queue = dispatch_queue_create([IDPTimerQueue cStringUsingEncoding:NSUTF8StringEncoding],
                                       DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = self.queue;
    
    dispatch_apply(IDPTimerIterationCount, queue, ^(size_t count) {
        [self startInBackground];
    });
}

- (void)startInBackground {
    IDPDispatchQueueInBackgroundWithBlock(^{
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
