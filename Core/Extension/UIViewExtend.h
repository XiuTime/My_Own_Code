//
//  UIViewExtend.h
//  DVMobile
//
//  Created by panshiyu on 14-11-3.
//  Copyright (c) 2014年 mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

- (void)addTapAction:(SEL)tapAction target:(id)target;

//- (UIView*)findViewThatIsFirstResponder;
- (UIViewController*)viewController;

- (void)removeAllSubviews;


- (void)doCircleFrame;
- (void)doCircleFrameWithBorderColor:(UIColor*)color;
- (void)doCircleFrameWithBorderColor:(UIColor *)color bWidth:(CGFloat)bWidth;
- (void)doNotCircleFrame;
- (void)doCircleBeadWithCornerRadius:(CGFloat )cornerRadius;

- (void)addBadgeTip:(NSString *)badgeValue atCenterPos:(CGPoint)center;
- (void)removeBadgeTips;

- (void)addTopLine;
- (void)addBottomLine;
- (void)hideTopLine;
- (void)hideBottomLine;
- (void)addTopLineWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding;
- (void)addBottomLineWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding;
- (void)addTopLineByConstraintWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding;
- (void)addBottomLineByConstraintWithLeft:(CGFloat)leftpadding right:(CGFloat)rightPadding;


- (void)addRightArrow;

+(void)AddRoundedCorners:(UIView*)view size:(float)size type:(int)type;
+(void)AddRoundedCorners:(UIView*)view rect:(CGRect)rect size:(float)size type:(int)type;
//截屏
-(UIImage *)captureScreenForView;
@end
