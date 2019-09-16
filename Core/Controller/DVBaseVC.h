//
//  DVBaseVC.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "UITableViewExtension.h"
#import "masonry.h"
#import <UIKit/UIKit.h>


@interface DVBaseVC : UIViewController

@property (nonatomic, assign) BOOL autoHideKeyboard; //点击空白处自动隐藏键盘
@property (nonatomic, assign, readonly) int activeTime; //获取当前Activity被激活的时间

@property (nonatomic, copy) NSString* fromName; //来自哪里
@property (nonatomic, strong) NSMutableDictionary* fromParmas; //带了哪些参数

//tips
- (void)showTipsView:(NSString*)tips icon:(NSString*)icon;
- (void)hideTipsView;

@end
