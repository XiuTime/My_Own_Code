//
//  UIButtonExtend.m
//  IBY
//
//  Created by panShiyu on 14/12/3.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import "UIButtonExtend.h"
#import <objc/runtime.h>

@implementation UIButton (helper)

//+ (instancetype) greenBtn {
//    
//}
-(void)updataLike{
    self.backgroundColor = HEXCOLOR(0xffffff);
    self.titleColor = HEXCOLOR(0x4bba4c);
    self.layer.borderColor = [HEXCOLOR(0x4bba4c) CGColor];
 //   self.image = [UIImage imageNamed:@"btn_icon_followed"];
    self.layer.borderWidth = 1;
}
-(void)updataUnLike{
    self.titleColor = HEXCOLOR(0xffffff);
    self.backgroundColor = HEXCOLOR(0x43bc68);
    [self.layer setBorderWidth:0];
  //  self.image = [UIImage imageNamed:@"btn_icon_follow_defult"];
}
-(void)updataBarUnLike{
    self.titleColor = HexColor2;
    self.image = [UIImage imageNamed:@"btn_icon_follow_nor"];
}
-(void)updataBarLike{
    self.backgroundColor = HEXCOLOR(0xffffff);
    self.titleColor = HEXCOLOR(0x43bc68);
    self.image = [UIImage imageNamed:@"btn_icon_follow_on"];
}

+(instancetype)greenBtnWithTitle:(NSString *)title{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundImage = [[UIImage imageNamed:@"nav_bg"] resizableImage];
    button.title = title;
    return button;
}

+(instancetype)whiteBtnWithTitle:(NSString *)title{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = HEXCOLOR(0xffffff);
    button.titleColor = HexColor3;
    button.title = title;
    return button;
}

+ (instancetype)buttonWithNormalBg:(NSString*)normalBg hlBg:(NSString*)hlBg
{
    UIButton* button = [[UIButton alloc] init];
    [button setBackgroundImage:[[UIImage imageNamed:normalBg] resizableImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:hlBg] resizableImage] forState:UIControlStateHighlighted];
    return button;
}

+ (instancetype)buttonWithNormalIconName:(NSString*)normalIcon hlIconName:(NSString*)hlIcon
{
    UIButton* button = [[UIButton alloc] init];
//    button.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    [button setImage:[UIImage imageNamed:normalIcon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hlIcon] forState:UIControlStateHighlighted];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGSize imgSize = button.imageView.image.size;
    button.size = CGSizeMake(imgSize.width, imgSize.height);
    button.hitTestEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    return button;
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}
- (NSString *)title {
    return self.currentTitle;
}
- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}
- (UIColor *)titleColor {
    return self.currentTitleColor;
}
- (void)setTitleFont:(UIFont *)titleFont {
    self.titleLabel.font = titleFont;
}
- (UIFont *)titleFont {
    return self.titleLabel.font;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}
- (UIImage *)backgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}
- (void)setHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage {
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}
- (UIImage *)highlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}
- (void)setDisabledBackgroundImage:(UIImage *)disabledBackgroundImage {
    [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}
- (UIImage *)disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}
- (UIImage *)image {
    return [self imageForState:UIControlStateNormal];
}


@dynamic hitTestEdgeInsets;

static const NSString* KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if (value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }
    else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);

    return CGRectContainsPoint(hitFrame, point);
}

@end
