//
//  IDPCarFlow.m
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/30/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPCarDispatcher.h"
#import "IDPCar.h"
#import "IDPQueue.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

@interface IDPCarDispatcher ()
@property (nonatomic, retain) IDPQueue *cars;

@end

@implementation IDPCarDispatcher

#pragma mark -
#pragma mark Deallocations and initializations

- (instancetype)init {
    self = [super init];
    self.cars = [IDPQueue object];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)generateCarsWithCount:(NSUInteger)count {
    for (int i = 0; i < count; i++) {
        [self.cars pushObject:[IDPCar object]];
    }
}

@end
