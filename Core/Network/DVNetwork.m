 //
//  DVNetwork.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "AFNetworking.h"
#import "DVNetwork.h"
#import "TMCacheExtend.h"

//#import "DVAppCenter.h"

@interface DVNetwork ()
@property (nonatomic, strong) NSMutableDictionary* managerDict;

@end

NSString* baseUrlByMode(DVNetMode mode)
{
    NSArray* urls = @[
        @"http://www.mofeiculture.com/api/",
        @"http://starcloudtec.iok.la:9080/api-1.0/",
        @"http://192.168.31.100:9080/api-1.0/",
    ];
    return urls[mode];
}

NSString *netDesc(DVNetMode mode) {
    NSArray* deslist = @[
                      @"乐写阿里云",
                      @"星云海内部域名",
                      @"星云海内部IP",
                      ];
    if (mode >= 3) {
        return @"";
    }
    return deslist[mode];
}

NSString* makeFingerprint(NSString* baseUrl, NSString* suffixUrl, NSDictionary* params)
{
    NSString* fprint = [NSString stringWithFormat:@"%@%@%@", baseUrl, suffixUrl, params];
    return fprint;
}

AFHTTPSessionManager* makeNetManager(NSString* baseUrl)
{
    AFHTTPSessionManager* netmanager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    //这行一定要注掉，会使得https不可用
    //    [netmanager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    if (!netmanager.requestSerializer) {
        netmanager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    [netmanager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [netmanager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];// multipart/form-data
    
    AFJSONResponseSerializer* response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    response.removesKeysWithNullValues = YES;
    netmanager.responseSerializer = response;
    
    return netmanager;
}

AFHTTPSessionManager* makePostNetManager(NSString* baseUrl)
{
    AFHTTPSessionManager* netmanager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    if (!netmanager.requestSerializer) {
        netmanager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    [netmanager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [netmanager.requestSerializer setValue:@"mutipart/form-data; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONResponseSerializer* response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    response.removesKeysWithNullValues = YES;
    netmanager.responseSerializer = response;
    
    return netmanager;
}

typedef void (^DVNetProcessBlk)(NSDictionary* data, DVError* error);

void processNetResult(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject, BOOL isCacheValid, NSString* fprint, DVNetProcessBlk finish)
{ 
    
    //    [iConsole log:@"--------- result ----------"];
    //    [iConsole log:@"%@", responseObject];
    //    [iConsole log:@"--------- result end----------"];
    
    if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"success"] intValue] == 1 && responseObject[@"data"] && !responseObject[@"error"]) {
        
        NSDictionary* result = responseObject[@"data"];
        if (isCacheValid && result && fprint) {
            runOnBackgroundQueue(^{
                [[TMCache TemporaryCache] setObject:responseObject forKey:fprint];
            });
        }
        
        finish(result, nil);
    } else if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"success"] intValue] == 1) {
        finish(responseObject, nil);
    }else if ([responseObject isKindOfClass:[NSDictionary class]] ){
        NSDictionary *errorDic = responseObject[@"error"];
        DVError* error = makeNetErrorByMsg(errorDic[@"msg"],[errorDic[@"code"] intValue]);
        finish(nil, error);
    }else{
        DVError* netErr = nil;
        DVError* error = makeNetDecodeError(netErr);
        finish(nil, error);
    }
}


@implementation DVNetwork

#pragma mark -

+ (void)get:(NSString*)url params:(NSDictionary*)params finish:(void (^)(NSDictionary* data, DVError* error))finish
{
    [DVNetwork get:url params:params isCacheValid:NO finish:finish];
}

+ (void)post:(NSString*)url params:(NSDictionary*)params finish:(void (^)(NSDictionary* data, DVError* error))finish
{
    [DVNetwork post:url params:params isCacheValid:NO finish:finish];
}

