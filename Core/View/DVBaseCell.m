//
//  DVBaseCell.m
//  MakeHave
//
//  Created by pppsy on 15/8/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVBaseCell.h"

@implementation DVBaseCell {
    UIImageView* _bgView;
    UIImageView* _arrowView;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self insertSubview:_bgView atIndex:0];

    _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
    [self addSubview:_arrowView];
    _arrowView.hidden = YES;

    //    _bottomLine = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"line_common"] resizableImage]];
    _bottomLine = makeSepline();
    [self addSubview:_bottomLine];
    _bottomLine.hidden = YES;

    _bgView.image = _normalBg;

    [_arrowView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.size.equalTo(_arrowView);
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-15);
    }];

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker* make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@0.5);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)setShowRightArrow:(BOOL)showRightArrow
{
    if (showRightArrow) {
        [self bringSubviewToFront:_arrowView];
        _arrowView.hidden = NO;
    }
    else {
        _arrowView.hidden = YES;
    }
    [self setNeedsDisplay];
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    if (showBottomLine) {
        [self bringSubviewToFront:_bottomLine];
        _bottomLine.hidden = NO;
    }
    else {
        _bottomLine.hidden = YES;
    }
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        _bgView.image = _highlightBg;
    }
    else {
        _bgView.image = _normalBg;
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _bgView.image = _highlightBg;
    }
    else {
        _bgView.image = _normalBg;
    }
}

- (void)setNormalBg:(UIImage*)normalBg
{
    _normalBg = normalBg;
    _bgView.image = _normalBg;
}

@end

#pragma mark -

@implementation DVTitleCell

- (id)initWithFrame:(CGRect)frame key:(NSString*)key value:(NSString*)value
{
    self = [super init];
    if (self) {
        self.showRightArrow = YES;
        self.frame = frame;

        _keyLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 220, frame.size.height) font:Font(15) andTextColor:HEXCOLOR(0x333333)];
        _keyLabel.text = key;
        [self addSubview:_keyLabel];

        _valueLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 120, frame.size.height) font:Font(14) andTextColor:HEXCOLOR(0x666666)];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.text = value;
        [self addSubview:_valueLabel];

        _descLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 100, frame.size.height) font:Font(14) andTextColor:HEXCOLOR(0x999999)];
        _descLabel.text = @"";
        _descLabel.hidden = YES;
        [self addSubview:_descLabel];

        //        [_keyLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.top.equalTo(self.mas_top).with.offset(0);
        //            make.left.equalTo(self.mas_left).with.offset(12);
        //            make.bottom.equalTo(self.mas_bottom).with.offset(0);
        //            make.right.lessThanOrEqualTo(self.mas_right).with.offset(12);
        //        }];
        //
        //        [_valueLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.top.equalTo(self.mas_top).with.offset(0);
        //            make.left.lessThanOrEqualTo(self.mas_left).with.offset(0);
        //            make.bottom.equalTo(self.mas_bottom).with.offset(0);
        //            make.right.equalTo(self.mas_right).with.offset(-26);
        //        }];
    }

    return self;
}

+ (instancetype)controlWithFrame:(CGRect)frame
                             key:(NSString*)key
                           value:(NSString*)value
{
    return [[self alloc] initWithFrame:frame key:key value:value];
}

@end
