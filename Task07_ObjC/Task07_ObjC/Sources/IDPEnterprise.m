//
//  IDPEnterprise.m
//  Task03_ObjC
//
//  Created by Admin on 09.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPEnterprise.h"

#import "IDPWorker.h"
#import "IDPCarWasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPCar.h"

#import "IDPMacros.h"
#import "IDPRandom.h"
#import "IDPConstants.h"

#import "NSObject+IDPExtensions.h"
#import "NSMutableArray+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

//IDPStaticConstantRange(IDPCarWashersQuantityRange, 1, 5)

#pragma mark -
#pragma mark Private declarations

@interface IDPEnterprise ()
@property (nonatomic, retain) NSArray           *carWashers;
@property (nonatomic, retain) NSArray           *cars;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;

@end

@implementation IDPEnterprise

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.carWashers = nil;
    self.cars = nil;
    self.accountant = nil;
    self.director = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.carWashers = [NSArray array];
    self.cars = [IDPCar objectsWithCount:IDPMaxArrayLength];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
    [self assignWorkers];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)startWorking { 
    for (IDPCarWasher *washer in self.carWashers) {
        [washer performSelectorInBackground:@selector(notifyObservers) withObject:nil];
        //[washer notifyObservers];
    }
}

#pragma mark -
#pragma mark Observer

- (void)objectIsReadyForWork:(IDPCarWasher *)washer {
    //@synchronized (self) {
    IDPCar *car = [self dirtyCar];
    if (!car) {
        return;
    }
    [washer processObject:car];
    washer.state = IDPWorkerReadyForProcessing;
    //}
}

#pragma mark -
#pragma mark Private

- (void)assignWorkers {
    self.carWashers = [NSArray objectsWithCount:IDPMaxArrayLength factoryBlock:^{
        IDPCarWasher *washer = [IDPCarWasher object];
        [washer addObserver:self];
        [washer addObserver:self.accountant];
        return washer;
    }];
    
    [self.accountant addObserver:self.director];
}

- (IDPCar *)dirtyCar {
    return [[self.cars filteredArrayWithBlock:^BOOL(IDPCar *car) {
        return car.state == IDPCarDirty;
    }] firstObject];
}

@end
