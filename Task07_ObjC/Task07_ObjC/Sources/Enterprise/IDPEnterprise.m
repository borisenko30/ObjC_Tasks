//
//  IDPEnterprise.m
//  Task03_ObjC
//
//  Created by Admin on 09.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPEnterprise.h"

#import "IDPWorker.h"
#import "IDPWasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPCar.h"

#import "IDPQueue.h"
#import "IDPCarDispatcher.h"

#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"
#import "NSMutableArray+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

IDPStaticConstant(NSUInteger, IDPWashersQuantity, 5)

#pragma mark -
#pragma mark Private declarations

@interface IDPEnterprise ()
@property (nonatomic, retain) NSArray           *washers;
@property (nonatomic, retain) IDPQueue          *cars;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;

@end

@implementation IDPEnterprise

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.washers = nil;
    self.cars = nil;
    self.accountant = nil;
    self.director = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washers = [NSArray array];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
    [self assignWorkers];
    [self assignCars];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSArray *)washers {
    for (IDPWasher *washer in _washers) {
        [washer addObserver:self.accountant];
    }
    
    [washers retain];
    [_washers release];
    _washers = washers;
}

#pragma mark -
#pragma mark Public

// entry point
- (void)processCars {
    for (IDPWasher *washer in self.washers) {
        [washer performSelectorInBackground:@selector(processObject:) withObject:[self.cars popObject]];
    }
}



#pragma mark -
#pragma mark WorkerObserver methods

- (void)workerDidBecomeReadyForWork:(IDPWasher *)washer {
    IDPCar *car = [self.cars popObject];
    if (car) {
        [washer processObject:car];
    }
}

#pragma mark -
#pragma mark Private

- (void)assignWorkers {
    IDPAccountant *accountant = self.accountant;
    self.washers = [NSArray objectsWithCount:IDPWashersQuantity factoryBlock:^{
        IDPWasher *washer = [IDPWasher object];
        [washer addObserver:accountant];
        [washer addObserver:self];
        
        return washer;
    }];
    
    [accountant addObserver:self.director];
}

- (void)assignCars {
    IDPCarDispatcher *dispatcher = [IDPCarDispatcher object];
    [dispatcher generateCarsWithCount:100];
    self.cars = dispatcher.cars;
}

@end
