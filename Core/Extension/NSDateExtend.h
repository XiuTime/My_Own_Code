//
//  NSDateExtend.h
//  IBY
//
//  Created by panshiyu on 15/1/12.
//  Copyright (c) 2015年 com.makehave. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SECONDS_PER_DAY (60 * 60 * 24)

typedef enum {
    DVDateFormatMMddHHmm,
    DVDateFormatyyyyMMddHHmm,
    DVDateFormatyyyyMMdd,
    DVDateFormatMmonthDday,
    DVDateFormatMMMDD,
} DVDateFormat;

@interface NSDate (helper)

//根据dateForamt将当前NSDate对象转换成NSString表示形式的时间。
- (NSString*)dateStringWithFormat:(DVDateFormat)dateFormat;

//根据formatString 的格式返回对应的date字符串
- (NSString*)dateStringWithFormatString:(NSString*)formatString;

//返回某一个日期是周几
- (NSString*)weekday;

//判断两个日期是否在同一个自然日
- (BOOL)isSameDateWithAnother:(NSDate*)date1;

//把时间设定为上午10点，忽视时分秒，用于对比
- (NSDate*)dateByIgnoreHour;

//返回毫秒数
+ (NSNumber*)curTimeSince1970;

//返回多久时间之前
+(NSString *)timeBeforeInfoWithString:(NSTimeInterval)timeIntrval;

@end

// use DVDateFormatyyyyMMddHHmm
NSString *normalDateByTimeInterval(NSTimeInterval interval);


