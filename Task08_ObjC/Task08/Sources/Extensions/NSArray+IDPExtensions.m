//
//  NSArray+IDPExtension.m
//  Task01_ObjC
//
//  Created by Student003 on 5/5/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSArray+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

@implementation NSArray (IDPExtensions)

+ (instancetype)objectsWithCount:(NSInteger)count factoryBlock:(id(^)(void))block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray object];
    for (int i = 0; i < count; i++) {
        [objects addObject:block()];
    }
    
    return objects;
}

- (instancetype)filteredArrayWithBlock:(BOOL(^)(id object))block {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary * bindings) {
        return block(object);
    }];
    
    return [self filteredArrayUsingPredicate:predicate];
}

@end
