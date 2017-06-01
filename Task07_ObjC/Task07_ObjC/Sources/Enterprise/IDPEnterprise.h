//
//  IDPEnterprise.h
//  Task03_ObjC
//
//  Created by Admin on 09.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMoneyFlow.h"
#import "IDPWorkerObserver.h"

@class IDPCar;
@class IDPQueue;

@interface IDPEnterprise : NSObject <IDPWorkerObserver>

- (void)washCars:(NSArray *)cars;

@end
