//
//  DVAlertController.h
//  DVJiaoZheng
//
//  Created by pppsy on 2016/12/26.
//  Copyright © 2016年 nebula. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DVAlertBlock)(NSString* title,id data);

@interface DVAlert : UIAlertController

- (void)addBlock:(DVAlertBlock) blk forTitle:(NSString*)title withData:(id)data;
- (void)addCancelBlk;
- (void)addCancelBlk:(DVAlertBlock) blk;

- (void)showFrom:(UIViewController*)vc;

@end

