//
//  Car.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPCar.h"
#import "IDPWorker.h"

#import "IDPMacros.h"
#import "IDPRandom.h"

IDPStaticConstantRange(IDPCashAmountRange, 10, 0)

@interface IDPCar ()
@property (nonatomic, assign) NSUInteger cash;

@end

@implementation IDPCar

#pragma mark -
#pragma mark Initializations

- (instancetype)init {
    self = [super init];
    self.state = IDPCarDirty;
    self.cash = IDPRandomWithRange(IDPCashAmountRange);
    
    return self;
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

@end
