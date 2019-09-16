//
//  MBProgressHUD+Extension.h
//  IBY
//
//  Created by coco on 14-9-23.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)
@property (nonatomic,assign) double runAngle;
@property (nonatomic,assign) BOOL stopAnimation;
@property (nonatomic,strong) UIImageView *runView;

+ (void)showSuccess:(NSString*)success toView:(UIView*)view;
+ (void)showError:(NSString*)error toView:(UIView*)view;

+ (MBProgressHUD*)showMessage:(NSString*)message toView:(UIView*)view;

+ (void)showSuccess:(NSString*)success;
+ (void)showError:(NSString*)error;

+ (MBProgressHUD*)showMessage:(NSString*)message;

+ (void)hideHUDForView:(UIView*)view;
+ (void)hideHUD;

//add by psy
+ (void)topShow:(NSString*)message;
+ (void)topShowLoading;
+ (void)topShowLoadingFromView:(UIView *)view;
+ (void)topHide;

+ (void)topShowTmpMessage:(NSString*)message;

@end

void dv_showTmpMessage(NSString *msg);
void dv_showJustLoading();
void dv_showLoading(NSString *msg);
void dv_hide();
