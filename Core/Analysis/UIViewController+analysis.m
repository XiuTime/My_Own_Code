//
//  UIViewController+analysis.m
//  gannicus
//
//  Created by psy on 13-12-11.
//  Copyright (c) 2013年 bbk. All rights reserved.
//

#import "DVAnalysis.h"
#import "UIViewController+analysis.h"
#import <objc/runtime.h>

@implementation UIViewController (analysis)

+ (void)load
{
    Method viewDidAppear = class_getInstanceMethod([UIViewController class], @selector(viewDidAppear:));
    Method trackPageViewDidAppear = class_getInstanceMethod([UIViewController class], @selector(trackPageViewDidAppear:));
    method_exchangeImplementations(viewDidAppear, trackPageViewDidAppear);

    Method viewDidDisAppear = class_getInstanceMethod([UIViewController class], @selector(viewDidDisappear:));
    Method trackPageViewDidDisAppear = class_getInstanceMethod([UIViewController class], @selector(trackPageViewDidDisAppear:));
    method_exchangeImplementations(viewDidDisAppear, trackPageViewDidDisAppear);
}

- (NSString*)pageName
{
    return [self.class description] ? [self.class description] : @"unknownPage";
}

- (NSMutableDictionary*)pageParameter
{
    return nil;
}

- (void)trackPageViewDidAppear:(BOOL)animation
{
    [self trackPageViewDidAppear:animation];

    [self sendAnalysis];
}

- (void)trackPageViewDidDisAppear:(BOOL)animation
{
    [self trackPageViewDidDisAppear:animation];

    NSString* pageName = self.pageName ? self.pageName : [self.class description];
    //屏蔽掉一些非主动的页面
    if ([pageName isEqualToString:@"DVNavController"] || [pageName isEqualToString:@"MSKTabbarController"] || [pageName isEqualToString:@"UIInputWindowController"]) {
        return;
    }
    [DVAnalysis logLeavingPage:self.pageName withParameters:nil];
}

- (void)sendAnalysis
{
    NSString* pageName = self.pageName ? self.pageName : [self.class description];
    //屏蔽掉一些非主动的页面
    if ([pageName isEqualToString:@"DVNavController"] || [pageName isEqualToString:@"MSKTabbarController"] || [pageName isEqualToString:@"UIInputWindowController"]) {
        return;
    }
    [DVAnalysis logPage:pageName withParameters:self.pageParameter];
}

- (UIViewController*)preViewController
{

    //通过parentViewController来判断
    if (self.parentViewController) {
        //push 页面
        if (self.navigationController) {
            NSInteger nowIndex = [self.navigationController.viewControllers indexOfObject:self.navigationController.topViewController];
            if (nowIndex >= 1) {
                return [self.navigationController.viewControllers objectAtIndex:nowIndex - 1];
            }
        }
    }
    else {
        //present的页面
        //return self.presentingViewController;
        //present出来的页面暂时无法访问上一个页面，暂不处理
    }

    return nil;
}

@end
