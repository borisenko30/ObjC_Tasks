//
//  IDPCarWashTests.m
//  Task03_ObjC
//
//  Created by Admin on 07.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPCarWashTests.h"

#import "IDPEnterprise.h"
#import "IDPCar.h"

#import "IDPConstants.h"

#import "NSObject+IDPExtensions.h"

void IDPCarWashTest() {
    NSArray *cars = [IDPCar objectsWithCount:IDPMaxArrayLength];
    IDPEnterprise *enterprise = [IDPEnterprise object];
    for (IDPCar *car in cars ) {
        [enterprise processCar:car];
        NSLog(@"-----------------------");
    }
}
