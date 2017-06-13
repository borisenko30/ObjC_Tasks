//
//  IDPDispathchQueue.m
//  Task09_ObjC
//
//  Created by Student003 on 6/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPGCD.h"

#import "IDPMacros.h"

IDPStaticConstant(NSString *, IDPQueueName, @"IDPSerialQueue")


static void IDPDispatchQueue(dispatch_queue_t queue, IDPBlock block) {
    dispatch_after(0, queue, block);
}

static void IDPDispatchQueueWithType(BOOL async, qos_class_t priority, IDPBlock block) {
    dispatch_queue_t queue;
    if (async) {
        queue = dispatch_get_global_queue(priority, 0);
    }
    else {
        queue = dispatch_queue_create([IDPQueueName cStringUsingEncoding:NSUTF8StringEncoding],
                                                       DISPATCH_QUEUE_SERIAL);
    }

    IDPDispatchQueue(queue, block);
}

void IDPDispatchOnMainQueue(IDPBlock block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        IDPDispatchQueue(dispatch_get_main_queue(), block);
    }
}

// dipatch async queue on time interval
void IDPDispatchAsyncInBackgroundOnInterval(NSTimeInterval interval, IDPBlock block) {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), block);
}

// dispatch asynchronous queues
void IDPDispatchAsyncInBackground(IDPBlock block) {
    IDPDispatchQueueWithType(YES, QOS_CLASS_BACKGROUND, block);
}

void IDPDispatchAsyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchQueueWithType(YES, QOS_CLASS_UTILITY, block);
}

void IDPDispatchAsyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchQueueWithType(YES, QOS_CLASS_USER_INITIATED, block);
}

void IDPDispatchAsyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchQueueWithType(YES, QOS_CLASS_USER_INTERACTIVE, block);
}

void IDPDispatchAsyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchQueueWithType(YES, QOS_CLASS_DEFAULT, block);
}

// dispatch synchronous queues
void IDPDispatchSyncInBackground(IDPBlock block) {
    IDPDispatchQueueWithType(NO, QOS_CLASS_BACKGROUND, block);
}

void IDPDispatchSyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchQueueWithType(NO, QOS_CLASS_UTILITY, block);
}

void IDPDispatchSyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchQueueWithType(NO, QOS_CLASS_USER_INITIATED, block);
}

void IDPDispatchSyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchQueueWithType(NO, QOS_CLASS_USER_INTERACTIVE, block);
}

void IDPDispatchSyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchQueueWithType(NO, QOS_CLASS_DEFAULT, block);
}
