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

#pragma mark -
#pragma mark Initializations and deallocations

-(void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)washCar:(IDPCar *)car {
    NSLog(@"Car is clean!");
    car.state = IDPCarClean;
}

- (void)performWorkWithObject:(id<IDPMoneyFlow>)car {
        self.car = car;
        [self washCar:car];
        self.car = nil;
}

@end
