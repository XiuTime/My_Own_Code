//
//  DVSearchBar.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DVSearchBarDelegate <NSObject>

- (void)didSearchByKey:(NSString*)key;
- (void)didChangeWithKey:(NSString*)key;

- (void)didBeginEditing;
- (void)didEngEditing;

@end

@interface DVSearchBar : UIView
@property (nonatomic, strong) UIImageView* iconView;
@property (nonatomic, strong) UILabel* placeholderLabel;
@property (nonatomic, strong) UIImageView* bgView;
@property (nonatomic, strong) UITextField* textFiled;
@property (nonatomic, strong) UILabel* cancelLabel;
@property (nonatomic, strong) UIButton* cancelButton;

@property (nonatomic, weak) id<DVSearchBarDelegate> delegate;
@end
