//
//  DVHelper.h
//  MakeHave
//
//  Created by pppsy on 15/11/25.
//  Copyright © 2015年 makehave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVHelper : NSObject
/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;

@end
