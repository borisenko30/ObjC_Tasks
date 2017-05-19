//
//  IDPCarRoom.h
//  Task03_ObjC
//
//  Created by Admin on 07.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPRoom.h"

@class IDPCar;

@interface IDPCarRoom : IDPRoom
@property (nonatomic, readonly, copy) NSArray *cars;

- (void)addCar:(IDPCar *) car;
- (void)removeCar:(IDPCar *) car;

@end
