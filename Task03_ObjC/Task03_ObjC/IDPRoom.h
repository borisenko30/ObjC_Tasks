//
//  IDPRoom.h
//  Task03_ObjC
//
//  Created by Admin on 07.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPBuilding.h"

@class IDPWorker;

@interface IDPRoom : IDPBuilding
@property (nonatomic, readonly, copy) NSArray *workers;

- (void)addWorker:(IDPWorker *)worker;
- (void)removeWorker:(IDPWorker *)worker;

- (NSArray *)workersWithClass:(Class)workerClass;

@end
