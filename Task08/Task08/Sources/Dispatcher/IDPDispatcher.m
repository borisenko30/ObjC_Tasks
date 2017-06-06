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
@property (nonatomic, retain) IDPQueue    *objectsQueue;
@property (nonatomic, retain) IDPQueue    *handlersQueue;

@end

@implementation IDPDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.objectsQueue = nil;
    self.handlersQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [self initWithHandlers:nil];
    self.objectsQueue = [IDPQueue object];
    
    return self;
}

- (instancetype)initWithHandlers:(NSArray *)handlers {
    self = [super init];
    self.handlersQueue = [IDPQueue queueWithArray:handlers];
    
    return self;
}

#pragma mark -
#pragma mark Public

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

- (void)workerDidBecomeReadyForWork:(IDPWorker *)worker {
        [self.handlersQueue pushObject:worker];
        id object = [self.objectsQueue popObject];
        
        if (object) {
            [self processObject:object];
        }
}

@end
