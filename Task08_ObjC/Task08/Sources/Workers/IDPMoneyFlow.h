//
//  IDPMoneyProtocol.h
//  Task03_ObjC
//
//  Created by Student003 on 5/8/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPWorker;

@protocol IDPMoneyFlow <NSObject>
@property (nonatomic, readonly) NSUInteger cash;

- (NSUInteger)giveMoney;
- (void)takeMoney:(NSUInteger)money;

- (void)takeMoneyFromObject:(id<IDPMoneyFlow>)object;

@end
