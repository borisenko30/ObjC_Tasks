//
//  Building.m
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPBuilding.h"
#import "IDPRoom.h"
#import "IDPWorker.h"

#import "NSMutableArray+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

@end

@implementation IDPBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)addRoom:(IDPRoom *)room {
    [self.mutableRooms safeAddObject:room];
}

- (void)removeRoom:(IDPRoom *)room {
    [self.mutableRooms removeObject:room];
}

- (NSArray *)workersWithClass:(Class)workerClass {
    NSMutableArray *result = [NSMutableArray array];
    for (IDPRoom *room in self.mutableRooms) {
        [result addObjectsFromArray:[room workersWithClass:workerClass]];
    }
    
    return [[result copy] autorelease];
}

#pragma mark -
#pragma mark Private

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

@end
