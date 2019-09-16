//
//  DVAlertController.m
//  DVJiaoZheng
//
//  Created by pppsy on 2016/12/26.
//  Copyright © 2016年 nebula. All rights reserved.
//

#import "DVAlert.h"

@interface DVAlert ()

@end

@implementation DVAlert

- (void)addBlock:(DVAlertBlock) blk forTitle:(NSString*)title withData:(id)data {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (blk) {
            blk(title,data);
        }
    }];
    [self addAction:action];
}

- (void)addCancelBlk {
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [self addAction:action];
}

- (void)addCancelBlk:(DVAlertBlock) blk {
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (blk) {
            blk(nil,nil);
        }
    }];
    [self addAction:action];
}

- (void)showFrom:(UIViewController*)vc{
    [vc presentViewController:self animated:YES completion:nil];
}
- (BOOL)shouldAutorotate {
    [super shouldAutorotate];
    return NO;
}
@end
