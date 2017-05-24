//
//  IDPObservable.h
//  Task07_ObjC
//
//  Created by Student003 on 5/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IDPWorkerState) {
    IDPWorkerReadyForWork,
    IDPWorkerBusy,
    IDPWorkerReadyForProcessing
};

@protocol IDPObservable <NSObject>
@property (nonatomic, assign)       IDPWorkerState  state;
@property (nonatomic, readonly)     NSHashTable     *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)notifyObservers;

@end
