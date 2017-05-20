//
//  CarWasher.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPCarWasher.h"
#import "IDPCar.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPCarWasher ()
@property (nonatomic, retain) IDPCar *car;

@end

@implementation IDPCarWasher

@synthesize cash = _cash;

#pragma mark -
#pragma mark Initializations and deallocations

-(void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma Public

- (void)setCash:(NSUInteger)cash {
    _cash = cash;
    if (cash) {
        [self delegatingObjectDidGetMoney:self];
    }
}

- (void)washCar:(IDPCar *)car {
    NSLog(@"Car is clean!");
    car.state = IDPCarClean;
}

- (void)performWorkWithObject:(id)car {
        self.car = car;
        [self washCar:car];
        self.car = nil;
}

#pragma mark -
#pragma mark IDPWorkerDelegate methods

// carWasher overrides parent method to perform work before taking money
- (void)processObject:(id<IDPMoneyFlow>)object {
    self.state = IDPWorkerBusy;
    [self performWorkWithObject:object];
    [self takeMoneyFromObject:object];
    self.state = IDPWorkerFree;
}

@end
