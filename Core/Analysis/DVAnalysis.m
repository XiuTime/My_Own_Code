//
//  ZWZAnalysis.m
//  gannicus
//
//  Created by psy on 13-12-10.
//  Copyright (c) 2013年 bbk. All rights reserved.
//

#import "DVAnalysis.h"

#import "DVNetwork.h"

#import "DVNetwork.h"

//#import "MSKAppService.h"

#import "MobClick.h"

#define kYouMengEventCommon @"0"
#define kYouMengEventPV @"1"

@implementation DVAnalysis

+ (void)startTracker
{
//    [MobClick startWithAppkey:@"56b1f0dce0f55a438a000b75" reportPolicy:BATCH channelId:@"Normal"];
    //    [Flurry setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //    [Flurry setCrashReportingEnabled:YES];
    //    [Flurry startSession:Flurry_ID];
    //    [Flurry logEvent:@"start" withParameters:@{@"time": [[NSDate date] description]}];
}

+ (void)logEvent:(NSString*)eventName
          action:(NSString*)action
            desc:(NSString*)desc
{

    [self logEvent:eventName action:action desc:desc options:nil];
}

+ (void)logEvent:(NSString*)eventName
          action:(NSString*)action
            desc:(NSString*)desc
         options:(NSDictionary*)options
{
//    NSMutableDictionary* uploadMap = [@{} mutableCopy];
//    [uploadMap safeSetValue:eventName forKey:@"typeinfo"];
//    [uploadMap safeSetValue:action forKey:@"eventAction"];
//    [uploadMap safeSetValue:desc forKey:@"eventDetail"];
//    uploadMap[@"type"] = @"event";
//    uploadMap[@"time"] = [NSDate curTimeSince1970];
//
//    if (options) {
//        [uploadMap addEntriesFromDictionary:options];
//    }
//
////    [MSKAppService uploadStatisticInfo:uploadMap];
//
//    [MobClick event:kYouMengEventCommon attributes:uploadMap];
//    [self saveCurrentEventTime];
}

+ (void)logPage:(NSString*)pageName withParameters:(NSDictionary*)parameters
{
//    NSMutableDictionary* uploadMap = [@{} mutableCopy];
//    if (parameters) {
//        [uploadMap addEntriesFromDictionary:parameters];
//    }
//
//    uploadMap[@"type"] = @"pv";
//    uploadMap[@"typeinfo"] = pageName;
//    uploadMap[@"time"] = [NSDate curTimeSince1970];
//
////    [MSKAppService uploadStatisticInfo:uploadMap];
//
//    [MobClick event:kYouMengEventPV attributes:uploadMap];
//
//    [MobClick beginLogPageView:pageName];
//
//    [self saveCurrentEventTime];
}

+ (void)logLeavingPage:(NSString*)pageName withParameters:(NSDictionary*)parameters
{
//    [MobClick endLogPageView:pageName];
//
//    [self saveCurrentEventTime];
}

#pragma mark -

#define kLastEventTime @"kLastEventTime"
+ (NSNumber*)lastEventTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLastEventTime];
}

+ (void)saveCurrentEventTime
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@([[NSDate date] timeIntervalSince1970]) forKey:kLastEventTime];
    [userDefaults synchronize];
}

@end
