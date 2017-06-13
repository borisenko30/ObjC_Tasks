//
//  NSArray+IDPExtension.h
//  Task01_ObjC
//
//  Created by Student003 on 5/5/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IDPExtensions)

+ (instancetype)objectsWithCount:(NSInteger)count factoryBlock:(id (^)(void))block;

- (instancetype)filteredArrayWithBlock:(BOOL(^)(id object))block;

@end
