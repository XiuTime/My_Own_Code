//
//  DVNavMenuView.h
//  MakeHave
//
//  Created by pppsy on 15/8/13.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DVMenuButton;
typedef void (^DVNavMenuTapBlock)(DVMenuButton *btn);

//导航栏上使用的下拉菜单
/**设计思路
  许多第三方的都把list和navButton聚合在一起，缺点是复用比较差
  这里，popover 被单独提出来了，menu也是单做 :)
 
 */
@interface DVNavMenuView : UIView
@property (nonatomic, strong) DVMenuButton *menuButton;
@property (nonatomic, copy) DVNavMenuTapBlock tapBlk;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

@end


@interface DVMenuButton : UIButton
@property (nonatomic,strong) UIImageView *arrowView;;
@end
