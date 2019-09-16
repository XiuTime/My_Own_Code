//
//  DVNavController.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVNavController.h"

@interface DVNavController ()
@property (nonatomic, assign, readonly) BOOL isLocked;
@end

@implementation DVNavController

#pragma mark -

+ (instancetype)nav:(UIViewController*)viewController
              title:(NSString*)title
{
    DVNavController* nav = [[DVNavController alloc] initWithRootViewController:viewController];
    nav.rootController = viewController;
    nav.delegate = nav;
    [nav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav_bg"] resizableImage] forBarMetrics:UIBarMetricsDefault];
//    [nav.navigationBar setBackgroundColor:HEXCOLOR(0xffffff)];
//    if (title) {
//        viewController.navigationItem.title = title;
//    }
//
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//
//    NSDictionary* dict = @{ NSForegroundColorAttributeName : HEXCOLOR(0x4c4c4c),
//        NSFontAttributeName : BoldFont(18) };
    
//    nav.navigationBar.titleTextAttributes = dict;
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    nav.navigationBar.barTintColor = HEXCOLOR(0x82be55);


    nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
  //  nav.navigationBar.tintColor = HEXCOLOR(0xffffff);
    
    

    //    nav.navigationBar.alpha = 0.300;
    nav.navigationBar.translucent = NO;

    //    nav.navigationBar.barTintColor = HEXCOLOR(0xfcfeff);
    
    
//    隐藏导航栏的底线
//    [nav.navigationBar setBackgroundImage:[[UIImage alloc] init]
//                                                 forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];
//    
      [nav.navigationBar setShadowImage:[[UIImage alloc] init]];

    
    return nav;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationBar.tintColor = HEXCOLOR(0xffffff);
    
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    if (_willDismissBlk) {
        _willDismissBlk();
    }
    [super dismissViewControllerAnimated:flag completion:^{
        if (_didDismissBlk) {
            _didDismissBlk();
        }
        if (completion) {
            completion();
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIViewController*)rootController
{
    return [self.viewControllers firstObject];
}

- (UIViewController*)popViewControllerAnimated:(BOOL)animated
{
//    if (!_canPop) {
//        return nil;
//    }
    [self.view endEditing:YES];
    _isLocked = YES;
    return [super popViewControllerAnimated:animated];
}

- (UIViewController*)currentVC{
    UIViewController* topVC = [(DVNavController*)self topViewController];
    
    if (topVC.presentedViewController) {
        return topVC.presentedViewController;
    }
    else {
        return topVC;
    }
}

- (void)pushViewController:(UIViewController*)viewController
                  animated:(BOOL)animated
{
    if (_isLocked) {
        DVLog(@"can not push nav coz push lock");
        return;
    }
    
    _isLocked = YES;
    
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController*)navigationController
      willShowViewController:(UIViewController*)viewController
                    animated:(BOOL)animated
{
    if (viewController.navigationItem.leftBarButtonItem == nil && [navigationController viewControllers].count > 1) {
        
        UIButton* button = [UIButton buttonWithNormalIconName:@"nav_btn_back" hlIconName:@"nav_btn_back"];
        [button bk_addEventHandler:^(id sender) {
            [self popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = 10;
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[barItem];
    }
    
    [navigationController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        _isLocked = YES;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        _isLocked = NO;
    }];
}

- (void)navigationController:(UINavigationController*)navigationController
       didShowViewController:(UIViewController*)viewController
                    animated:(BOOL)animated
{
    _isLocked = NO;
}
@end

DVNavController* makeNavController(UIViewController *vc, NSString *title, DVNavDismissBlk willDismissBlk,DVNavDismissBlk didDismissBlk) {
    DVNavController* nav = [DVNavController nav:vc title:title];
    nav.willDismissBlk = willDismissBlk;
    nav.didDismissBlk = didDismissBlk;
    return nav;
}


