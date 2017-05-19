//
//  IDPRoom.m
//  Task03_ObjC
//
//  Created by Admin on 07.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPRoom.h"
#import "IDPWorker.h"

#import "NSMutableArray+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPRoom ()
@property (nonatomic, retain) NSMutableArray *mutableWorkers;

@end

@implementation IDPRoom

@dynamic workers;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableWorkers = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)addWorker:(IDPWorker *)worker {
    [self.mutableWorkers safeAddObject:worker];
}

- (void)removeWorker:(IDPWorker *)worker {
    [self.mutableWorkers removeObject:worker];
}

- (NSArray *)workersWithClass:(Class)workerClass {
    return [self.mutableWorkers filteredArrayWithBlock:^BOOL(id object) {
        return [object isKindOfClass:workerClass];
    }];
}

#pragma mark -
#pragma mark Private

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
}

@end
