//
//  IDPRandomStringTests.m
//  Task04_ObjC
//
//  Created by Student003 on 5/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPRandomStringTests.h"

#import "IDPMacros.h"

#import "NSString+IDPRandom.h"

IDPStaticConstant(NSUInteger, IDPRandomStringLength, 10);

void IDPRandomStringTest() {
    NSLog(@"Random string: %@", [NSString randomString]);
    NSLog(@"Random string with length %lu: %@", IDPRandomStringLength, [NSString randomStringWithLength:IDPRandomStringLength]);
    NSLog(@"Random numeric string: %@", [NSString randomStringWithLength:IDPRandomStringLength alphabet:[NSString numericAlphabet]]);
    NSLog(@"Random lowercase string: %@", [NSString randomStringWithLength:IDPRandomStringLength alphabet:[NSString lowercaseLetterAlphabet]]);
    NSLog(@"Random uppercase string: %@", [NSString randomStringWithLength:IDPRandomStringLength alphabet:[NSString uppercaseLetterAlphabet]]);
}
