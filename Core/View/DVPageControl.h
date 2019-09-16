//
//  MHPageControl.h
//  MakeHave
//
//  Created by forbertl on 15/12/2.
//  Copyright © 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVPageControl : UIView

- (instancetype)initWithFrame:(CGRect)frame
                      dotSize:(CGSize)dotSize
                   ditPadding:(CGFloat)dotPadding;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic) UIImage* activeImage;
@property (nonatomic) UIImage* inactiveImage;

- (void)resetUIByTotal:(int)total;

@end
