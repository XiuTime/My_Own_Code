//
//  DVNetwork.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DVError.h"
//#define KURL_API_Test @"https://makehave.com"
#define KURL_API_Test @" http://www.easy-mock.com/mock/59afae79e0dc6633419efab6/com.nebula.dvwriting"

typedef enum {
    DVNetModeOnline = 0,
    DVNetModeDevName = 1,
    DVNetModeDevNumber = 2
} DVNetMode;

NSString *netDesc(DVNetMode mode);

NSString* baseUrlByMode(DVNetMode mode);

@interface DVNetwork : NSObject

@property (nonatomic, assign) DVNetMode currentMode;

+ (instancetype)sharedNetwork;
- (AFHTTPSessionManager*)currentNetManager;
- (void)refreshHeader:(AFHTTPSessionManager*)netmanager;

+ (void)switchToMode:(DVNetMode)mode;


+ (void)get:(NSString*)url
     params:(NSDictionary*)params
     finish:(void (^)(NSDictionary* data, DVError* error))finish;

+ (void)post:(NSString*)url
      params:(NSDictionary*)params
      finish:(void (^)(NSDictionary* data, DVError* error))finish;

+ (void)get:(NSString*)url
     params:(NSDictionary*)params
isCacheValid:(BOOL)isCacheValid
     finish:(void (^)(NSDictionary* data, DVError* error))finish;

+ (void)post:(NSString*)url
      params:(NSDictionary*)params
isCacheValid:(BOOL)isCacheValid
      finish:(void (^)(NSDictionary* data, DVError* error))finish;

+ (void)delete:(NSString*)url
        params:(NSDictionary*)params
        finish:(void (^)(NSDictionary* data, DVError* error))finish;

+ (void)postByBaseUrl:(NSString*)baseUrl
               suffix:(NSString*)suffix
               params:(NSDictionary*)params
               finish:(void (^)(NSDictionary* data, NSError* error))finish;

+ (void) uploadImage:(UIImage *)image
                path:(NSString *)path
                name:(NSString *)name
            fileName:(NSString*)fileName
              params:(NSDictionary*)params
              finish:(void (^)(NSDictionary* data, DVError* error))finish;
+ (void)downloadFileWithURL:(NSString*)requestURLString
                 parameters:(NSDictionary *)parameters
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(DVError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress;



@end
