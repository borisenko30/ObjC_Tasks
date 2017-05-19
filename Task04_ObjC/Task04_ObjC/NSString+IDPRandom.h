//
//  NSString+IDPRandomString.h
//  Task04_ObjC
//
//  Created by Student003 on 5/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IDPRandom)

+ (instancetype)alphanumericAlphabet;
+ (instancetype)numericAlphabet;
+ (instancetype)letterAlphabet;
+ (instancetype)lowercaseLetterAlphabet;
+ (instancetype)uppercaseLetterAlphabet;
+ (instancetype)alphabetWithUnicodeRange:(NSRange)range;

+ (instancetype)randomString;
+ (instancetype)randomStringWithLength:(NSUInteger)length;
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

- (NSString *)alphabetByAppendingAlphabet:(NSString *)alphabet;

@end
