//
//  IDPCarWashTests.m
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/30/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPCarWashTests.h"

#import "IDPCarDispatcher.h"
#import "NSObject+IDPExtensions.h"

#import "IDPEnterprise.h"
#import "IDPCar.h"

void IDPCarWashTest() {
    IDPCarDispatcher *dispatcher = [IDPCarDispatcher object];
    dispatcher.running = YES;
}
