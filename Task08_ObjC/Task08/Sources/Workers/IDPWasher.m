//
//  CarWasher.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPWasher.h"
#import "IDPCar.h"

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
    //usleep(1000 * arc4random_uniform(10));
    NSLog(@"Car is clean! %@ -> %@", car, self);
}

- (void)performWorkWithObject:(id)car {
    self.car = car;
    [self washCar:car];
    self.car = nil;
}

- (void)finishedProcessingObject:(IDPCar *)car {
    car.state = IDPCarClean;
}

@end
