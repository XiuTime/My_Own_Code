//
//  DVImageView.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVImageView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@implementation DVImageView

- (void)setImageUrl:(NSString*)url
{
    [self setImageWithUrl:url placeholderName:@"bg_placeholder"];
}

- (void)setImageWithUrl:(NSString*)url placeholderName:(NSString*)placeholder
{
    [self setImageWithUrl:url placeholderName:placeholder finish:nil];
}

- (void)setImageWithUrl:(NSString*)url placeholderName:(NSString*)placeholder finish:(void (^)(UIImage* image))finished
{
    if (!url || ![url isKindOfClass:[NSString class]]) {
        DVLog(@"error image");
        self.image = [UIImage imageNamed:placeholder];
//        self.image = nil;
        return;
    }

    if (!_disableAutoScaleFit) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    UIImage* placeHolderImg = placeholder ? [UIImage imageNamed:placeholder] : nil;
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeHolderImg
                     options:(placeHolderImg ? 0 : SDWebImageRetryFailed)
                   completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL* imageURL) {
//                       if (image) {
//                           self.backgroundColor = [UIColor clearColor];
//                       }else{
//                           self.backgroundColor = HEXCOLOR(0xf7f7f7);
//                       }
                       if (finished) {
                           finished(image);
                       }
                   }];
}

@end

@implementation UIButton (imgbutton)

- (void)setImageUrl:(NSString*)url {
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
}

@end
