//
//  IDPTimerObject.h
//  Task07_ObjC
//
//  Created by Student003 on 6/2/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPTimerProxy : NSObject
@property (nonatomic, assign) id  target;
@property (nonatomic, assign) SEL selector;

- (instancetype)initWithTarget:(id)target selector:(SEL)selector;

- (void)onTimer:(NSTimer *)timer;

@end
