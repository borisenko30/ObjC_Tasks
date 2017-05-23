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
@property (nonatomic, retain) IDPAccountant     *accountant;
@property (nonatomic, retain) IDPDirector       *director;

@end

@implementation IDPEnterprise

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.carWashers = nil;
    self.accountant = nil;
    self.director = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.carWashers = [NSArray array];
    [self assignWorkers];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)processCar:(IDPCar *)car {
    IDPCarWasher *carWasher = [self freeCarWasher];
    IDPAccountant *accountant = self.accountant;
    IDPDirector *director = self.director;
    
    [carWasher addObserver:accountant];
    [accountant addObserver:director];
  
    [carWasher processObject:car];
}

#pragma mark -
#pragma mark Private

- (void)assignWorkers {
    //self.carWashers = [NSArray objectsWithCount:IDPRandomWithRange(IDPCarWashersQuantityRange) factoryBlock:^{
    self.carWashers = [NSArray objectsWithCount:IDPRandom(IDPMaxArrayLength) factoryBlock:^{
        return [IDPCarWasher object];
    }];
    self.accountant = [IDPAccountant object];
    self.director = [IDPDirector object];
}

- (IDPCarWasher *)freeCarWasher {
    NSArray *carWashers = self.carWashers;
    carWashers = [carWashers filteredArrayWithBlock:^BOOL(IDPCarWasher *carWasher) {
        return carWasher.state == IDPWorkerFree;
    }];
    
    return [carWashers firstObject];
}

#pragma mark -
#pragma mark Observer

- (void)objectIsReadyForWork:(id)object {
    
}

@end
