//
//  MHCustomButton.h
//  MakeHave
//
//  Created by psy on 15/8/5.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVCustomButton : UIControl
@property (nonatomic,strong) UIImageView *bgView;
@property (nonatomic,strong) UIImageView *imgView;//highted image == selected image
@property (nonatomic,strong) UILabel *txtlabel;
@property (nonatomic,assign) CGFloat padding;

- (void)updateIcon:(NSString*)normalIcon hlIcon:(NSString*)hlIcon size:(CGSize)size;
- (void)updateTitle:(NSString*)title color:(UIColor*)color font:(UIFont*)font;
- (void)resetUI;//确保里面是有内容之后再来执行这个方法

@end

