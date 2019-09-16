//
//  DVError.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVError.h"

@implementation DVError

- (int)netErrorCode {
    if (self.userInfo[@"status"]) {
        return [self.userInfo[@"status"] intValue];
    }
    return DVNetErrorNotFound;
}

- (BOOL)isTokenExpired {
    return (self.code == 701);
}

@end

DVError* makeCustomError(DVFuError type, NSString* domain, NSString* desc, NSError* originError)
{
    DVError* err = [[DVError alloc] init];
    ;
    if (originError) {
        err = [DVError errorWithDomain:originError.domain code:originError.code userInfo:originError.userInfo];
    }
    err.DVErrorCode = type;
    err.byDomain = domain;
    err.DVErrorMsg = desc;
    return err;
}

DVError* makeNetDecodeError(DVError* err)
{
    return makeCustomError(DVFuErrorCannotDecode, @"com.lexie.network.decode", @"decode error", err);
}

DVError* makeTransferNetError(NSDictionary* eDict)
{
    return [DVError errorWithDomain:@"com.lexie.network.decode" code:[eDict[@"code"] integerValue] userInfo:eDict];
}

DVError* makeNetError(NSError* e)
{
    return [DVError errorWithDomain:e.domain code:e.code userInfo:e.userInfo];
}

extern DVError* makeNetErrorByMsg(NSString* msg,int code) {
    NSString *realMsg = msg? msg : @"";
    return [DVError errorWithDomain:@"com.lexie.network.normal" code:code userInfo:@{@"msg":realMsg}];
}
