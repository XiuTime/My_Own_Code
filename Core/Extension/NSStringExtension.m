//
//  NSStringExtension.m
//  IBY
//
//  Created by panshiyu on 14/11/7.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import "NSStringExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (URLEncoding)

+ (NSString *)convertTime:(NSTimeInterval)second {
    // 相对格林时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (second / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    
    NSString *showTimeNew = [formatter stringFromDate:date];
    return showTimeNew;
}


- (NSString*)generateMD5
{
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];

    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];

    // Create 16 byte MD5 hash value, store in buffer
    // add by Davidpan 加入cc_long来去除warning
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);

    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output =
        [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", md5Buffer[i]];

    return output;
}

- (NSString*)append:(NSString*)str
{
    if (!str) {
        str = @"";
    }

    return [NSString stringWithFormat:@"%@%@", self, str];
}

- (NSString*)appendNum:(int)num
{
    return [NSString stringWithFormat:@"%@%d", self, num];
}

- (CGSize)sizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize
{
    CGSize size =
        [self boundingRectWithSize:maxSize
                           options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                        attributes:@{
                            NSFontAttributeName : font
                        }
                           context:nil]
            .size;
    return size;
}

- (CGSize)sizeWithFont:(UIFont*)font
{
    return [self sizeWithFont:font maxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
}

#pragma mark -

- (NSDictionary*)parseURLParams
{
    NSString* query = [self copy];
    NSRange range = [query rangeOfString:@"?"];
    if (range.length > 0) {
        query = [query substringFromIndex:range.location + 1];
    }
    NSArray* pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    for (NSString* pair in pairs) {
        NSArray* kv = [pair componentsSeparatedByString:@"="];
        if ([kv isKindOfClass:[NSArray class]] && kv.count == 2) {
            NSString* val = [kv[1]
                stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:val forKey:kv[0]];
        }
    }
    return [params copy];
}

#pragma mark -

- (NSString*)URLEncodedString
{
    CFStringRef result = CFURLCreateStringByAddingPercentEscapes(
        kCFAllocatorDefault, (CFStringRef)self, NULL,
        CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString* tmpResult = CFBridgingRelease(result);
    return tmpResult;
}

- (NSString*)URLDecodedString
{
    CFStringRef result = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
        kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    NSString* tmpResult = CFBridgingRelease(result);
    return tmpResult;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile
{
    //手机号以1开头，10个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isNumber {
    NSString *numberRegex = @"^\\d+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [phoneTest evaluateWithObject:self];
}
-(BOOL)isPassWord{
    NSString *passWordRegex = @"^\\d{8,18}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isValidNickname {
    NSString *passWordRegex = @"[\u4E00-\u9FA5a-zA-Z0-9]+";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [phoneTest evaluateWithObject:self];
}

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    
    if (jsonString == nil) {
        
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    return dic;
}

-(NSString *)lastPathComponentDeleteString:(NSString *)str{
    NSString * path = [self lastPathComponent];
    
    return [path stringByReplacingOccurrencesOfString:str withString:@""];
}


@end

CGFloat labelW(NSString *text,UIFont *font) {
    return ceilf([text sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width);
}

CGFloat labelH(NSString *text,UIFont *font,CGFloat width){
    return ceilf([text sizeWithFont:font maxSize:CGSizeMake(width, MAXFLOAT)].height);
}

CGFloat labelHWithLimit(NSString *text,UIFont *font,CGFloat width,int maxLine) {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    NSString *onelineText = @"一行字";
    CGFloat oneH = ceilf([onelineText sizeWithFont:font maxSize:size].height);
    CGFloat maxH = oneH * maxLine;
    
    CGFloat willH = ceilf([text sizeWithFont:font maxSize:size].height);
    CGFloat realH = MIN(maxH, willH);
    
    return realH;
}


CGFloat labelHWithAttr(NSMutableAttributedString* str,UIFont *font,CGFloat width){
    CGRect r =  [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                     context:nil];
    return r.size.height;
}

CGFloat labelHWithAttrAndLimit(NSMutableAttributedString* str,UIFont *font,CGFloat width,int maxLine) {
    NSMutableAttributedString *onelineText = [[NSMutableAttributedString alloc] initWithString:@"一行字"];
    CGRect oneLineR = [onelineText boundingRectWithSize:CGSizeMake(100, 100)
                                                options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                context:nil];
    CGFloat maxH = ceilf(oneLineR.size.height) * maxLine;
    
    CGRect willR =  [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                  context:nil];
    CGFloat realH = MIN(maxH, willR.size.height);
    
    return realH;
}



