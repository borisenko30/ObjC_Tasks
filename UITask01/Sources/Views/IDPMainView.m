//
//  IDPMainView.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMainView.h"
#import "IDPSquareView.h"
#import "IDPSquare.h"

static const CGFloat IDPAnimationDuration = 2.0f;

typedef void(^IDPCompletionHandler)(BOOL finished);

@interface IDPMainView ()
@property (nonatomic, strong) IDPSquare *square;

@end

@implementation IDPMainView

#pragma mark -
#pragma mark Public

- (void)moveSquareToPosition:(IDPSquarePosition)position {
    [self moveSquareToPosition:position animated:NO completionHandler:nil];
}
- (void)moveSquareToPosition:(IDPSquarePosition)position animated:(BOOL)animated {
    [self moveSquareToPosition:position animated:animated completionHandler:nil];
}

- (void)moveSquareToPosition:(IDPSquarePosition)position
                    animated:(BOOL)animated
           completionHandler:(IDPCompletionHandler)handler
{
    IDPSquareView *square = self.squareView;
    
    CGPoint point = [self pointWithPosition:position];
    CGRect rectangle = CGRectMake(point.x, point.y, square.bounds.size.width, square.bounds.size.height);
    CGFloat duration = animated ? IDPAnimationDuration : 0;
    
    square.transform =  CGAffineTransformTranslate(square.transform, 0, 0);
    [UIView animateWithDuration:duration
                     animations:^{
                         square.frame = rectangle;
                     }
                     completion:handler];
}

- (void)move {
    IDPSquare *square = self.square;
    IDPCompletionHandler handler = ^(BOOL finished) {
        [self move];
        
        if (square.position == IDPLeftBottom) {
            square.position = IDPLeftTop;
        } else {
            square.position++;
        }
    };
    
    [self moveSquareToPosition:square.position animated:YES completionHandler:handler];
}

- (void)start {
    self.square = [IDPSquare new];
    
    [self move];
}
#pragma mark -
#pragma mark Private

- (CGPoint)pointWithPosition:(IDPSquarePosition)position {
    CGRect frame = self.frame;
    IDPSquareView *square = self.squareView;
    
    CGPoint point;
    CGFloat leftX = 0;
    CGFloat rightX = frame.size.width - square.frame.size.width;
    CGFloat topY = 0;
    CGFloat bottomY = frame.size.height - square.frame.size.height;
    
    
    switch(position) {
        case IDPLeftTop:
            point = CGPointMake(leftX, topY);
            break;
        case IDPRightTop:
            point = CGPointMake(rightX, topY);
            break;
        case IDPLeftBottom:
            point = CGPointMake(leftX, bottomY);
            break;
        case IDPRightBottom:
            point = CGPointMake(rightX, bottomY);
            break;
            
        default:
            point = CGPointMake(0, 0);
            break;
    }
    
    return point;
}

@end
