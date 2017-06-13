//
//  NSTimer+IDPExtensions.h
//  Task07_ObjC
//
//  Created by Student003 on 6/2/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPTimerProxy;

@interface NSTimer (IDPExtensions)

+ (NSTimer *)scheduledTimerWithInterval:(NSTimeInterval)seconds
                                 target:(id)target
                               selector:(SEL)selector
                               userInfo:(id)userInfo
                                repeats:(BOOL)repeats;
@end
