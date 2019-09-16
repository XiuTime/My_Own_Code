//
//  DVNetworkExtend.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/23.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVNetwork.h"
#import "DVNetworkExtend.h"
#import "AFNetworking.h"
@implementation DVNetwork (Extension)

+ (void)uploadImage:(NSString*)url
              image:(UIImage*)image
                key:(NSString*)uploadkey//用于唯一标识这个文件的一个字符串.
             finish:(void (^)(BOOL isSuccess, DVError* error))finish

{/*TODO:补全并测试.
    NSData* image_data = UIImagePNGRepresentation(image);//获取NSData.
    
    QNUploadManager *pQNmanager=[[QNUploadManager alloc] init];//调用七牛API.
    
    
    NSString *pToken=@"这里改成调用服务端API"//TODO:从服务端获取.
    
    [pQNmanager putData:image_data
                    key:uploadkey
                  token:pToken
               complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                   NSLog(info);
                   NSLog(key);
                   NSLog(resp);
                   
                   //TODO:根据回复的不同,确定调用哪个回调函数.现在还没加入,需要测试下.
               }
                 option:nil];
    
//    NSDictionary* pDict=[NSDictionary dictionaryWithObjectsAndKeys:image_data,@"ImageData", nil];
//    DVNetwork post:url  params:pDict finish:^(NSDictionary *data, DVError *error) {
  
    
    //发送请求.
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    
    
    
        #define ServerUploadURL @"54.223.206.25:3000/api/upload"
    
    
    
    
        [manager POST:ServerUploadURL
                                      parameters:<#(id)#>//这个一会参考API来填写
                                      constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                          id<AFMultipartFormData> data[]
                                      }
                                      success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#>
              failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>];
    
  
  */
        
    
    
    
    
}

@end
