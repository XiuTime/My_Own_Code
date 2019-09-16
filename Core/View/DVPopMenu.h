//
//  DVPopMenu.h
//  MakeHavee eetytyyyd//
//  Created by pppsy on 15/8/16.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVPopMenu : UIView
@property (nonatomic, strong) UIImageView* container;
@property (nonatomic, strong) NSMutableArray* btnlist;
@property (nonatomic, copy) void (^animationDoneBlock)();

+ (instancetype)createPopoverView;

- (void)hide;
- (void)showInView:(UIView*)view;

- (void)addBtnWithTitle:(NSString*)title
                   icon:(NSString*)icon
                hasLine:(BOOL)hasLine
               selected:(BOOL)isSelected
                handler:(void (^)(id sender))handler;

- (void)addBtnWithTitle:(NSString*)title
                   icon:(NSString*)icon
                 hlIcon:(NSString*)hlIcon
                hasLine:(BOOL)hasLine
               selected:(BOOL)isSelected
                handler:(void (^)(id sender))handler;

@end
