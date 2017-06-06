//
//  IDPObservableObject.h
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSSet       *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)addObservers:(NSArray *)observers;
- (void)removeObservers:(NSArray *)observers;

// should be overriden in subclasses
- (SEL)selectorForState:(NSUInteger)state;

- (void)notifyOfState:(NSUInteger)state;

@end
