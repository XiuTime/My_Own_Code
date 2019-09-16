//
//  DVBaseDomain.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "NSDateExtend.h"

@interface DVBaseDomain : MTLModel<MTLJSONSerializing>

+ (instancetype)mtlObjectWithKeyValues:(NSDictionary*)keyValues;
+ (NSArray*)mtlObjectsWithKeyValueslist:(NSArray*)keyValueslist;

- (NSDictionary*)mtlJsonDict;

@end
