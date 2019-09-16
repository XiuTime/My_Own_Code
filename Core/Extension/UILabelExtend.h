//
//  UILabelExtend.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (helper)

+ (instancetype)labelWithFrame:(CGRect)frame font:(UIFont *)font andTextColor:(UIColor *)textColor;

-(void)dvAttributeSmallWithString:(NSString *)str name:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;

//根据当前的font和frame重置高度
- (void)dvResizeHeight;

- (void)dvSetTextWithAutosizeH:(NSString *)text;
- (void)dvSetText:(NSString *)text lineLimit:(int)maxLine;
- (void)dvResizeWidth;
//只能处理单行的！
- (void)addRedBadge;
- (void)removeRedBadge;

+ (CGFloat)heightWithFont:(UIFont*)font lineLimt:(int)maxline;

@end
