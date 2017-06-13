//
//  main.m
//  Task06_ObjC
//
//  Created by Student003 on 5/17/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPCar.h"
#import "IDPEnterprise.h"

#import "IDPConstants.h"

#import "NSObject+IDPExtensions.h"

#import "IDPCarWashTests.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        IDPCarWashTest();

        NSRunLoop *runLoop = [NSRunLoop mainRunLoop];
        [runLoop run];
    }
    
    return 0;
}
