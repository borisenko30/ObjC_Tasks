//
//  NSObject+IDPExtension.m
//  Task01_ObjC
//
//  Created by Student003 on 5/5/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPConstants.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

@implementation NSObject (IDPExtensions)

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count
                        factoryBlock:^ {
                            return [self object];
                        }];
}

@end
