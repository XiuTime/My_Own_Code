//
//  DVBaseService.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVError.h"
#import "DVNetwork.h"
#import <Foundation/Foundation.h>


#define Limit_PER_PAGE 30

@interface DVBaseService : NSObject

- (void)setupService;

//分页相关
@property (nonatomic, assign) int limit;
@property (nonatomic, assign) int pageIndex; //页码。以后会用offset(偏移量)来替代
@property (nonatomic, assign) int total;
@property (nonatomic, assign) BOOL hasMore;

- (void)resetDataList;

- (void)dv_uploadImage:(UIImage *)image
                   name:(NSString*)name
                   path:(NSString*)path
                 params:(NSDictionary*)params
                 finish:(void (^)(NSDictionary* data, DVError* error))finish;


@end

//TODO psy 将来可以移除
void dv_getHotline(NSString *preSuffix,UIViewController *fromVC);


