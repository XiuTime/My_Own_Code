//
//  DVPoolNetworkView.h
//  MakeHave
//
//  Created by pppsy on 15/9/18.
//  Copyright © 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVPoolNetworkView : UIView
+ (instancetype)poolNetworkView;
@end

@interface DVEmptyView : UIView
@property (nonatomic, assign) CGFloat contentBottom;

@property (nonatomic,strong,readonly) UIImageView *iconView;
@property (nonatomic,strong,readonly) UILabel *tipsLabel;

+ (instancetype)emptyviewWithIcon:(NSString*)icon
                             tips:(NSString*)tips;

@end

