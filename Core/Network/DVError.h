//
//  DVError.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <Foundation/Foundation.h>

//API返回的错误码
typedef enum {
    DVNetErrorNetFail = 901,
    DVNetErrorHasLikedOrUnliked = 100001,
    DVNetErrorNotFound = -9999,
} DVNetError;

//自定义的错误码
typedef enum {
    DVFuErrorUnknow = 0,
    DVFuErrorInvalidParameter = 10000, //发送API请求之前，参数错误
    DVFuErrorCannotDecode = 100001, //解码失败
    DVFuErrorCannotSerialized = 100003, //序列化成对应的数据结构失败，有可能是某个字段不合法
    DVFuErrorCannotRunAPI = 100004, //由于部分条件不符合，API请求不可发送
} DVFuError;

@interface DVError : NSError

@property (nonatomic, assign) int DVErrorCode;
@property (nonatomic, copy) NSString* DVErrorMsg;
@property (nonatomic, copy) NSString* byDomain;

@property (nonatomic,assign) int netErrorCode;//正常的errorCode

@property (nonatomic,assign) BOOL isTokenExpired;//token过期了，需要重新登录

@end

//以原有的error为基准，自定义error
extern DVError* makeCustomError(DVFuError type, NSString* domain, NSString* desc, NSError* originError);

//解析不合法的error
extern DVError* makeNetDecodeError(DVError* err);

//把一个通用的NSError转化成DVError
extern DVError* makeNetError(NSError* e);

//把一个map转化成对应的error
extern DVError* makeTransferNetError(NSDictionary* eDict);

//把一个msg转化成对应的error
extern DVError* makeNetErrorByMsg(NSString* msg,int code);