+ (void)get:(NSString*)url
          params:(NSDictionary*)params
    isCacheValid:(BOOL)isCacheValid
          finish:(void (^)(NSDictionary* data, DVError* error))finish
{
    NSCAssert(finish, @"finish block 不能为空");

    NSString* fprint = nil;
    if (isCacheValid) {
        NSString* baseUrl = baseUrlByMode([DVNetwork sharedNetwork].currentMode);
        fprint = makeFingerprint(baseUrl, url, params);
        NSDictionary* data = [[TMCache TemporaryCache] objectForKey:fprint];
        NSDictionary* result = data[@"data"];
        if (data && result) {
            finish(result, nil);
            return;
        }
    }

//    AFHTTPSessionManager* curManager = [[DVNetwork sharedNetwork] currentNetManager];
    
    NSString* baseUrl = baseUrlByMode([DVNetwork sharedNetwork].currentMode);
    AFHTTPSessionManager* curManager =makeNetManager(baseUrl);
    [[DVNetwork sharedNetwork] refreshHeader:curManager];

//    [iConsole log:@"---------begin----------"];
//    [iConsole log:@"url %@%@", baseUrlByMode([DVNetwork sharedNetwork].currentMode), url];
//    [iConsole log:@"params %@", params];
//    [iConsole log:@"header %@", [DVAppCenter sharedAppCenter].paramsMapForHeader];
//    [iConsole log:@"---------end----------"];
    
    [curManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        processNetResult(task, responseObject, isCacheValid, fprint, finish);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finish(nil, makeNetError(error));
    }];
}

+ (void)post:(NSString*)url
      params:(NSDictionary*)params
isCacheValid:(BOOL)isCacheValid
      finish:(void (^)(NSDictionary* data, DVError* error))finish
{
    NSCAssert(finish, @"finish block 不能为空");

    NSString* fprint = nil;
    if (isCacheValid) {
        NSString* baseUrl = baseUrlByMode([DVNetwork sharedNetwork].currentMode);
        fprint = makeFingerprint(baseUrl, url, params);
        NSDictionary* data = [[TMCache TemporaryCache] objectForKey:fprint];
        if (data && data) {
            DVLog(@"-----------use cache");
            finish(data[@"data"], nil);
            return;
        }
    }
    
    NSString* baseUrl = baseUrlByMode([DVNetwork sharedNetwork].currentMode);
    AFHTTPSessionManager* curManager =makePostNetManager(baseUrl);
    [[DVNetwork sharedNetwork] refreshHeader:curManager];
    
//    curManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [curManager.requestSerializer setValue:@"Token token=fGqslGyAP+MY3DfPexXfeBd2bVAIl7UzUTbRd1iZJ6colxKzbVSqFinwVogL18oc//Hj5K9wqMDgeXpzsB7ndw==" forHTTPHeaderField:@"Authorization"];
    
    [iConsole log:@"---------begin----------"];
    [iConsole log:@"url %@%@", baseUrlByMode([DVNetwork sharedNetwork].currentMode), url];
    [iConsole log:@"params %@", params];
//    [iConsole log:@"header %@", [DVAppCenter sharedAppCenter].paramsMapForHeader];
    [iConsole log:@"---------end----------"];
    
    [curManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        formData appendPartWithFormData:<#(nonnull NSData *)#> name:<#(nonnull NSString *)#>
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        processNetResult(task, responseObject, isCacheValid, fprint, finish);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finish(nil, makeNetError(error));
    }];
    
}

+ (void)postByBaseUrl:(NSString*)baseUrl
               suffix:(NSString*)suffix
               params:(NSDictionary*)params
               finish:(void (^)(NSDictionary* data, NSError* error))finish
{
    AFHTTPSessionManager* manager = makeNetManager(baseUrl);
    [[DVNetwork sharedNetwork] refreshHeader:manager];

    [manager POST:suffix parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        processNetResult(task, responseObject, NO, nil, finish);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finish(nil, makeNetError(error));
    }];
    
}

+ (void) delete:(NSString*)url
         params:(NSDictionary*)params
         finish:(void (^)(NSDictionary* data, DVError* error))finish
{
    NSCAssert(finish, @"finish block 不能为空");

    AFHTTPSessionManager* curManager = [[DVNetwork sharedNetwork] currentNetManager];
    [[DVNetwork sharedNetwork] refreshHeader:curManager];

    [curManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        processNetResult(task, responseObject, NO, nil, finish);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finish(nil, makeNetError(error));
    }];
    
}


