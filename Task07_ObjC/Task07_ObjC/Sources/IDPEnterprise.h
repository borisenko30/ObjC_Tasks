//
//  IDPEnterprise.h
//  Task03_ObjC
//
//  Created by Admin on 09.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMoneyFlow.h"
#import "IDPObserver.h"

@class IDPCar;

@interface IDPEnterprise : NSObject <IDPObserver>

- (void)processCar:(IDPCar *)car;

@end
