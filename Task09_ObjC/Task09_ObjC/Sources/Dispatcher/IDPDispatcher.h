//
//  IDPDispatcher.h
//  Task08
//
//  Created by Student003 on 6/6/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPWorkerObserver.h"

@class IDPQueue;

@interface IDPDispatcher : NSObject <IDPWorkerObserver>
@property (nonatomic, readonly) IDPQueue    *objectsQueue;
@property (nonatomic, readonly) IDPQueue    *handlersQueue;
@property (nonatomic, readonly) NSSet       *handlers;

- (instancetype)initWithHandlers:(NSArray *)handlers;

- (void)addHandler:(id)handler;
- (void)removeHandler:(id)handler;

- (void)addHandlers:(id)handlers;
- (void)removeHandlers:(id)handlers;

- (void)removeSelfFromObservers;

- (void)processObject:(id)object;

@end
