//
//  IDPQueue.h
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/30/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPQueue : NSObject
@property (nonatomic, readonly, getter=isEmpty) BOOL empty;

+ (instancetype)queueWithArray:(NSArray *)array;

- (void)pushObject:(id)object;
- (id)popObject;

- (BOOL)isEmpty;

@end
