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

#import "IDPWorkerDelegate.h"

#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

IDPStaticConstant(NSUInteger, IDPWashersQuantity, 5)

#pragma mark -
#pragma mark Private declarations

@interface IDPEnterprise ()
@property (nonatomic, retain) NSArray           *washers;
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;

@end

@implementation IDPEnterprise

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.washers = nil;
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
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSArray *)washers {
    if (_washers) {
        for (IDPWasher *washer in _washers) {
            washer.delegate = nil;
        }
    }
    
    _washers = washers;
}

#pragma mark -
#pragma mark Public

- (void)processCar:(IDPCar *)car {
    IDPWasher *washer = [self freeWasher];
  
    [washer processObject:car];
}

#pragma mark -
#pragma mark Private

- (void)assignWorkers {
    IDPAccountant *accountant = self.accountant;
    self.washers = [NSArray objectsWithCount:IDPWashersQuantity factoryBlock:^{
        IDPWasher *washer = [IDPWasher object];
        washer.delegate = accountant;
        
        return washer;
    }];
    
    accountant.delegate = self.director;
}

- (IDPWasher *)freeWasher {
    NSArray *washers = [self.washers filteredArrayWithBlock:^BOOL(IDPWasher *washer) {
        return washer.state == IDPWorkerReadyForWork;
    }];
    
    return [washers firstObject];
}

@end
