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

#import "IDPGCD.h"
#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

IDPStaticConstant(NSUInteger, IDPCarsQuantity, 10)
IDPStaticConstant(NSTimeInterval, IDPTimerInterval, 1.0f)

@interface IDPCarDispatcher ()
@property (nonatomic, retain) IDPEnterprise     *enterprise;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.enterprise = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.enterprise = [IDPEnterprise object];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setRunning:(BOOL)running {
    if (running == _running) {
        return;
    }
    
    _running = running;
    
    if (running) {
        [self start];
    }
}

#pragma mark -
#pragma mark Private

- (void)start {
    IDPDispatchAsyncInBackgroundOnInterval(IDPTimerInterval, ^(void){
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
    self.running = NO;
}

- (void)addCars {
    [self.enterprise washCars:[IDPCar objectsWithCount:IDPCarsQuantity]];
}

@end
