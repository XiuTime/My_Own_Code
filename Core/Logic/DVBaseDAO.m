//
//  DVBaseDAO.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVBaseDAO.h"

@class DVCacheUnit;

@implementation DVBaseDAO

#pragma mark - TemporaryCache
- (void)setCache:(id)cache forKey:(NSString*)key expiredTime:(NSTimeInterval)time
{
    DVCacheUnit* unit = [DVCacheUnit unitWithData:cache expiredTime:time];
    [[TMCache TemporaryCache] setObject:unit forKey:key];
}

- (void)setCache:(id)cache forKey:(NSString*)key
{
    DVCacheUnit* unit = [DVCacheUnit unitWithData:cache expiredTime:-1];
    [[TMCache TemporaryCache] setObject:unit forKey:key];
}

- (id)cacheByKey:(NSString*)key
{
    DVCacheUnit* unit = [[TMCache TemporaryCache] objectForKey:key];
    if (unit.expiredDate && [unit.expiredDate compare:[NSDate date]] == NSOrderedAscending) {
        return unit.data;
    }
    return nil;
}

- (id)cacheIgnoreExpireByKey:(NSString*)key
{
    DVCacheUnit* unit = [[TMCache TemporaryCache] objectForKey:key];
    if (unit) {
        return unit.data;
    }
    return nil;
}

- (void)removeCacheForkey:(NSString*)key
{
    [[TMCache TemporaryCache] removeObjectForKey:key];
}

#pragma mark - PermanentCache

- (void)setPermanentCache:(id)cache forKey:(NSString*)key expiredTime:(NSTimeInterval)time
{
    DVCacheUnit* unit = [DVCacheUnit unitWithData:cache expiredTime:time];
    [[TMCache PermanentCache] setObject:unit forKey:key];
}
- (void)setPermanentCache:(id)cache forKey:(NSString*)key
{
    DVCacheUnit* unit = [DVCacheUnit unitWithData:cache expiredTime:-1];
    [[TMCache PermanentCache] setObject:unit forKey:key];
}
- (id)permanentCacheByKey:(NSString*)key
{
    DVCacheUnit* unit = [[TMCache PermanentCache] objectForKey:key];
    if (unit.expiredDate && [unit.expiredDate compare:[NSDate date]] == NSOrderedAscending) {
        return unit.data;
    }
    return nil;
}
- (id)permanentCacheIgnoreExpireByKey:(NSString*)key
{
    DVCacheUnit* unit = [[TMCache PermanentCache] objectForKey:key];
    if (unit) {
        return unit.data;
    }
    return nil;
}
- (void)removePermanentCacheForkey:(NSString*)key
{
    [[TMCache PermanentCache] removeObjectForKey:key];
}

@end

@implementation DVCacheUnit

+ (instancetype)unitWithData:(id)data expiredTime:(NSTimeInterval)time
{
    DVCacheUnit* unit = [[DVCacheUnit alloc] init];
    unit.data = data;
    if (time > 0) {
        unit.expiredDate = [NSDate dateWithTimeIntervalSinceNow:time];
    }
    return unit;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:_data forKey:@"cacheData"];
    [aCoder encodeObject:_expiredDate forKey:@"expiredTimed"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if (self = [super init]) {

        _data = [aDecoder decodeObjectForKey:@"cacheData"];
        _expiredDate = [aDecoder decodeObjectForKey:@"expiredTimed"];
    }
    return self;
}

@end
