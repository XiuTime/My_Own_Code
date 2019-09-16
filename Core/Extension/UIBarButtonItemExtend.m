//
//  UIBarButtonItemExtend.m
//  MakeHave
//
//  Created by pppsy on 15/8/16.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "UIBarButtonItemExtend.h"

@implementation UIBarButtonItem (helper)

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title
                             handler:(void (^)(id sender))handler
{

    return [[UIBarButtonItem alloc] bk_initWithTitle:title style:UIBarButtonItemStylePlain handler:handler];
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title
                              target:(id)target
                                 sel:(SEL)selector
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:selector];
    return item;
}

+ (UIBarButtonItem*)barItemWithImage:(NSString*)imgName
                              target:(id)target
                              action:(SEL)action
{
    return [self barItemWithImage:imgName hlImage:imgName target:target action:action];
}

+ (UIBarButtonItem*)barItemWithImage:(NSString*)imgName
                             hlImage:(NSString*)hlImgName
                              target:(id)target
                              action:(SEL)action;
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button.frame = CGRectMake(0, 0, 31, 23);
    //    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    UIImage* image = [UIImage imageNamed:imgName];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    if (hlImgName) {
        [button setImage:[UIImage imageNamed:hlImgName] forState:UIControlStateHighlighted];
    }

    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (NSArray*)spacebarItemWithImage:(NSString*)imgName
                           target:(id)target
                           action:(SEL)action
{
    UIBarButtonItem* item = [UIBarButtonItem barItemWithImage:imgName target:target action:action];
    UIBarButtonItem* spacer = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                             target:nil
                             action:nil];
    spacer.width = -10;
    return @[ spacer, item ];
}

@end
