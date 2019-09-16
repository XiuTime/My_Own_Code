//
//  DVMutiSwitch.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/22.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DVSwitchHandler)(id sender);

@interface DVMutiSwitch : UIControl
@property (nonatomic,strong)UIImageView *backView;

- (void)addButtonWithTitle:(NSString*)title handler:(DVSwitchHandler)handler;
- (void)addButtonWithBtn:(UIButton*)btn handle:(DVSwitchHandler)handler;
- (void)setSelectedAtIndex:(int)aIndex;

@end
