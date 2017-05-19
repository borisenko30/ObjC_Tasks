//
//  NSString+IDPRandomString.h
//  Task04_ObjC
//
//  Created by Student003 on 5/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSRange IDPMakeAlphabetRange(unichar lower, unichar upper);

@class IDPAlphabet;

@interface NSString (IDPRandomString)

+ (instancetype)randomString;
+ (instancetype)randomStringWithLength:(NSUInteger)length;
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(IDPAlphabet *)alphabet;

- (NSArray *)symbols;

@end
