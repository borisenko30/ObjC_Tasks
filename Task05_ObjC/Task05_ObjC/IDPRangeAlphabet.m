//
//  IDPRangeAlphabet.m
//  Task05_ObjC
//
//  Created by Student003 on 5/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPRangeAlphabet.h"

#pragma mark -
#pragma Private declarations

@interface IDPRangeAlphabet ()
@property (nonatomic, assign) NSRange range;

@end

@implementation IDPRangeAlphabet

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithRange:(NSRange)range {
    self = [super init];
    self.range = range;
    [super initWithCount:[self count]];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)count {
    return self.range.length;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    NSRange range = self.range;
    NSAssert(index < range.length, NSRangeException);
    
    return [NSString stringWithFormat:@"%c", (unichar)(range.location + index)];
}

@end
