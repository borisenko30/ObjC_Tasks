//
//  IDPDispathchQueue.m
//  Task09_ObjC
//
//  Created by Student003 on 6/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPDispatchQueue.h"

void IDPDispatchQueueInBackgroundWithBlock(void(^block)()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
}
void IDPDispatchQueueOnMainThreadWithBlock(void(^block)()) {
    dispatch_async(dispatch_get_main_queue(), block);
}
