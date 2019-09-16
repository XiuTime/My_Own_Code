//
//  DVBaseVC.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVBaseVC.h"
#import "DVPoolNetworkView.h"

@interface DVBaseVC () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSDate* enterTime; //进入时刻
@property (nonatomic, strong) NSDate* lastleaveTime; //上次离开时刻
@property (nonatomic, assign) double sumLeaveTime; //离开时间总计
@end

@implementation DVBaseVC {
    UITapGestureRecognizer* _tapGesture;
    UIView* _tipsView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = DVBgColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_enterTime) {
        _enterTime = [NSDate date];
    }

    if (_lastleaveTime) {
        _sumLeaveTime += fabs([_lastleaveTime timeIntervalSinceNow]);
        _lastleaveTime = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    _lastleaveTime = [NSDate date];
}

- (void)setAutoHideKeyboard:(BOOL)autoHideKeyboard
{
    _autoHideKeyboard = autoHideKeyboard;

    if (!_autoHideKeyboard) {
        if (_tapGesture) {
            [self.view removeGestureRecognizer:_tapGesture];
            _tapGesture = nil;
        }
    }
    else {
        if (!_tapGesture) {
            _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap)];
            _tapGesture.cancelsTouchesInView = NO;
            _tapGesture.delegate = self;
            [self.view addGestureRecognizer:_tapGesture];
        }
    }
}

- (void)onBackgroundTap
{
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        if ([touch.view isKindOfClass:[UIControl class]] && ![touch.view isKindOfClass:[UIScrollView class]]) {
            return NO;
        }
    }

    return YES;
}

#pragma mark - tips

- (void)showTipsView:(NSString*)tips icon:(NSString*)icon
{
    [self hideTipsView];

    _tipsView = [DVEmptyView emptyviewWithIcon:icon tips:tips];
    [self.view addSubview:_tipsView];
}

- (void)hideTipsView
{
    if (_tipsView) {
        [_tipsView removeFromSuperview];
        _tipsView = nil;
    }
}

#pragma mark -

- (int)activeTime
{
    //当前时间 - 进入时间 - 停止时间
    return (int)(1000 * (fabs([_enterTime timeIntervalSinceNow]) - _sumLeaveTime)); //mult 1000,to int.
}

@end
