//
//  DVMacro.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#ifndef MakeHave_DVMacro_h
#define MakeHave_DVMacro_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//现在给的图素都是750宽，需要图片等比例的时候，需要用到 DELTA_ITEM_HEIGHT
#define DELTA_ITEM_HEIGHT (SCREEN_WIDTH / 750)

//默认字体
#define Font(x) [UIFont systemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]

#define DVBgColor HEXCOLOR(0xf6f6f6)
//#define DVBgColor HEXCOLOR(0x103057)
#define kLineColor 0xe5e5e5

#define HEXCOLOR(hexValue)                                                 \
    [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 \
                    green:((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0    \
                     blue:((CGFloat)(hexValue & 0xFF)) / 255.0             \
                    alpha:1.0]

#define HEXACOLOR(hexValue, alphaValue)                                    \
    [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 \
                    green:((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0    \
                     blue:((CGFloat)(hexValue & 0xFF)) / 255.0             \
                    alpha:(alphaValue)]

#ifdef DEBUG
#define DVLog(...) NSLog(__VA_ARGS__)
#else
#define DVLog(...)
#endif

#define  ARC4RANDOM(from,to) (int)(from + (arc4random() % (to - from + 1)))


// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define DVArcticleCss @"<style>img {width:100%;heighy:auto}body {font-size:14px;color:#333333}</style>"
/*body{margin:0!important;margin-top:10px!important;padding-top:0;padding-bottom:0;padding-left:15;padding-right:16;background-color:transparent;color:#333333!important;word-wrap:break-word;word-break:break-all;font:14px/16px system!important}p{margin:0;font:14px/16px system!important;color:#8f8f8f;line-height:1.3!important;padding-bottom:16px!important}img{max-height:720px;max-width:640px;width:expression(this.width > 640 && this.height < this.width ? 640: true);height:expression(this.height > 720 ? 720: true);}p img{width:100%!important;height:auto!important}div img{width:100%!important;height:auto!important}p video{width:100%!important;height:auto!important}span{font:14px/16px system!important;line-height:1.2!important}br{display:inline;line-height:110px}*/

#define DVLog_Class_Function DVLog(@"%@ %s", [self class], __FUNCTION__);

#define DVRectMake(x, y, width, height)          \
    CGRectMake(floor(x), floor(y), floor(width), \
        floor(height)) //防止frame出现小数，绘制模糊

#define DVPointMake(x, y) CGPointMake(x, y)
#define DVSizeMake(width, height) CGSizeMake(width, height)

#define kTipAlert(_S_, ...) [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define IOS9 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define DXKeyboardAnimation(block) [UIView animateWithDuration:0.25 delay:0 options:7<<16 animations:block completion:nil];

#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"user"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"user"]:@""





#endif
