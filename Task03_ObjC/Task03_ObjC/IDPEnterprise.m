//
//  IDPEnterprise.m
//  Task03_ObjC
//
//  Created by Admin on 09.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPEnterprise.h"
#import "IDPBuilding.h"
#import "IDPRoom.h"
#import "IDPCarRoom.h"

#import "IDPCarWasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPCar.h"

#import "NSObject+IDPExtensions.h"
#import "NSMutableArray+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPEnterprise ()
@property (nonatomic, retain) NSMutableArray *buildings;

@end

@implementation IDPEnterprise

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.buildings = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.buildings = [NSMutableArray array];
    [self buildHierarchy];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)processCar:(IDPCar *)car {
    IDPCarWasher *carWasher = [self freeWorkerWithClass:[IDPCarWasher class]];
    [carWasher processObject:car];
        
    IDPAccountant *accountant = [self freeWorkerWithClass:[IDPAccountant class]];
    [accountant processObject:carWasher];
        
    IDPDirector *director = [self freeWorkerWithClass:[IDPDirector class]];
    [director processObject:accountant];
}

#pragma mark -
#pragma mark Private

- (void)buildHierarchy {
    IDPBuilding *office = [IDPBuilding object];
    [self addBuilding:office];
    IDPRoom *room = [IDPRoom object];
    [office addRoom:room];
    
    IDPBuilding *carWash = [IDPBuilding object];
    [self addBuilding:carWash];
    IDPCarRoom *carRoom = [IDPCarRoom object];
    [carWash addRoom:carRoom];
    
    [room addWorker:[IDPAccountant object]];
    [room addWorker:[IDPDirector object]];
    [carRoom addWorker:[IDPCarWasher object]];
}

- (void)addBuilding:(IDPBuilding *)building {
    [self.buildings safeAddObject:building];
}

- (void)removeBuilding:(IDPBuilding *)building {
    [self.buildings removeObject:building];
}

- (NSArray *)workersWithClass:(Class)workerClass {
    NSMutableArray *result = [NSMutableArray array];
    for (IDPBuilding *building in self.buildings) {
        [result addObjectsFromArray:[building workersWithClass:workerClass]];
    }
    
    return [[result copy] autorelease];
}

- (id)freeWorkerWithClass:(Class)workerClass {
    NSArray *workers = [self workersWithClass:workerClass];
    workers = [workers filteredArrayWithBlock:^BOOL(IDPWorker *worker) {
        return worker.state == IDPWorkerFree;
    }];
    
    return [workers firstObject];
}

@end
