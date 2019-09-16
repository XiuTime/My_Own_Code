//
//  UIImageExtend.h
//  DVMobile
//
//  Created by pan Shiyu on 14/11/1.
//  Copyright (c) 2014年 mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (helper)
- (UIImage*)resizableImage;
-(UIImage*)scaleToSize:(CGSize)size;
- (UIImage *)aspectScaleImageToSize:(CGSize)newSize;
-(UIImage *)radioScaleToSize:(CGSize)size backgroudColor:(UIColor *)color;

+ (UIImage*)imageFromColor:(UIColor*)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius;

+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

@end
