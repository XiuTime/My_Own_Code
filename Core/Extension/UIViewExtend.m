
//
//  UIViewExtend.m
//  DVMobile
//
//  Created by panshiyu on 14-11-3.
//  Copyright (c) 2014年 mobile. All rights reserved.
//

#import "Masonry.h"
#import "UIViewExtend.h"

#define kTagBadgeView 1000
#define kTagBadgePointView 1001
#define kTagLineView 1007

#define kTagTopLine 1100
#define kTagBottomLine 1101
#define kTagRightArrow 1102

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setTop:(CGFloat)t
{
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)b
{
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l
{
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r
{
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark -

- (void)addTapAction:(SEL)tapAction target:(id)target
{
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:tapAction];
    gesture.cancelsTouchesInView = NO;
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:gesture];
}

//- (UIView*)findViewThatIsFirstResponder
//{
//    if (self.isFirstResponder) {
//        return self;
//    }
//
//    for (UIView* subView in self.subviews) {
//        UIView* firstResponder = [subView findViewThatIsFirstResponder];
//        if (firstResponder != nil) {
//            return firstResponder;
//        }
//    }
//    return nil;
//}

- (UIViewController*)viewController
{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)removeAllSubviews
{
    for (UIView* subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)doCircleFrame
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = HEXCOLOR(0xdddddd).CGColor;
}

- (void)doCircleFrameWithBorderColor:(UIColor*)color
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = color.CGColor;
}

- (void)doCircleFrameWithBorderColor:(UIColor *)color bWidth:(CGFloat)bWidth{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderWidth = bWidth;
    self.layer.borderColor = color.CGColor;
}

- (void)doNotCircleFrame
{
    self.layer.cornerRadius = 0.0;
    self.layer.borderWidth = 0.0;
}
- (void)doCircleBeadWithCornerRadius:(CGFloat )cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)removeBadgeTips
{
    UILabel* badgeV = [self viewWithTag:kTagBadgeView];
    if (badgeV) {
        [badgeV removeFromSuperview];
    }
}

- (void)addBadgeTip:(NSString*)badgeValue atCenterPos:(CGPoint)center
{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }
    else {
        UILabel* badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UILabel class]]) {
            badgeV.hidden = NO;
        }
        else {
            badgeV = [[UILabel alloc] init];
//            badgeV.backgroundColor = HEXCOLOR(0xb29510);
            badgeV.backgroundColor = [UIColor redColor];
            badgeV.font = Font(14);
            badgeV.textColor = [UIColor whiteColor];
            badgeV.textAlignment = NSTextAlignmentCenter;
            badgeV.tag = kTagBadgeView;
            badgeV.clipsToBounds = YES;
            [self addSubview:badgeV];
        }

        CGSize bSize = [badgeValue sizeWithFont:Font(14) maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        badgeV.size = CGSizeMake(ceilf(bSize.width) + 10, ceilf(bSize.width) + 10);
        badgeV.layer.cornerRadius = badgeV.size.width / 2;
        badgeV.text = badgeValue;
        [badgeV setCenter:center];
    }
}

- (void)addTopLine
{
    [self addTopLineWithLeft:0 right:0];
}

- (void)addBottomLine
{
    [self addBottomLineWithLeft:0 right:0];
}
- (void)hideTopLine
{
    UIImageView* line = [self viewWithTag:kTagTopLine];
    if (line) {
        [line removeFromSuperview];
    }
}
- (void)hideBottomLine
{
    UIImageView* line = [self viewWithTag:kTagBottomLine];
    if (line) {
        [line removeFromSuperview];
    }
}

- (void)addTopLineWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding
{
    UIImageView* line = [self viewWithTag:kTagTopLine];
    if (!line) {
        line = makeSepline();
        line.tag = kTagTopLine;
        [self addSubview:line];
    }
    line.top = 0;
    line.left = leftpadding;
    line.width = self.width - leftpadding - rightPadding;
    [self bringSubviewToFront:line];
}

- (void)addBottomLineWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding
{
    UIImageView* line = [self viewWithTag:kTagBottomLine];
    if (!line) {
        line = makeSepline();
        line.tag = kTagBottomLine;
        [self addSubview:line];
    }
    line.bottom = self.height;
    line.left = leftpadding;
    line.width = self.width - leftpadding - rightPadding;
    [self bringSubviewToFront:line];
}

- (void)addRightArrow
{
    UIImageView* arrowView = [self viewWithTag:kTagRightArrow];
    if (!arrowView) {
        arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
        arrowView.frame = DVRectMake(0, 0, 10, 10);
        arrowView.tag = kTagRightArrow;
        [self addSubview:arrowView];
    }

    arrowView.right = SCREEN_WIDTH - 12;
    arrowView.centerY = self.height / 2;
    [self bringSubviewToFront:arrowView];
}

- (void)addTopLineByConstraintWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding
{
    UIImageView* line = [self viewWithTag:kTagTopLine];
    if (!line) {
        line = makeSepline();
        line.tag = kTagTopLine;
        [self addSubview:line];
    }
    [self bringSubviewToFront:line];

    [line mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@0);
        make.left.equalTo(@(leftpadding));
        make.right.equalTo(@(rightPadding));
        make.height.equalTo(@1);
    }];
}
- (void)addBottomLineByConstraintWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding
{
    UIImageView* line = [self viewWithTag:kTagBottomLine];
    if (!line) {
        line = makeSepline();
        line.tag = kTagBottomLine;
        [self addSubview:line];
    }
    [self bringSubviewToFront:line];

    [line mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self);
        make.left.equalTo(@(leftpadding));
        make.right.equalTo(@(rightPadding));
        make.height.equalTo(@1);
    }];
}

+(void)AddRoundedCorners:(UIView*)view size:(float)size type:(int)type{
    [UIView AddRoundedCorners:view rect:view.bounds size:size type:type];
}

+(void)AddRoundedCorners:(UIView*)view rect:(CGRect)rect size:(float)size type:(int)type{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:type cornerRadii:CGSizeMake(size, size)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
}

-(UIImage *)captureScreenForView{
//    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, YES, 0);
//    [self drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:YES];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    return  viewImage;
}

@end
