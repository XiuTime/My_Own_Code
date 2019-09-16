//
//  TMCacheExtend.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "TMCache.h"

#import <Foundation/Foundation.h>
#import "TMCache.h"

@interface TMCache (Extension)

+ (instancetype)TemporaryCache;
+ (instancetype)PermanentCache;

@end
