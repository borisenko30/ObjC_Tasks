//
//  IDPDispathchQueue.h
//  Task09_ObjC
//
//  Created by Student003 on 6/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^IDPBlock)();

extern void IDPDispatchOnMainQueue(IDPBlock block);

// dipatch async queue on time interval
extern void IDPDispatchAsyncInBackgroundOnInterval(NSTimeInterval interval, IDPBlock block);

// dispatch asynchronous queues
extern void IDPDispatchAsyncInBackground(IDPBlock block);
extern void IDPDispatchAsyncWithUtilityPriority(IDPBlock block);
extern void IDPDispatchAsyncWithInitiatedPriority(IDPBlock block);
extern void IDPDispatchAsyncWithInteractivePriority(IDPBlock block);
extern void IDPDispatchAsyncWithDefaultPriority(IDPBlock block);

// dispatch synchronous queues
extern void IDPDispatchSyncInBackground(IDPBlock block);
extern void IDPDispatchSyncWithUtilityPriority(IDPBlock block);
extern void IDPDispatchSyncWithInitiatedPriority(IDPBlock block);
extern void IDPDispatchSyncWithInteractivePriority(IDPBlock block);
extern void IDPDispatchSyncWithDefaultPriority(IDPBlock block);
