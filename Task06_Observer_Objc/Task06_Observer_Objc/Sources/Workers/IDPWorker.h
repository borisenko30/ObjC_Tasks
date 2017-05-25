//
//  Worker.h
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMoneyFlow.h"
#import "IDPWorkerDelegate.h"

typedef NS_ENUM(NSUInteger, IDPWorkerState) {
    IDPWorkerReadyForWork,
    IDPWorkerBusy,
    IDPWorkerReadyForProcessing
};

@interface IDPWorker : NSObject <IDPMoneyFlow, IDPWorkerDelegate>
@property (nonatomic, readonly)   NSUInteger        salary;
@property (nonatomic, readonly)   NSUInteger        experience;
@property (nonatomic, readonly)   IDPWorkerState    state;
@property (nonatomic, readonly)   NSUInteger        cash;

@property (nonatomic, assign) id<IDPWorkerDelegate> delegate;

- (void)performWorkWithObject:(id<IDPMoneyFlow>)object;
- (void)processObject:(id<IDPMoneyFlow>)object;

@end
