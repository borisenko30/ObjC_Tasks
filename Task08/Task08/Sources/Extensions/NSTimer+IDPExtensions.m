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
                                 target:(id)target
                               selector:(SEL)selector
                               userInfo:(id)userInfo
                                repeats:(BOOL)repeats
{
    IDPTimerProxy *proxy = [[[IDPTimerProxy alloc] initWithTarget:target
                                                         selector:selector] autorelease];
    
    return [self scheduledTimerWithTimeInterval:seconds
                                         target:proxy
                                       selector:@selector(onTimer:)
                                       userInfo:userInfo
                                        repeats:repeats];
}

@end
