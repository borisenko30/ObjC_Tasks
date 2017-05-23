//
//  Worker.h
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMoneyFlow.h"
#import "IDPObserver.h"
#import "IDPObservable.h"

@interface IDPWorker : NSObject <IDPMoneyFlow, IDPObserver, IDPObservable>
@property (nonatomic, readonly)   NSUInteger        salary;
@property (nonatomic, readonly)   NSUInteger        experience;
@property (nonatomic, readonly)   IDPWorkerState    state;
@property (nonatomic, readonly)   NSUInteger        cash;

- (void)performWorkWithObject:(id<IDPMoneyFlow>)object;

@end
