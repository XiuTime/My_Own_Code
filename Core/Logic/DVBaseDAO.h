//
//  DVBaseDAO.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMCacheExtend.h"

@interface DVBaseDAO : NSObject

#define kTemporaryCache @"com.dv.cache.temporary"
#define kPermanentCache @"com.dv.cache.permanentCache"

//temporary cache
- (void)setCache:(id)cache forKey:(NSString*)key expiredTime:(NSTimeInterval)time;
- (void)setCache:(id)cache forKey:(NSString*)key;
- (id)cacheByKey:(NSString*)key;
- (id)cacheIgnoreExpireByKey:(NSString*)key;
- (void)removeCacheForkey:(NSString*)key;

//permanentCache
- (void)setPermanentCache:(id)cache forKey:(NSString*)key expiredTime:(NSTimeInterval)time;
- (void)setPermanentCache:(id)cache forKey:(NSString*)key;
- (id)permanentCacheByKey:(NSString*)key;
- (id)permanentCacheIgnoreExpireByKey:(NSString*)key;
- (void)removePermanentCacheForkey:(NSString*)key;

@end

@interface DVCacheUnit : NSObject <NSCoding>
@property (nonatomic,strong)NSDate *expiredDate;
@property (nonatomic,strong)id data;
+(instancetype)unitWithData:(id)data expiredTime:(NSTimeInterval)time;
@end
