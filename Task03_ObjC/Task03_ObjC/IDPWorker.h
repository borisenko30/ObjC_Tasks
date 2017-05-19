//
//  Worker.h
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMoneyFlow.h"

typedef NS_ENUM(NSUInteger, IDPWorkerState) {
    IDPWorkerFree,
    IDPWorkerBusy
};

@interface IDPWorker : NSObject <IDPMoneyFlow>
@property (nonatomic, readonly)   NSUInteger        salary;
@property (nonatomic, readonly)   NSUInteger        experience;
@property (nonatomic, assign)     IDPWorkerState    state;
@property (nonatomic, readonly)   NSUInteger        cash;

- (void)processObject:(id<IDPMoneyFlow>)object;
- (void)performWorkWithObject:(id<IDPMoneyFlow>)object;

@end
