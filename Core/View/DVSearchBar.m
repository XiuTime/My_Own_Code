//
//  DVSearchBar.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVSearchBar.h"

@interface DVSearchBar ()
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) CGFloat midWidth; //包括icon 、space、placeholder
@property (nonatomic, assign) CGFloat normalPaddingLeft; //icon在正常状态的left padding
@property (nonatomic, assign) CGFloat activePaddingLeft; //icon在激活状态的left padding
@end

@implementation DVSearchBar

- (void)onCancel
{
    self.isEditing = NO;
}

#pragma mark -

- (id)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI
{
    _bgView = [[UIImageView alloc]
        initWithFrame:DVRectMake(0, 0, self.width, self.height)];
    //    _bgView.image = [[UIImage imageNamed:@"icon_searchbar"] resizableImage];
    _bgView.backgroundColor = HEXCOLOR(0xe3e4e5);
    _bgView.layer.cornerRadius = 15;
    [self addSubview:_bgView];

    __weak typeof(self) wself = self;

    _textFiled = [[UITextField alloc]
        initWithFrame:DVRectMake(0, 0, self.width, self.height)];
    _textFiled.returnKeyType = UIReturnKeyDone;
    _textFiled.font = Font(14);
    _textFiled.textColor = HEXCOLOR(0xffffff);
    _textFiled.clearButtonMode = UITextFieldViewModeNever;
    //关闭自动联想和首字母大写
    _textFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    [_textFiled setBk_didBeginEditingBlock:^(UITextField* txtfield) {
        wself.isEditing = YES;
    }];
    //    [_textFiled setBk_shouldChangeCharactersInRangeWithReplacementStringBlock:^BOOL(UITextField* txtfield, NSRange range, NSString* str) {
    //        NSString* curStr = txtfield.text;
    //        NSString* willStr = [txtfield.text stringByReplacingCharactersInRange:range withString:str];
    //        if (willStr.length == 0 && curStr.length == 0) {
    //            wself.placeholderLabel.hidden = NO;
    //        }
    //        else {
    //            wself.placeholderLabel.hidden = YES;
    //        }
    //        //        wself.placeholderLabel.hidden = (willStr.length == 0 && curStr.length == 0);
    //        wself.cancelButton.hidden = (willStr.length == 0);
    //
    //        DVLog(@"will show %@", willStr);
    //
    //        if (wself.delegate) {
    //            [wself.delegate didChangeWithKey:willStr];
    //        }
    //        return YES;
    //    }];

    //    [_textFiled s·etBk_shouldClearBlock:^BOOL(UITextField* txtfield) {
    //        wself.placeholderLabel.hidden = NO;
    //
    //        if (wself.delegate) {
    //            [wself.delegate didChangeWithKey:nil];
    //        }
    //        return YES;
    //    }];

    [_textFiled setBk_shouldReturnBlock:^BOOL(UITextField* txtfield) {
        if (wself.delegate && txtfield.text.length > 0) {
            [wself.delegate didSearchByKey:txtfield.text];
        }

        [txtfield resignFirstResponder];
        return YES;
    }];
    [self addSubview:_textFiled];

    _iconView = [[UIImageView alloc]
        initWithFrame:DVRectMake(0, 0, 12, 12)];
    _iconView.image = [UIImage imageNamed:@"icon_search"];
    _iconView.center = CGPointMake(self.width / 2, self.height / 2);
    [self addSubview:_iconView];

    _placeholderLabel = [UILabel labelWithFrame:DVRectMake(0, 0, 28, self.height)
                                           font:Font(14)
                                   andTextColor:HEXACOLOR(0x000000, 0.5)];
    _placeholderLabel.text = @"搜索";
    _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_placeholderLabel];

    _cancelLabel = [UILabel labelWithFrame:DVRectMake(0, 0, 32, self.height)
                                      font:Font(16)
                              andTextColor:HEXCOLOR(0x0088ff)];
    _cancelLabel.text = @"取消";
    _cancelLabel.right = self.width + 2;
    _cancelLabel.textAlignment = NSTextAlignmentRight;
    [_cancelLabel addTapAction:@selector(onCancel) target:self];
    [self addSubview:_cancelLabel];

    _cancelButton = [UIButton buttonWithNormalIconName:@"icon_search_cancel" hlIconName:@"icon_search_cancel"];
    _cancelButton.frame = DVRectMake(0, 0, 32, 32);
    _cancelButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [_cancelButton bk_addEventHandler:^(id sender) {
        wself.textFiled.text = nil;
        wself.placeholderLabel.hidden = NO;
        wself.cancelButton.hidden = YES;

        if (wself.delegate) {
            [wself.delegate didChangeWithKey:nil];
        }
    }
                     forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];

    //未激活状态
    _midWidth = _iconView.width + 5 + _placeholderLabel.width;
    _normalPaddingLeft = (self.width - _midWidth) / 2;
    _activePaddingLeft = 10;

    CGFloat txtLeft = _activePaddingLeft + _iconView.width + 5;
    CGFloat txtWidth = self.width - txtLeft - 40;
    _textFiled.frame = DVRectMake(txtLeft, 1, txtWidth, self.height);
    _cancelButton.right = _textFiled.right;
    _cancelButton.centerY = self.height / 2;

    _bgView.frame = DVRectMake(0, 0, self.width, self.height);
    _iconView.left = _normalPaddingLeft;
    _placeholderLabel.left = _iconView.right + 5;

    _cancelLabel.hidden = YES;
    _cancelButton.hidden = YES;
}

