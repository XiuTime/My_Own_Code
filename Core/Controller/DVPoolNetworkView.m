//
//  DVPoolNetworkView.m
//  MakeHave
//
//  Created by pppsy on 15/9/18.
//  Copyright © 2015年 makehave. All rights reserved.
//

#import "DVPoolNetworkView.h"

@implementation DVPoolNetworkView

+ (instancetype)poolNetworkView
{
    DVPoolNetworkView* view = [[self alloc] initWithFrame:DVRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    view.userInteractionEnabled = NO;
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CGFloat topPadding = 100;

        UIImageView* iconView = [[UIImageView alloc] initWithFrame:DVRectMake(0, 28 + topPadding, 52, 44)];
        iconView.image = [UIImage imageNamed:@"icon_poolNetwork"];
        iconView.centerX = self.width / 2;
        [self addSubview:iconView];

        UILabel* tipsLabel = [UILabel labelWithFrame:DVRectMake(0, iconView.bottom + 12, self.width, 24) font:Font(16) andTextColor:HEXCOLOR(0x666666)];
        tipsLabel.text = @"内容加载失败";
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipsLabel];

        UILabel* subTipsLabel = [UILabel labelWithFrame:DVRectMake(0, tipsLabel.bottom + 12, self.width, 20) font:Font(14) andTextColor:HEXCOLOR(0x666666)];
        subTipsLabel.text = @"点击重新加载";
        subTipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subTipsLabel];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    if (self.isHidden) {
        return NO;
    }

    for (UIView* view in self.subviews) {
        if (!view.hidden && view.alpha > 0 && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}

@end

@implementation DVEmptyView

+ (instancetype)emptyviewWithIcon:(NSString*)icon
                             tips:(NSString*)tips;
{
    DVEmptyView* view = [[self alloc] initWithFrame:DVRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) icon:icon tips:tips];
    return view;
}

- (id)initWithFrame:(CGRect)frame icon:(NSString*)icon
               tips:(NSString*)tips
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        UIImageView* iconView;
        if (icon) {
            iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
            iconView.centerX = self.width / 2;
            iconView.top = 150;
            [self addSubview:iconView];
        }

        UILabel* tipsLabel = [UILabel labelWithFrame:DVRectMake(0, 300, self.width, 16) font:Font(16) andTextColor:HEXCOLOR(0x999999)];
        if (iconView) {
            tipsLabel.top = iconView.bottom + 25;
        }
        tipsLabel.numberOfLines = 0;
        tipsLabel.text = tips;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipsLabel];

        _contentBottom = tipsLabel.bottom;

        _iconView = iconView;
        _tipsLabel = tipsLabel;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    for (UIView* view in self.subviews) {
        if (!view.hidden && view.alpha > 0 && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}

@end
