//
//  IDPRandom.m
//  Task01_ObjC
//
//  Created by Student003 on 5/5/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPRandom.h"

NSUInteger IDPRandom(NSUInteger max) {
    return arc4random_uniform((u_int32_t)max);
}

NSUInteger IDPRandomWithRange(NSRange range) {
    return range.location + IDPRandom(range.length);
}

BOOL IDPRandomBool() {
    return IDPRandom(2);
}
