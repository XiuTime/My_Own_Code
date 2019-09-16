//
//  UILabelExtend.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "UILabelExtend.h"

#define kTagRedBadge 2001

@implementation UILabel (helper)

+ (instancetype)labelWithFrame:(CGRect)frame font:(UIFont*)font andTextColor:(UIColor*)textColor
{
    UILabel* label = [[self alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    if (textColor) {
        label.textColor = textColor;
    }
    
    return label;
}
-(void)dvAttributeSmallWithString:(NSString *)str name:(NSAttributedStringKey)name value:(id)value range:(NSRange)range{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:name
                    value:value
                    range:range];
    self.attributedText = attrStr;
}

- (void)dvResizeHeight {
    CGSize newSize = [self.text sizeWithFont:self.font maxSize:CGSizeMake(self.width, MAXFLOAT)];
    self.height = ceilf(newSize.height);
}
- (void)dvResizeWidth {
    CGSize newSize = [self.text sizeWithFont:self.font maxSize:CGSizeMake(MAXFLOAT, self.height)];
    self.width = ceilf(newSize.width);
}

- (void)dvSetTextWithAutosizeH:(NSString *)text {
    self.text = text;
    [self dvResizeHeight];
}

- (void)dvSetText:(NSString *)text lineLimit:(int)maxLine{
    NSString *onelineText = @"一行字";
    CGFloat oneH = ceilf([onelineText sizeWithFont:self.font maxSize:CGSizeMake(self.width, MAXFLOAT)].height);
    CGFloat maxH = oneH * maxLine;
    
    CGFloat willH = ceilf([text sizeWithFont:self.font maxSize:CGSizeMake(self.width, MAXFLOAT)].height);
    CGFloat realH = MIN(maxH, willH);
    
    self.text = text;
    self.height = realH;
}

- (void)addRedBadge {
     UIView* badgeV = [self viewWithTag:kTagRedBadge];
    if (!badgeV) {
        badgeV = [[UIView alloc] initWithFrame:DVRectMake(0, 0 , 6, 6)];
        badgeV.backgroundColor = [UIColor redColor];
        badgeV.layer.cornerRadius = 3;
        badgeV.tag = kTagRedBadge;
        badgeV.clipsToBounds = YES;
        [self addSubview:badgeV];
    }
    
    
    CGFloat bWidth = labelW(self.text, self.font);
    CGFloat txtRight = 0;
    if (self.textAlignment == NSTextAlignmentLeft) {
        txtRight = bWidth;
    }else if (self.textAlignment == NSTextAlignmentCenter){
        txtRight =  self.width/ 2 + bWidth / 2;;
    }else if (self.textAlignment == NSTextAlignmentRight) {
        txtRight = self.width;
    }else{//按照left处理
        txtRight = bWidth;
    }
    
    CGFloat oneH = labelH(self.text, self.font, self.width);
    CGPoint bCenter = CGPointMake(txtRight + 3, self.height - oneH - 6);
    badgeV.center = bCenter;
    
}
- (void)removeRedBadge {
    UIView* badgeV = [self viewWithTag:kTagRedBadge];
    if (badgeV) {
        [badgeV removeFromSuperview];
    }
}

+ (CGFloat)heightWithFont:(UIFont*)font lineLimt:(int)maxline{
    NSString *onelineText = @"一行字";
    CGFloat oneH = ceilf([onelineText sizeWithFont:font maxSize:CGSizeMake(300, MAXFLOAT)].height);
    return ceilf(oneH * maxline);
}

@end
