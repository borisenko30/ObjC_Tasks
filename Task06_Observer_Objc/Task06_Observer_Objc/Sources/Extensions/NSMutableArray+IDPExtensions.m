//
//  NSMutableArray+IDPExtensions.m
//  Task03_ObjC
//
//  Created by Admin on 07.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "NSMutableArray+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

@implementation NSMutableArray (IDPExtensions)

- (void)safeAddObject:(id)object{
    if (object) {
        [self addObject:object];
    }
}

@end
