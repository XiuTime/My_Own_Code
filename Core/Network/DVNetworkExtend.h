//
//  DVNetworkExtend.h
//  MakeHave
//  增加图片上传功能.
//  Created by pan Shiyu on 15/7/23.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVNetwork.h"

@interface DVNetwork (Extension)

+ (void)uploadImage:(NSString*)url//传到这个URL上,应该是POST,但也可能是别的方法.
              image:(UIImage*)image//Image对象.
                key:(NSString*)uploadkey
            finish:(void (^)(BOOL isSuccess, DVError* error))finish;

@end
