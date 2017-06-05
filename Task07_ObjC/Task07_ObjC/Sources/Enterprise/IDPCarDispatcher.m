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

#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"
#import "NSTimer+IDPExtensions.h"

IDPStaticConstant(NSUInteger, IDPCarsQuantity, 10)

@interface IDPCarDispatcher ()
@property (nonatomic, retain) NSTimer       *timer;
@property (nonatomic, retain) IDPEnterprise *enterprise;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.timer = nil;
    self.enterprise = nil;
    
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

#pragma mark -
#pragma mark Public

- (void)setupTimer {
    self.timer = [NSTimer scheduledTimerWithInterval:2.0f
                                              target:self
                                            selector:@selector(addCars)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)addCars {
    [self.enterprise washCars:[IDPCar objectsWithCount:IDPCarsQuantity]];
}

@end
