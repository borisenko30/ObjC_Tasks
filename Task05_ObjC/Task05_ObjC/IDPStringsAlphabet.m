//
//  IDPStringsAlphabets.m
//  Task05_ObjC
//
//  Created by Student003 on 5/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPStringsAlphabet.h"

#pragma mark -
#pragma mark Private declarations

@interface IDPStringsAlphabet ()
@property (nonatomic, retain) NSArray *strings;

@end

@implementation IDPStringsAlphabet

#pragma mark -
#pragma mark Initializations and deallocations

- (void)dealloc {
    self.strings = nil;
    
    [super dealloc];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    self = [super init];
    self.strings = strings;
    [super initWithCount:[self count]];

    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)count {
    return self.strings.count;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    return self.strings[index];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(__unsafe_unretained id [])buffer
                                    count:(NSUInteger)resultLength
{
    return [self.strings countByEnumeratingWithState:state
                                             objects:buffer
                                               count:resultLength];
}

@end
