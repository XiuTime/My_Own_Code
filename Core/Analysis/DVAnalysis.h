//
//  ZWZAnalysis.h
//  gannicus
//
//  Created by psy on 13-12-10.
//  Copyright (c) 2013年 bbk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVAnalysis : NSObject

//TODO psy need 友盟ID

+ (void)startTracker;

//通用事件记录
+ (void)logEvent:(NSString*)eventName
          action:(NSString*)action
            desc:(NSString*)desc;

+ (void)logEvent:(NSString*)eventName
          action:(NSString*)action
            desc:(NSString*)desc
         options:(NSDictionary*)options;

//页面记录
+ (void)logPage:(NSString*)pageName withParameters:(NSDictionary*)parameters;
+ (void)logLeavingPage:(NSString*)pageName withParameters:(NSDictionary*)parameters;

+ (NSNumber*)lastEventTime;

@end
