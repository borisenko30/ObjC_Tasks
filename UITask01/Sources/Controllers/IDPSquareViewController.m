//
//  IDPSquareViewController.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPSquareViewController.h"

#import "IDPMainView.h"
#import "IDPSquareView.h"

@interface IDPSquareViewController ()
@property (nonatomic, strong) IDPMainView *mainView;

@end

@implementation IDPSquareViewController

#pragma mark -
#pragma mark Accessors

- (IDPMainView *)mainView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[IDPMainView class]]) {
        return (IDPMainView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Public

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTouch:(UIButton *)sender {
    [self.mainView start];
}


@end
