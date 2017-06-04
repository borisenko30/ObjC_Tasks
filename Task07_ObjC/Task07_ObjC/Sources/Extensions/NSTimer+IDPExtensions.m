//
//  NSTimer+IDPExtensions.m
//  Task07_ObjC
//
//  Created by Student003 on 6/2/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSTimer+IDPExtensions.h"

#import "IDPTimerProxy.h"

@implementation NSTimer (IDPExtensions)

+ (NSTimer *)scheduledTimerWithInterval:(NSTimeInterval)seconds
                                 target:(IDPTimerProxy *)proxy
                               selector:(SEL)selector
                               userInfo:(id)userInfo
                                repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:seconds
                                         target:proxy
                                       selector:selector
                                       userInfo:userInfo
                                        repeats:repeats];
}

@end
