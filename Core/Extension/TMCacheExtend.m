//
//  TMCacheExtend.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "TMCacheExtend.h"

#define kTemporaryCache @"com.dv.cache.temporary"
#define kPermanentCache @"com.dv.cache.permanent"

@implementation TMCache (Extension)

+ (instancetype)TemporaryCache
{
    return [[TMCache sharedCache] initWithName:kTemporaryCache];
}
+ (instancetype)PermanentCache
{
    return [[TMCache sharedCache] initWithName:kPermanentCache];
}

@end