+ (void)downloadFileWithURL:(NSString*)requestURLString
                 parameters:(NSDictionary *)parameters
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(DVError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress

{

    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURLString parameters:parameters error:nil];
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savedPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            failure(makeNetError(error));
        }else{
            success(response,filePath);
        }
    }];
    [task resume];
    
}


+ (void)uploadImage:(UIImage*)image
               path:(NSString*)path
               name:(NSString*)name
           fileName:(NSString*)fileName
             params:(NSDictionary*)params
             finish:(void (^)(NSDictionary* data, DVError* error))finish
{
    NSCAssert(finish, @"finish block 不能为空");
    
        //大于300k都不可以
    if (image) {
        NSData* data = UIImageJPEGRepresentation(image, 0.3);
        if ((float)data.length / 1024 > 300) {
            data = UIImageJPEGRepresentation(image, 1024 * 300.0 / (float)data.length);
        }
    }
    AFHTTPSessionManager* curManager = [[DVNetwork sharedNetwork] currentNetManager];
    [[DVNetwork sharedNetwork] refreshHeader:curManager];
    NSString* baseUrl = baseUrlByMode([DVNetwork sharedNetwork].currentMode);
    
    NSMutableURLRequest* request = [curManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:path relativeToURL:[NSURL URLWithString:baseUrl]] absoluteString] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
             [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:name fileName:[fileName append:@".jpg"] mimeType:@"image/jpeg"];
        }
    } error:nil];
    NSURLSessionDataTask *task = [curManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if(error){
            finish(nil,makeNetError(error));
        }else{
            finish(responseObject,nil);
        }
    }];
    [task resume];

//TODO psy 上传图片的方法
    
//    //大于300k都不可以
//    NSData* data = UIImageJPEGRepresentation(image, 1.0);
//    if ((float)data.length / 1024 > 300) {
//        data = UIImageJPEGRepresentation(image, 1024 * 300.0 / (float)data.length);
//    }
//
//    AFHTTPSessionManager* curManager = [[DVNetwork sharedNetwork] currentNetManager];
//    [[DVNetwork sharedNetwork] refreshHeader:curManager];
//
//    NSString* baseUrl = baseUrlByMode([DVNetwork sharedNetwork].currentMode);
//
//    NSMutableURLRequest* request = [curManager.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:[[NSURL URLWithString:path relativeToURL:[NSURL URLWithString:baseUrl]] absoluteString] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
//    }
//                                                                                          error:nil];
//
//    AFHTTPRequestOperation* operation = [curManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation* operation, id responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"status"] intValue] == 1 && !responseObject[@"error"]) {
//            NSDictionary* result = responseObject[@"data"];
//            finish(result, nil);
//        }
//        else {
//            DVError* netErr = nil;
//            if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject[@"error"]) {
//                netErr = makeTransferNetError(responseObject[@"error"]);
//            }
//            DVError* error = makeNetDecodeError(netErr);
//            finish(nil, error);
//        }
//    }
//        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
//            finish(nil, makeNetError(error));
//        }];
//    [operation start];
}


- (void)refreshHeader:(AFHTTPSessionManager*)netmanager
{
    if (!netmanager.requestSerializer) {
        netmanager.requestSerializer = [AFJSONRequestSerializer serializer];
    }


    [[DVAppCenter sharedAppCenter].paramsMapForHeader bk_each:^(id key, NSString* value) {
        if ([value isKindOfClass:[NSString class]] && value.length > 0) {
            [netmanager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }];

}

#pragma mark -

+ (instancetype)sharedNetwork
{
    static DVNetwork* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _currentMode = DVNetModeOnline;
//       _currentMode = DVNetModeDevName;
    }
    return self;
}

+ (void)switchToMode:(DVNetMode)mode
{
    [DVNetwork sharedNetwork].currentMode = mode;
}

- (NSMutableDictionary*)managerDict
{
    if (!_managerDict) {
        _managerDict = [[NSMutableDictionary alloc] init];
    }
    return _managerDict;
}

- (AFHTTPSessionManager*)currentNetManager
{
    NSString* baseUrl = baseUrlByMode(_currentMode);

    AFHTTPSessionManager* manager = self.managerDict[baseUrl];
    if (!manager) {
        manager = makeNetManager(baseUrl);
        self.managerDict[baseUrl] = manager;
    }
    return manager;
}

@end
