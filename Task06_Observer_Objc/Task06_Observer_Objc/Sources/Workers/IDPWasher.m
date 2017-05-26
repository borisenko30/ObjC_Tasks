//
//  CarWasher.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPWasher.h"
#import "IDPCar.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPWasher ()
@property (nonatomic, retain) IDPCar *car;

@end

@implementation IDPWasher

#pragma mark -
#pragma mark Initializations and deallocations

- (void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma Public

- (void)washCar:(IDPCar *)car {
    NSLog(@"Car is clean!");
    car.state = IDPCarClean;
}

- (void)performWorkWithObject:(id)car {
    self.car = car;
    [self washCar:car];
    self.car = nil;
}

@end
