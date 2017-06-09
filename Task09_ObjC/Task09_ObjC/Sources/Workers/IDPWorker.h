//
//  Worker.h
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObservableObject.h"

#import "IDPMoneyFlow.h"
#import "IDPWorkerObserver.h"

typedef NS_ENUM(NSUInteger, IDPWorkerState) {
    IDPWorkerReadyForWork,
    IDPWorkerBusy,
    IDPWorkerReadyForProcessing
};

@class IDPQueue;

@interface IDPWorker : IDPObservableObject <IDPMoneyFlow, IDPWorkerObserver>
@property (nonatomic, readonly) NSUInteger    salary;
@property (nonatomic, readonly) NSUInteger    experience;
@property (nonatomic, readonly) NSUInteger    cash;
@property (nonatomic, readonly) IDPQueue      *workers;

- (void)processObject:(id<IDPMoneyFlow>)object;

@end
