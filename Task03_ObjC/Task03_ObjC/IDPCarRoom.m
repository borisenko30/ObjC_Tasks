//
//  IDPCarRoom.m
//  Task03_ObjC
//
//  Created by Admin on 07.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPCarRoom.h"
#import "IDPCar.h"

#import "NSMutableArray+IDPExtensions.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPCarRoom ()
@property (nonatomic, retain) NSMutableArray *mutableCars;

@end

@implementation IDPCarRoom

@dynamic cars;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableCars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableCars = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)addCar:(IDPCar *)car {
    [self.mutableCars safeAddObject:car];
}

- (void)removeCar:(IDPCar *)car {
    [self.mutableCars removeObject:car];
}

#pragma mark -
#pragma mark Private

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

@end
