//
//  IDPMainView.h
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPSquareView;

@interface IDPMainView : UIView
@property (nonatomic, strong) IBOutlet IDPSquareView *squareView;

- (void)start;

@end
