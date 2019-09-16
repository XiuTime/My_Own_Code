//
//  DVImageView.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVImageView : UIImageView

@property (nonatomic,assign) BOOL disableAutoScaleFit;//是否禁止自动适配scale，默认是不禁止的

- (void)setImageUrl:(NSString*)url;
- (void)setImageWithUrl:(NSString*)url placeholderName:(NSString*)placeholder;
- (void)setImageWithUrl:(NSString*)url placeholderName:(NSString*)placeholder finish:(void (^)(UIImage* image))finished;

@end

@interface UIButton (imgbutton)
- (void)setImageUrl:(NSString*)url;
@end
