//
//  NSString+IDPRandomString.m
//  Task04_ObjC
//
//  Created by Student003 on 5/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSString+IDPRandom.h"

#import "IDPRandom.h"
#import "IDPMacros.h"

IDPStaticConstantRange(IDPRandomStringLengthRange, 4, 8);

static NSRange IDPMakeAlphabetRange(unichar lower, unichar upper) {
    unichar min = MIN(lower, upper);
    unichar max = MAX(lower, upper);
    NSRange range = NSMakeRange(min, max - min + 1);
    
    return range;
}

@implementation NSString (IDPRandom)

#pragma mark -
#pragma mark Class methods

+ (instancetype)alphanumericAlphabet {
    return [[self letterAlphabet] alphabetByAppendingAlphabet:[self numericAlphabet]];
}

+ (instancetype)numericAlphabet {
    return [self alphabetWithUnicodeRange:IDPMakeAlphabetRange('0','9')];
}

+ (instancetype)lowercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:IDPMakeAlphabetRange('a','z')];
}

+ (instancetype)uppercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:IDPMakeAlphabetRange('A','Z')];
}

+ (instancetype)letterAlphabet {
    return [[self lowercaseLetterAlphabet] alphabetByAppendingAlphabet:[self uppercaseLetterAlphabet]];
}

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (unichar character = range.location; character < NSMaxRange(range); character++) {
        [result appendFormat:@"%c", character];
    }
    
    return [self stringWithString:result];
}

+ (instancetype)randomString {
    return [self randomStringWithLength:IDPRandomWithRange(IDPRandomStringLengthRange)];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[self alphanumericAlphabet]];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    NSUInteger alphabetLength =  alphabet.length;
    for (int i = 0; i < length; i++) {
        unichar character = [alphabet characterAtIndex:IDPRandom(alphabetLength)];
        [result appendFormat:@"%c", character];
    }
    
    return [self stringWithString:result];
}

#pragma mark -
#pragma mark Public

- (NSString *)alphabetByAppendingAlphabet:(NSString *)alphabet {
    id result = self;
    if (alphabet) {
        result = [result stringByAppendingString:alphabet];
    }
    
    return result;
}

@end
