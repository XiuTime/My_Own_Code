//
//  NSDateExtend.m
//  IBY
//
//  Created by panshiyu on 15/1/12.
//  Copyright (c) 2015年 com.makehave. All rights reserved.
//

#import "NSDateExtend.h"

@implementation NSDate (helper)

+ (NSNumber*)curTimeSince1970
{
    NSTimeInterval time = ceil([[NSDate date] timeIntervalSince1970] * 1000);
    return @(time);
}

- (NSString*)dateStringWithFormat:(DVDateFormat)dateFormat
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    switch (dateFormat) {
    case DVDateFormatyyyyMMddHHmm:
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        break;
    case DVDateFormatyyyyMMdd:
        [formatter setDateFormat:@"yyyy.MM.dd"];
        break;
    case DVDateFormatMmonthDday:
        [formatter setDateFormat:@"M 月 d 日"];
        break;
    case DVDateFormatMMMDD: {
        [formatter setDateFormat:@"MMM. dd"];
        NSLocale* usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [formatter setLocale:usLocale];
    } break;
    default:
        [formatter setDateFormat:@"MM-dd HH:mm"];
        break;
    }
    return [formatter stringFromDate:self];
}

- (NSString*)dateStringWithFormatString:(NSString*)formatString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatString;
    formatter.timeZone = [NSTimeZone defaultTimeZone];
    return [formatter stringFromDate:self];
}

//返回某一个日期是周几
- (NSString*)weekday
{
    NSCalendar* cal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [cal setFirstWeekday:1];
    NSDateComponents* comps = [cal components:NSCalendarUnitWeekday fromDate:self];
    NSArray* weekdayString = [NSArray arrayWithObjects:@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    return [weekdayString objectAtIndex:(comps.weekday - cal.firstWeekday)];
}

//判断两个日期是否在同一个自然日
- (BOOL)isSameDateWithAnother:(NSDate*)date1
{
    if (!date1) {
        return NO;
    }
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comps1 = [cal components:(NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay)
                                      fromDate:date1];
    NSDateComponents* comps0 = [cal components:(NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay)
                                      fromDate:self];

    BOOL sameDay = ([comps1 day] == [comps0 day]
        && [comps1 month] == [comps0 month]
        && [comps1 year] == [comps0 year]);
    return sameDay;
}

- (NSDate*)dateByIgnoreHour
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setHour:10];
    [components setMinute:0];
    [components setMinute:0];
    NSDate* day10am = [calendar dateFromComponents:components];
    return day10am;
}

+(NSString *)timeBeforeInfoWithString:(NSTimeInterval)timeIntrval{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeInterval nowTimeinterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeInt = nowTimeinterval - timeIntrval;
    int year = timeInt / (3600 * 24 * 30 *12);
    int month = timeInt / (3600 * 24 * 30);
    int day = timeInt / (3600 * 24);
    int hour = timeInt / 3600;
    int minute = timeInt / 60;
    //int second = timeInt;
    if (year > 0) {
        return [NSString stringWithFormat:@"%d年前",year];
    }else if(month > 0){
        return [NSString stringWithFormat:@"%d个月前",month];
    }else if(day > 0){
        return [NSString stringWithFormat:@"%d天前",day];
    }else if(hour > 0){
        return [NSString stringWithFormat:@"%d小时前",hour];
    }else if(minute > 0){
        return [NSString stringWithFormat:@"%d分前",minute];
    }else{
        return [NSString stringWithFormat:@"刚刚"];
    }
}

@end

NSString *normalDateByTimeInterval(NSTimeInterval interval) {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *str = [date dateStringWithFormatString:@"yyyy-MM-dd HH:mm"];
    return str;
}



