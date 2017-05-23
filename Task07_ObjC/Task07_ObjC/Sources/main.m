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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *cars = [IDPCar objectsWithCount:IDPMaxArrayLength];
        IDPEnterprise *enterprise = [IDPEnterprise object];
        for (IDPCar *car in cars ) {
            [enterprise processCar:car];
            NSLog(@"-----------------------");
        }
    }
    
    return 0;
}
