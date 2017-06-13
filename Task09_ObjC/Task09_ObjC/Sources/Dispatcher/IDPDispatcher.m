//
//  IDPDispatcher.m
//  Task08
//
//  Created by Student003 on 6/6/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPDispatcher.h"
#import "IDPQueue.h"
#import "IDPWorker.h"

#import "NSObject+IDPExtensions.h"

@interface IDPDispatcher ()
@property (nonatomic, retain) IDPQueue      *objectsQueue;
@property (nonatomic, retain) IDPQueue      *handlersQueue;
@property (nonatomic, retain) NSMutableSet  *mutableHandlers;

@end

@implementation IDPDispatcher

@dynamic handlers;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.objectsQueue = nil;
    self.handlersQueue = nil;
    self.mutableHandlers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [self initWithHandlers:nil];
    
    return self;
}

- (instancetype)initWithHandlers:(NSArray *)handlers {
    self = [super init];
    self.objectsQueue = [IDPQueue object];
    self.handlersQueue = [IDPQueue queueWithArray:handlers];
    self.mutableHandlers = [NSMutableSet object];
    [self addHandlers:handlers];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)handlers {
    return [[self.mutableHandlers copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addHandler:(id)handler {
    @synchronized (self) {
        [self.handlersQueue pushObject:handler];
        [self.mutableHandlers addObject:handler];
        [handler addObserver:self];
    }
}

- (void)removeHandler:(id)handler {
    @synchronized (self) {
        [handler removeObserver:self];
        [self.mutableHandlers removeObject:handler];
    }
}

- (void)addHandlers:(id)handlers {
    @synchronized (self) {
        for (id handler in handlers) {
            [self addHandler:handler];
        }
    }
}

- (void)removeHandlers:(id)handlers {
    @synchronized (self) {
        for (id handler in handlers) {
            [self removeHandler:handler];
        }
    }
}

- (void)removeSelfFromObservers {
    for (id handler in self.mutableHandlers) {
        [handler removeObserver:self];
    }
}

- (void)processObject:(id)object {
    id handler = [self.handlersQueue popObject];
    
    if (handler) {
        [handler processObject:object];
    } else {
        [self.objectsQueue pushObject:object];
    }
}

#pragma mark -
#pragma mark IDPWorkerObserver methods

- (void)workerDidBecomeReadyForWork:(id)worker {
    @synchronized (self) {
        if ([self.mutableHandlers containsObject:worker]) {
            [self.handlersQueue pushObject:worker];
            id object = [self.objectsQueue popObject];
            
            if (object) {
                [self processObject:object];
            }
        }
    }
}

- (void)workerDidBecomeReadyForProcessing:(id)worker {
    @synchronized (self) {
        if (![self.mutableHandlers containsObject:worker]) {
            [self processObject:worker];
        }
    }
}

@end
