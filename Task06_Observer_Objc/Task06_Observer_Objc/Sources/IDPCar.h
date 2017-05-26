//
//  Car.h
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMoneyFlow.h"

typedef NS_ENUM(NSUInteger, IDPCarState) {
    IDPCarClean,
    IDPCarDirty
};

@interface IDPCar : NSObject <IDPMoneyFlow>
@property (nonatomic, assign)   IDPCarState     state;
@property (nonatomic, readonly) NSUInteger      cash;

@end
