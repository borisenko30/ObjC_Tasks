//
//  IDPDispathchQueue.m
//  Task09_ObjC
//
//  Created by Student003 on 6/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPGCD.h"

#import "IDPMacros.h"

IDPStaticConstant(NSString *, IDPQueueName, @"IDPTimerQueue")
IDPStaticConstant(CGFloat, IDPTimerInterval, 1.0f)

static void IDPDispatchQueue(dispatch_time_t time, dispatch_queue_t queue, IDPBlock block) {
    dispatch_after(time, queue, block);
}

static void IDPDispatchPriorityQueue(BOOL async, qos_class_t priority, dispatch_time_t time, IDPBlock block) {
    dispatch_queue_t queue;
    if (async) {
        queue = dispatch_get_global_queue(priority, 0);
    }
    else {
        queue = dispatch_queue_create([IDPQueueName cStringUsingEncoding:NSUTF8StringEncoding],
                                                       DISPATCH_QUEUE_SERIAL);
    }

    IDPDispatchQueue(time, queue, block);
}

void IDPDispatchOnMainQueue(IDPBlock block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        IDPDispatchQueue(0, dispatch_get_main_queue(), block);
    }
}

// dipatch async queue on time
void IDPDispatchAsyncInBackgroundOnTimer(IDPBlock block) {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, IDPTimerInterval * NSEC_PER_SEC);
    IDPDispatchPriorityQueue(YES, QOS_CLASS_BACKGROUND, time, block);
}

// dispatch asynchronous queues
void IDPDispatchAsyncInBackground(IDPBlock block) {
    IDPDispatchPriorityQueue(YES, QOS_CLASS_BACKGROUND, 0, block);
}

void IDPDispatchAsyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchPriorityQueue(YES, QOS_CLASS_UTILITY, 0, block);
}

void IDPDispatchAsyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchPriorityQueue(YES, QOS_CLASS_USER_INITIATED, 0, block);
}

void IDPDispatchAsyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchPriorityQueue(YES, QOS_CLASS_USER_INTERACTIVE, 0, block);
}

void IDPDispatchAsyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchPriorityQueue(YES, QOS_CLASS_DEFAULT, 0, block);
}

// dispatch synchronous queues
void IDPDispatchSyncInBackground(IDPBlock block) {
    IDPDispatchPriorityQueue(NO, QOS_CLASS_BACKGROUND, 0, block);
}

void IDPDispatchSyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchPriorityQueue(NO, QOS_CLASS_UTILITY, 0, block);
}

void IDPDispatchSyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchPriorityQueue(NO, QOS_CLASS_USER_INITIATED, 0, block);
}

void IDPDispatchSyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchPriorityQueue(NO, QOS_CLASS_USER_INTERACTIVE, 0, block);
}

void IDPDispatchSyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchPriorityQueue(NO, QOS_CLASS_DEFAULT, 0, block);
}
