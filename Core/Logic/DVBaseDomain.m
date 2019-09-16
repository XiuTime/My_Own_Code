//
//  DVBaseDomain.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVBaseDomain.h"

@implementation DVBaseDomain

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return nil;
}

+ (instancetype)mtlObjectWithKeyValues:(NSDictionary*)keyValues
{
    NSError* error;
    id object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:keyValues error:&error];
    if (error) {
        DVLog(@"convert class %@ error ,msg - %@", [[self class] description], [error description]);
    }
    return object;
}

+ (NSArray*)mtlObjectsWithKeyValueslist:(NSArray*)keyValueslist
{
    NSError* error;
    NSArray* list = [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:keyValueslist error:&error];
    if (error) {
        DVLog(@"convert class list %@ error ,msg - %@", [[self class] description], [error description]);
    }
    
    return list;
}

- (NSDictionary*)mtlJsonDict
{
    NSError* error;
    id object = [MTLJSONAdapter JSONDictionaryFromModel:self error:&error];
    if (error) {
        DVLog(@"convert class %@ error ,msg - %@", [[self class] description], [error description]);
    }
    return object;
}

@end
