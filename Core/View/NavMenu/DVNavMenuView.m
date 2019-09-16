//
//  DVNavMenuView.m
//  MakeHave
//
//  Created by pppsy on 15/8/13.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVNavMenuView.h"

@interface DVNavMenuView  ()

@end

@implementation DVNavMenuView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuButton = [[DVMenuButton alloc] initWithFrame:frame];
        [self.menuButton setTitle:title forState:UIControlStateNormal];
        
        CGSize size = [self.menuButton.titleLabel.text sizeWithFont:Font(16)];
        self.menuButton.arrowView.left = self.menuButton.width/2 + size.width/2 + 22;
        self.menuButton.arrowView.layer.transform = CATransform3DMakeRotation(M_PI,1.0,0.0,0.0);
        
        
        [self.menuButton addTarget:self action:@selector(onMenuTap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
        
    }
    return self;
}

- (void)onMenuTap {
    if (_tapBlk) {
        _tapBlk(self.menuButton);
    }
}

@end

@implementation DVMenuButton{
    UIImageView *_arrowView;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = BoldFont(16);
        [self setTitleColor:HEXCOLOR(0xc5b66b) forState:UIControlStateNormal];
        
        _arrowView = [[UIImageView alloc] initWithFrame:DVRectMake(0, 0, 8, 8)];
        _arrowView.image = [UIImage imageNamed:@"icon_window_arrow"];
        _arrowView.centerY = self.height/2;
        _arrowView.centerX = self.width - 10;
        [self addSubview: _arrowView];
    }
    return self;
}

@end
