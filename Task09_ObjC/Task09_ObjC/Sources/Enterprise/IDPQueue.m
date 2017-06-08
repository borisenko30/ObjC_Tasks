//
//  IDPQueue.m
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/30/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPQueue.h"
#import "NSObject+IDPExtensions.h"

@interface IDPQueue ()
@property (nonatomic, retain) NSMutableArray *queue;

@end

@implementation IDPQueue

#pragma mark -
#pragma mark Class methods

+ (instancetype)queueWithArray:(NSArray *)array {
    IDPQueue *result = [IDPQueue object];
    
    for (id object in array) {
        [result pushObject:object];
    }
    
    return result;
}

#pragma mark -
#pragma mark Deallocations and Initializations

- (void)dealloc {
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.queue = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)pushObject:(id)object {
    @synchronized (self) {
        [self.queue addObject:object];
    }
}

- (id)popObject {
    @synchronized (self) {
        NSMutableArray *queue = self.queue;
        id object = [[queue.firstObject retain] autorelease];
        [queue removeObject:object];
        
        return object;
    }
}

- (BOOL)isEmpty {
    @synchronized (self) {
        return !self.queue.count;
    }
}

@end
