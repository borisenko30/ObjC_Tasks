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
#pragma Private declarations

@interface IDPWorker ()
@property (nonatomic, assign) NSUInteger cash;

@end

@implementation IDPWorker

#pragma mark -
#pragma Initializations

- (instancetype)init {
    self = [super init];
    self.state = IDPWorkerFree;
    
    return self;
}

#pragma mark -
#pragma Public

- (NSUInteger)giveMoney {
    NSUInteger money = self.cash;
    self.cash = 0;
    [self delegatingObject:self didGiveMoney:YES];
    
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

#pragma mark -
#pragma IDPWorkerDelegate methods

- (void)processObject:(id<IDPMoneyFlow>)object {
    self.state = IDPWorkerBusy;
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    self.state = IDPWorkerFree;
}

- (void)delegatingObject:(id<IDPWorkerDelegate>)object didGiveMoney:(BOOL)moneyGiven {
    if (moneyGiven) {
        [object.delegate processObject:object];
    }
}

@end
