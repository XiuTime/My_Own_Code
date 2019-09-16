//
//  UIBarButtonItemExtend.h
//  MakeHave
//
//  Created by pppsy on 15/8/16.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (helper)

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title
                             handler:(void (^)(id sender))handler;

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title
                              target:(id)target
                                 sel:(SEL)selector;

+ (UIBarButtonItem*)barItemWithImage:(NSString*)imgName
                              target:(id)target
                              action:(SEL)action;

+ (UIBarButtonItem*)barItemWithImage:(NSString*)imgName
                             hlImage:(NSString*)hlImgName
                              target:(id)target
                              action:(SEL)action;

+ (NSArray*)spacebarItemWithImage:(NSString*)imgName
                           target:(id)target
                           action:(SEL)action;

@end
