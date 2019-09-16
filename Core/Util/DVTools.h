//
//  DVTools.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "iConsole.h"
#import <Foundation/Foundation.h>
@class DVError;

@interface DVTools : NSObject


@end

UIImageView* makeSepline();
UIImageView* makeSepline2(CGRect frame);
UIImageView* makeSepline3(CGRect frame,UIColor *color);
UIImageView * makeTopLine();

UIView* makeLine(CGFloat width);
UIImageView* makeImgView(CGRect frame, NSString* picName);

UIImage* cacheImageFromUrl(NSString* webPath);

NSDictionary* geoDict(NSString* geoPath);

//error
void alertError(NSError* error);
void alertCommonError(NSError* error, NSString* defaultMessage);
void alertPoolnetError();
void alertPushSimplely(NSString* info);

#pragma mark - block tools

void runOnMainQueue(void (^block)(void));
void runOnBackgroundQueue(void (^block)(void));
void runBlockAfterDelay(float delaySeconds, void (^block)(void));
void runBlockWithRetryTimes(NSUInteger retryTimes, CGFloat delayTime, BOOL (^block)());

NSString* intToString(int num);
NSString* int64ToString(int64_t num);

NSString* globalString(NSString* key);

NSString* getWeekDayFordate(NSTimeInterval data);

NSString* getCurrentWeekDay();

NSString * getCurrentTime();
NSString * getCurrentData();
float folderSizeAtPath(NSString *path);
float fileSizeAtPath(NSString *path);

NSString * dateToString(NSDate * date);