- (void)textFieldTextDidChange
{
    NSString* curStr = _textFiled.text;
    _placeholderLabel.hidden = (curStr.length > 0);

    //        wself.placeholderLabel.hidden = (willStr.length == 0 && curStr.length == 0);
    _cancelButton.hidden = (curStr.length == 0);

    if (self.delegate) {
        [self.delegate didChangeWithKey:curStr];
    }
}

- (void)setIsEditing:(BOOL)isEditing
{
    if (_isEditing == isEditing) {
        return;
    }

    _isEditing = isEditing;

    if (_delegate) {
        if (_isEditing) {
            [_delegate didBeginEditing];
        }
        else {
            [_delegate didEngEditing];
        }
    }

    if (_isEditing) {
        //进入激活状态
        [UIView animateWithDuration:0.2 animations:^{
            _bgView.frame = DVRectMake(0, 0, self.width - 40, self.height);
            _iconView.left = _activePaddingLeft;
            _placeholderLabel.left = _iconView.right + 5;

            _bgView.backgroundColor = HEXCOLOR(0x0088ff);
            //            _placeholderLabel.textColor = HEXCOLOR(0xffffff);
            _placeholderLabel.textColor = HEXACOLOR(0xffffff, 0.5);
        }
            completion:^(BOOL finished) {
                _cancelLabel.hidden = NO;
                //                _bgView.backgroundColor = HEXCOLOR(0x0088ff);
                //                _placeholderLabel.textColor = HEXCOLOR(0xffffff);
                _iconView.image = [UIImage imageNamed:@"icon_search_on"];
            }];
    }
    else {
        //进入未激活状态
        _cancelLabel.hidden = YES;
        _cancelButton.hidden = YES;
        _textFiled.text = @"";
        _placeholderLabel.hidden = NO;
        //        _bgView.backgroundColor = HEXCOLOR(0xe3e4e5);
        //        _placeholderLabel.textColor = HEXACOLOR(0x000000, 0.5);
        _iconView.image = [UIImage imageNamed:@"icon_search"];
        [_textFiled resignFirstResponder];
        [UIView animateWithDuration:0.2 animations:^{
            _bgView.frame = DVRectMake(0, 0, self.width, self.height);
            _iconView.left = _normalPaddingLeft;
            _placeholderLabel.left = _iconView.right + 5;

            _bgView.backgroundColor = HEXCOLOR(0xe3e4e5);
            _placeholderLabel.textColor = HEXACOLOR(0x000000, 0.5);
        }
            completion:^(BOOL finished){

            }];
    }
}

@end
