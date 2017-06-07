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
    self.carsQueue = [IDPQueue object];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
    self.washers = [NSArray array];
    [self assignWorkers];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSArray *)washers {
    if (washers == _washers) {
        return;
    }
    
    NSArray *observers = @[self.accountant, self, self.director];
    
    for (IDPWorker *washer in _washers) {
        [washer removeObservers:observers];
    }
    
    [washers retain];
    [_washers release];
    _washers = washers;
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
    IDPCar *car = [self.carsQueue popObject];
    
    if (car) {
        [washer processObject:car];
    }
}

#pragma mark -
#pragma mark Private

- (void)assignWorkers {
    IDPAccountant *accountant = self.accountant;
    NSArray *observers = @[self.accountant, self];
    
    self.washers = [NSArray objectsWithCount:IDPWashersQuantity factoryBlock:^{
        IDPWasher *washer = [IDPWasher object];
        [washer addObservers:observers];
        
        return washer;
    }];
    
    [accountant addObserver:self.director];
}

- (NSArray *)freeWashers {
    @synchronized (self) {
        return [self.washers filteredArrayWithBlock:^BOOL(IDPWorker *washer) {
            return washer.state == IDPWorkerReadyForWork;
        }];
    }
}

- (IDPQueue *)addCarsToQueue:(NSArray *)cars {
    IDPQueue *result = self.carsQueue;
    
    for (IDPCar *car in cars) {
        [result pushObject:car];
    }
    
    return result;
}

@end
