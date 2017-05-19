//
//  IDPClusterAlphabet.h
//  Task05_ObjC
//
//  Created by Student003 on 5/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPAlphabet.h"

@interface IDPClusterAlphabet : IDPAlphabet
@property (nonatomic, readonly) NSArray *alphabets;

- (instancetype)initWithAlphabets:(NSArray *)alphabets;

@end
