//
//  IDPDispathchQueue.h
//  Task09_ObjC
//
//  Created by Student003 on 6/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void IDPDispatchQueueInBackgroundWithBlock(void(^block)());
extern void IDPDispatchQueueOnMainThreadWithBlock(void(^block)());
