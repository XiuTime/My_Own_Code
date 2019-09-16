//
//  UIButtonExtend.h
//  IBY
//
//  Created by panShiyu on 14/12/3.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (helper)

+ (instancetype)buttonWithNormalBg:(NSString*)normalBg hlBg:(NSString*)hlBg;

+ (instancetype)buttonWithNormalIconName:(NSString*)normalIcon hlIconName:(NSString*)hlIcon;

+(instancetype)greenBtnWithTitle:(NSString *)title;
+(instancetype)whiteBtnWithTitle:(NSString *)title;
-(void)updataLike;
-(void)updataUnLike;
-(void)updataBarUnLike;
-(void)updataBarLike;

@property(nonatomic, assign)UIEdgeInsets hitTestEdgeInsets;


@property (nonatomic,assign)NSString *title;
@property (nonatomic,assign)UIFont *titleFont;
@property (nonatomic,assign)UIColor *titleColor;

@property (nonatomic,assign)UIImage *backgroundImage;
@property (nonatomic,assign)UIImage *highlightedBackgroundImage;
@property (nonatomic,assign)UIImage *disabledBackgroundImage;

@property (nonatomic,assign)UIImage *image;

@end
