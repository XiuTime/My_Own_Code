//
//  DVPopMenu.m
//  MakeHave
//
//  Created by pppsy on 15/8/16.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVPopMenu.h"

#define kCellHeight 44
#define kCellWidth 104

@interface DVPopMenu ()
@property (nonatomic, strong) UIButton* cover;



@end

@implementation DVPopMenu

+ (instancetype)createPopoverView
{
    UIWindow* keyWindow = [[UIApplication sharedApplication] keyWindow];
    return [[self alloc] initWithFrame:keyWindow.bounds];
}

- (void)addBtnWithTitle:(NSString*)title
                   icon:(NSString*)icon
                hasLine:(BOOL)hasLine
               selected:(BOOL)isSelected
                handler:(void (^)(id sender))handler
{
    [self addBtnWithTitle:title icon:icon hlIcon:nil hasLine:hasLine selected:isSelected handler:handler];
}

- (void)addBtnWithTitle:(NSString*)title
                   icon:(NSString*)icon
                 hlIcon:(NSString*)hlIcon
                hasLine:(BOOL)hasLine
               selected:(BOOL)isSelected
                handler:(void (^)(id sender))handler
{
    CGFloat curTop = 16 + _btnlist.count * 44;

    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, curTop, _container.width, kCellHeight)];

    UIImageView* iconView = [[UIImageView alloc] initWithFrame:DVRectMake(10, 0, 44, 44)];
    iconView.center = CGPointMake(20, kCellHeight / 2);
    iconView.contentMode = UIViewContentModeCenter;
    iconView.image = [UIImage imageNamed:icon];
    if (hlIcon) {
        iconView.highlightedImage = [UIImage imageNamed:hlIcon];
    }
    [btn addSubview:iconView];

    iconView.highlighted = isSelected;

    //    UILabel* label = [UILabel labelWithFrame:DVRectMake(40, 0, kCellWidth, kCellHeight) font:Font(15) andTextColor:HEXACOLOR(0x000000, 0.8)];
    //    label.text = title;
    //    [btn addSubview:label];

    [btn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xFDFEFF)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x0088ff)] forState:UIControlStateHighlighted];

    CGFloat titleLeft = 0;
    if (icon) {
        titleLeft = 40;
    }
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, titleLeft, 0, 0);
    btn.titleLabel.font = Font(15);
    [btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    //btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [btn bk_addEventHandler:^(id sender) {
        [self dismiss];
        handler(sender);
    }
           forControlEvents:UIControlEventTouchUpInside];

    if (isSelected) {
        btn.highlighted = YES;
    }
    btn.backgroundColor = [UIColor clearColor];
    [_container insertSubview:btn atIndex:0];

    if (hasLine) {
        UIView* line = makeSepline();
        line.width = kCellWidth;
        line.height = 0.5;
        line.bottom = kCellHeight;
        [btn addSubview:line];
    }
    
    [_btnlist addObject:btn];
    
    _container.height = 32 + _btnlist.count * 44;
}

- (void)showInView:(UIView*)view
{
    self.alpha = 0;

    if (view) {
        [view addSubview:self];
    }
    else {
        UIWindow* keyWindow = [[UIApplication sharedApplication] keyWindow];
        [keyWindow addSubview:self];
    }

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
    }
        completion:^(BOOL finished) {
            if (_animationDoneBlock) {
                _animationDoneBlock();
            }
        }];
}

- (void)hide
{
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    }
        completion:^(BOOL finished) {
            [self dismiss];
            CFRunLoopStop([runLoop getCFRunLoop]);
        }];
    [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.3]];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = HEXACOLOR(0,0.3);
        
        _btnlist = [@[] mutableCopy];

        UIButton* cover = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [cover addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;

        //TODO psy 需要一个topmenu 背景图
        _container = makeImgView(DVRectMake(0, 0, kCellWidth, 0), @"bg_topmenu");
        _container.backgroundColor = [UIColor whiteColor];
        _container.right = SCREEN_WIDTH;
        _container.userInteractionEnabled = YES;
        [self addSubview:_container];
    }
    return self;
}

- (void)dismiss
{
    [self removeFromSuperview];
    if (_animationDoneBlock) {
        _animationDoneBlock();
    }
}

@end
