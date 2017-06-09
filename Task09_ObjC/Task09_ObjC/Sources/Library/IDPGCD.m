//
//  IDPDispathchQueue.m
//  Task09_ObjC
//
//  Created by Student003 on 6/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPGCD.h"

// dispatch asynchronous queues
static void IDPDispatchAsyncOnGlobalQueue(unsigned int priority, IDPBlock block) {
    dispatch_async(dispatch_get_global_queue(priority, 0), block);
}

void IDPDispatchAsyncOnMainQueue(IDPBlock block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void IDPDispatchAsyncInBackground(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_BACKGROUND, block);
}

void IDPDispatchAsyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_UTILITY, block);
}

void IDPDispatchAsyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_USER_INITIATED, block);
}

void IDPDispatchAsyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_USER_INTERACTIVE, block);
}

void IDPDispatchAsyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchAsyncOnGlobalQueue(QOS_CLASS_DEFAULT, block);
}

// dispatch synchronous queues

static void IDPDispatchSyncOnGlobalQueue(unsigned int priority, IDPBlock block) {
    dispatch_sync(dispatch_get_global_queue(priority, 0), block);
}

void IDPDispatchSyncOnMainQueue(IDPBlock block) {
    dispatch_sync(dispatch_get_main_queue(), block);
}

void IDPDispatchSyncInBackground(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_BACKGROUND, block);
}

void IDPDispatchSyncWithUtilityPriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_UTILITY, block);
}

void IDPDispatchSyncWithInitiatedPriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_USER_INITIATED, block);
}

void IDPDispatchSyncWithInteractivePriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_USER_INTERACTIVE, block);
}

void IDPDispatchSyncWithDefaultPriority(IDPBlock block) {
    IDPDispatchSyncOnGlobalQueue(QOS_CLASS_DEFAULT, block);
}
