//
//  DVNavController.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^DVNavDismissBlk)();
@interface DVNavController : UINavigationController<UINavigationControllerDelegate>

@property (nonatomic, strong) UIViewController* rootController;
@property (nonatomic, assign) BOOL canPop;

@property (nonatomic, copy) DVNavDismissBlk willDismissBlk;//在 页面dismiss之前，执行的block
@property (nonatomic, copy) DVNavDismissBlk didDismissBlk;//dimiss之后，执行的

+ (instancetype)nav:(UIViewController*)viewController title:(NSString*)title;

- (UIViewController*)currentVC;


@end

DVNavController* makeNavController(UIViewController *vc, NSString *title, DVNavDismissBlk willDismissBlk,DVNavDismissBlk didDismissBlk);
