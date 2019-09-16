//
//  MBProgressHUD+Extension.m
//  IBY
//
//  Created by coco on 14-9-23.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import "MBProgressHUD+Extension.h"
#import <objc/runtime.h>

@interface MBProgressHUD () {
    
    
    
}

@end
@implementation MBProgressHUD (Extension)
static char angleKey;
static char stopAnimationKey;
static char runViewKey;

#pragma mark 显示信息
+ (void)show:(NSString*)text icon:(NSString*)icon view:(UIView*)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString*)error toView:(UIView*)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString*)success toView:(UIView*)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD*)showMessage:(NSString*)message toView:(UIView*)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString*)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString*)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD*)showMessage:(NSString*)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView*)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

static MBProgressHUD* keyWindowHUD = nil;
+ (void)topShow:(NSString*)message
{
    [self topHide];
    
    //    keyWindowHUD = [self showMessage:message toView:[UIApplication sharedApplication].keyWindow];
    
    // 快速显示一个提示信息
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    keyWindowHUD = hud;
}

+ (void)topShowLoadingFromView:(UIView *)view
{
    [self topHide];
    
    //    MBProgressHUD *hud = [[self alloc] initWithView:view];
    //    hud.removeFromSuperViewOnHide = YES;
    //    [view addSubview:hud];
    //    [hud show:animated];
    //    return MB_AUTORELEASE(hud);
    
    keyWindowHUD = ({
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithFrame:view.frame];
        hud.removeFromSuperViewOnHide = YES;
        hud.dimBackground = NO;
        
        
        UIImageView * customview = [[UIImageView alloc] initWithFrame:DVRectMake(0, 0, 41, 41)];
        customview.image = [UIImage imageNamed:@"icon_mj_refresh"];
        
        //        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform" ];
        //        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        //        animation.duration = 3;
        //        animation.repeatCount = 9999;
        //        animation.fromValue = [NSNumber numberWithFloat:0.0];
        //        animation.toValue = [NSNumber numberWithFloat:M_PI];
        
        //        [customview startAnimating];
        hud.runView = customview;
        hud.customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [hud.customView addSubview:hud.runView];
        hud.runView.center = CGPointMake(25, 25);
        //        hud.customView.alpha = 0;
        //        hud.alpha = 0;
        //        hud.customView.opaque = NO;
        //        hud.opaque = NO;
        //        hud.customView = customview;
        hud.customView.backgroundColor = [UIColor clearColor];
        hud.mode = MBProgressHUDModeCustomView;
        hud.color = [UIColor clearColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        
        //        [customview.layer addAnimation:animation forKey:@"rotate-layer"];
        
        
        hud;
    });
    keyWindowHUD.runAngle = 0;
    keyWindowHUD.stopAnimation = NO;
    [keyWindowHUD startRun];
    [keyWindowHUD show:NO];
    
}

+ (void)topShowLoading {
    [MBProgressHUD topShowLoadingFromView:[UIApplication sharedApplication].keyWindow];
}
- (void)startRun
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.runAngle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.runView.transform = endAngle;
    } completion:^(BOOL finished) {
        if (self.stopAnimation) {
            self.runView.hidden = YES;
            return;
        }
        self.runAngle += 10;
        [self startRun];
    }];
    
}
+ (void)topShowLoading2 {
    [self topHide];
    
    
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    
    
    
    hud.labelText = @"loading";
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_mj_refresh"]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:2];
}

+ (void)topHide
{
    if (keyWindowHUD) {
        keyWindowHUD.stopAnimation = YES;
        [keyWindowHUD removeFromSuperview];
        keyWindowHUD = nil;
    }
}

+ (void)topShowTmpMessage:(NSString*)message
{
    [self topHide];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //    hud.labelText = message;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    //    hud.dimBackground = YES;
    //    float time = message.length * .2;
    [hud hide:YES afterDelay:2];
}

- (void) setRunAngle:(double) angle{
    objc_setAssociatedObject(self, &angleKey, @(angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (double) runAngle{
    return [objc_getAssociatedObject(self, &angleKey) doubleValue];
}

- (void) setStopAnimation:(BOOL) stopAnimation{
    objc_setAssociatedObject(self, &stopAnimationKey, @(stopAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) stopAnimation{
    return [objc_getAssociatedObject(self, &stopAnimationKey) boolValue];
}

- (void) setRunView:(UIImageView*) customView{
    objc_setAssociatedObject(self, &runViewKey, customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView*) runView{
    return objc_getAssociatedObject(self, &runViewKey);
}
@end

void dv_showTmpMessage(NSString *msg){
    [MBProgressHUD topShowTmpMessage:msg];
}

void dv_showJustLoading() {
    [MBProgressHUD topShowLoading];
}

void dv_showLoading(NSString *msg){
    [MBProgressHUD topShow:msg];
}
void dv_hide(){
    [MBProgressHUD topHide];
}


