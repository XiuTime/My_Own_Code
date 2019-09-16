//
//  DVBaseService.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVBaseService.h"

@implementation DVBaseService

- (id)init{
    self = [super init];
    if (self) {
        [self setupService];
        
        [self resetDataList];
    }
    return self;
}

- (void)setupService {
    
}


- (void)setupPageInfo {
    _limit = Limit_PER_PAGE;
    _pageIndex = 1;
    _total = 0;
    _hasMore = YES;
}

- (void)resetDataList {
    _pageIndex = 1;
    _total = 0;
    _limit = Limit_PER_PAGE;
    _hasMore = YES;
}


- (void)dv_uploadImage:(UIImage *)image
                   name:(NSString*)name
                path:(NSString*)path
              params:(NSDictionary*)params
              finish:(void (^)(NSDictionary* data, DVError* error))finish
{
    AFHTTPSessionManager* curManager = [[DVNetwork sharedNetwork] currentNetManager];
    [[DVNetwork sharedNetwork] refreshHeader:curManager];
    NSString* baseUrl = baseUrlByMode([DVNetwork sharedNetwork].currentMode);
    
    NSMutableURLRequest* request = [curManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:path relativeToURL:[NSURL URLWithString:baseUrl]] absoluteString] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:name fileName:@"image[]" mimeType:@"image/png"];
    } error:nil];
    NSURLSessionDataTask *task = [curManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"status"] intValue] == 1) {
            
            NSDictionary* result = responseObject[@"data"];
            finish(result, nil);
        }else{
            finish(nil,(DVError *)error);
        }
    }];
    [task resume];
}


@end

void dv_getHotline(NSString *preSuffix,UIViewController *fromVC) {
    NSString *url = [NSString stringWithFormat:@"/api/v1/%@/hotline",preSuffix];
    [DVNetwork get:url params:nil isCacheValid:YES finish:^(NSDictionary *data, DVError *error) {
        if (data) {
            NSString *phoneNum = data[@"hotline"];
            UIActionSheet* sheet = [UIActionSheet bk_actionSheetWithTitle:@"是否拨打客服热线？"];
            [sheet bk_addButtonWithTitle:phoneNum handler:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]]];
            }];
            [sheet bk_addButtonWithTitle:@"取消" handler:^{
                
            }];
            [sheet showInView:fromVC.view];
        }else{
            //什么也不显示
        }
    }];
}
