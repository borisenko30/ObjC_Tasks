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
@property (nonatomic, assign) NSUInteger cash;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializations

- (instancetype)init {
    self = [super init];
    self.state = IDPWorkerFree;
    
    return self;
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

#pragma mark -
#pragma mark IDPWorkerDelegate methods

- (void)processObject:(id<IDPMoneyFlow>)object {
    self.state = IDPWorkerBusy;
    [self takeMoneyFromObject:object];
    [self performWorkWithObject:object];
    [self delegatingObjectDidGetMoney:self];
    self.state = IDPWorkerFree;
}

- (void)delegatingObjectDidGetMoney:(id<IDPWorkerDelegate>)object; {
        [object.delegate processObject:object];
}

@end
