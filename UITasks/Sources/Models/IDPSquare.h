//
//  IDPSquare.h
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IDPSquarePosition) {
    IDPLeftTop,
    IDPRightTop,
    IDPRightBottom,
    IDPLeftBottom
};

@interface IDPSquare : NSObject
@property (nonatomic, assign) IDPSquarePosition position;

@end
