//
//  NSString+IDPRandomString.m
//  Task04_ObjC
//
//  Created by Student003 on 5/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPAlphabet.h"

#import "IDPRandom.h"
#import "IDPMacros.h"

#import "NSString+IDPRandomString.h"

IDPStaticConstantRange(IDPRandomStringLengthRange, 4, 8);

NSRange IDPMakeAlphabetRange(unichar lower, unichar upper) {
    unichar min = MIN(lower, upper);
    unichar max = MAX(lower, upper);
    NSRange range = NSMakeRange(min, max - min + 1);
    
    return range;
}

@implementation NSString (IDPRandomString)

#pragma mark -
#pragma mark Class methods

+ (instancetype)randomString {
    return [self randomStringWithLength:IDPRandomWithRange(IDPRandomStringLengthRange)];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[IDPAlphabet alphanumericAlphabet]];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(IDPAlphabet *)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    NSUInteger alphabetLength =  [alphabet count];
    for (int i = 0; i < length; i++) {
        NSString *character = [alphabet stringAtIndex:IDPRandom(alphabetLength)];
        [result appendFormat:@"%@", character];
    }
    
    return [self stringWithString:result];
}

#pragma mark -
#pragma mark Public

- (NSArray *)symbols {
    NSUInteger length = self.length;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:length];
    
    for (NSUInteger index = 0; index < length; index++) {
        unichar resultChar = [self characterAtIndex:index];
        [result addObject:[NSString stringWithFormat:@"%c", resultChar]];
    }
    
    return [[result copy] autorelease];
}

@end
