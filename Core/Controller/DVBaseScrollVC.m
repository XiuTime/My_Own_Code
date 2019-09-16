//
//  DVBaseScrollVC.m
//  DVOverseas
//
//  Created by pppsy on 16/8/15.
//  Copyright © 2016年 nebula. All rights reserved.
//

#import "DVBaseScrollVC.h"

@interface DVBaseScrollVC ()

@end

@implementation DVBaseScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bodyView];
}

- (DVLinearScrollView*)bodyView {
    if (!_bodyView) {
        _bodyView = makeLinearScrollView(self);
        _bodyView.scrollEnabled = YES;
        _bodyView.minContentSizeHeight = SCREEN_HEIGHT;
        [self.view addSubview:_bodyView];
    }
    return _bodyView;
}


@end
