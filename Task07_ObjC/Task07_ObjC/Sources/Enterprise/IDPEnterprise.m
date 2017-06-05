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

@interface IDPEnterprise ()
@property (nonatomic, retain) NSArray           *washers;
@property (nonatomic, retain) IDPQueue          *carsQueue;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;

@end

@implementation IDPEnterprise

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.washers = nil;
    self.carsQueue = nil;
    self.accountant = nil;
    self.director = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washers = [NSArray array];
    self.carsQueue = [IDPQueue object];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
    [self assignWorkers];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setCars:(IDPQueue *)cars {
    if (cars != _carsQueue) {
        _carsQueue = [cars retain];
    }
}

- (void)setWashers:(NSArray *)washers {
    @synchronized (self) {
        for (IDPWasher *washer in _washers) {
            [washer addObserver:self.accountant];
        }
        
        [washers retain];
        [_washers release];
        _washers = washers;
    }
}

#pragma mark -
#pragma mark Public

// entry point
- (void)washCars:(NSArray *)cars {
    IDPQueue *carQueue = [self addCarsToQueue:cars];
    
    NSArray *washers = [self freeWashers];
    
    for (IDPWasher *washer in washers) {
        [washer processObject:[carQueue popObject]];
    }
    
    self.carsQueue = carQueue;
}

#pragma mark -
#pragma mark WorkerObserver methods
- (void)workerDidBecomeReadyForWork:(IDPWorker *)washer {
    @synchronized (self) {
        IDPCar *car = [self.carsQueue popObject];
        
        if (car) {
            [washer processObject:car];
        }
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

- (NSArray *)freeWashers {
    return [self.washers filteredArrayWithBlock:^BOOL(IDPWorker *washer) {
        return washer.state == IDPWorkerReadyForWork;
    }];
}

- (IDPQueue *)addCarsToQueue:(NSArray *)cars {
        IDPQueue *result = self.carsQueue;
        
        for (IDPCar *car in cars) {
            [result pushObject:car];
        }
        
        return result;
}

@end
