//
//  IDPObservableObject.m
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableObject.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPObservableObject ()
@property (nonatomic, retain) NSHashTable *mutableObservers;

@end

@implementation IDPObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableObservers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observers {
    return [[self.mutableObservers copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addObserver:(id)observer {
    if (observer) {
        [self.mutableObservers addObject:observer];
    }
}

- (void)removeObserver:(id)observer {
    [self.mutableObservers removeObject:observer];
}

// should be overriden in subclasses
- (SEL)selectorForState:(NSUInteger)state {
    return Nil;
}

@end
