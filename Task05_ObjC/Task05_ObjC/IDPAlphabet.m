//
//  IDPAlphabet.m
//  Task05_ObjC
//
//  Created by Student003 on 5/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPAlphabet.h"

#import "IDPRangeAlphabet.h"
#import "IDPClusterAlphabet.h"
#import "IDPStringsAlphabet.h"

#import "NSString+IDPRandomString.h"

@interface IDPAlphabet ()
@property (nonatomic, assign) NSUInteger count;

@end

@implementation IDPAlphabet

#pragma mark -
#pragma mark Class methods

+ (instancetype)alphabetWithRange:(NSRange)range {
    return [[[IDPRangeAlphabet alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabetWithStrings:(NSArray *)strings {
    return [[[IDPStringsAlphabet alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets {
    return [[[IDPClusterAlphabet alloc] initWithAlphabets:alphabets] autorelease];
}

+ (instancetype)alphabetWithSymbols:(NSString *)string {
    return [self alphabetWithStrings:[string symbols]];
}

+ (IDPAlphabet *)alphanumericAlphabet {
    return [self alphabetWithAlphabets:@[[self letterAlphabet], [self numericAlphabet]]];
}

+ (IDPAlphabet *)numericAlphabet {
    return [self alphabetWithRange:IDPMakeAlphabetRange('0','9')];
}

+ (IDPAlphabet *)lowercaseLetterAlphabet {
    return [self alphabetWithRange:IDPMakeAlphabetRange('a','z')];
}

+ (IDPAlphabet *)uppercaseLetterAlphabet {
    return [self alphabetWithRange:IDPMakeAlphabetRange('A','Z')];
}

+ (IDPAlphabet *)letterAlphabet {
    return [self alphabetWithAlphabets:@[[self lowercaseLetterAlphabet], [self uppercaseLetterAlphabet]]];
}

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithRange:(NSRange)range {
    [self release];

    return [[IDPRangeAlphabet alloc] initWithRange:range];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];

    return [[IDPStringsAlphabet alloc] initWithStrings:strings];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
  
    return [[IDPClusterAlphabet alloc] initWithAlphabets:alphabets];
}

- (instancetype)initWithSymbols:(NSString *)string {
    return [self initWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Public

- (void)initWithCount:(NSUInteger)count {
    _count = count;
}

// should be overriden in subclasses
- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

// should be overriden in subclasses
- (NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self stringAtIndex:index];
}

- (NSString *)string {
    NSMutableString *string = [NSMutableString stringWithCapacity:self.count];
    for (NSString *symbol in self) {
        [string appendString:symbol];
    }
    
    return [[string copy] autorelease];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(__unsafe_unretained id [])stackbuf
                                    count:(NSUInteger)resultLength
{
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger length = MIN(state->state + resultLength, self.count);
    resultLength = length - state->state;
    
    for (NSUInteger index = 0; index < resultLength; index++) {
        stackbuf[index] = self[index + state->state];
    }
    
    state->itemsPtr = stackbuf;
    
    state->state +=resultLength;
    
    return resultLength;
}

@end
