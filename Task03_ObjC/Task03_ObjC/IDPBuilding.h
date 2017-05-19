//
//  Building.h
//  Task03_ObjC
//
//  Created by Student003 on 5/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPRoom;

@interface IDPBuilding : NSObject
@property (nonatomic, readonly, copy) NSArray *rooms;

- (void)addRoom:(IDPRoom *)room;
- (void)removeRoom:(IDPRoom *)room;

- (NSArray *)workersWithClass:(Class)workerClass;

@end
