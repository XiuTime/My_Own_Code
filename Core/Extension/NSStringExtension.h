//
//  NSStringExtension.h
//  IBY
//
//  Created by panshiyu on 14/11/7.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (helper)

//获得路径最后一段 去掉类型
-(NSString *)lastPathComponentDeleteString:(NSString *)str;

//MD5一下
- (NSString*)generateMD5;

//encoding & decoding
- (NSString*)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
- (NSString*)URLEncodedString;
- (NSString*)URLDecodedString;

// url params
- (NSDictionary*)parseURLParams;

//quick append
- (NSString*)append:(NSString*)str;
- (NSString*)appendNum:(int)num;

//remove html

- (NSString*)stripHtml;

- (CGSize)sizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont*)font;
//播放器时间转换
+ (NSString *)convertTime:(NSTimeInterval)second;

- (BOOL)isValidNickname;
- (BOOL)isValidateMobile;
- (BOOL)isNumber;
- (BOOL)isPassWord;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

CGFloat labelW(NSString *text,UIFont *font);//一行
CGFloat labelH(NSString *text,UIFont *font,CGFloat width);
CGFloat labelHWithLimit(NSString *text,UIFont *font,CGFloat width,int maxLine);

CGFloat labelHWithAttr(NSMutableAttributedString* str,UIFont *font,CGFloat width);
CGFloat labelHWithAttrAndLimit(NSMutableAttributedString* str,UIFont *font,CGFloat width,int maxLine);
