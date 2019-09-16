//
//  BYBasePopoverView.h
//  IBY
//
//  Created by panshiyu on 14-10-22.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MHPopoverDismissBlock)();

@interface DVBasePopoverView : UIView <UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL autoHideWhenTapBg; //default is YES

@property (nonatomic,copy)MHPopoverDismissBlock dismissBlk;

+ (instancetype)createPopoverView;

- (void)showInView:(UIView*)view;
- (void)hide;

@end
