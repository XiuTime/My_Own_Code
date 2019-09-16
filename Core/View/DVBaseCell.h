//
//  DVBaseCell.h
//  MakeHave
//
//  Created by pppsy on 15/8/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "Masonry.h"
#import <UIKit/UIKit.h>

@interface DVBaseCell : UIControl

@property (nonatomic, strong) UIImage* highlightBg;
@property (nonatomic, strong) UIImage* normalBg;
@property (nonatomic, assign) BOOL showRightArrow;
@property (nonatomic, assign) BOOL showBottomLine;

@property (nonatomic, strong) UIImageView* bottomLine;

- (void)setup;

@end

@interface DVTitleCell : DVBaseCell

@property (nonatomic, strong) UILabel* keyLabel;
@property (nonatomic, strong) UILabel* valueLabel;
@property (nonatomic, strong) UILabel* descLabel; //用来扩展用

+ (instancetype)controlWithFrame:(CGRect)frame
                             key:(NSString*)key
                           value:(NSString*)value;

@end
