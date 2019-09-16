//
//  BYLinearComponent.h
//  IBY
//
//  Created by panShiyu on 14/12/5.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVLinearItem : NSObject
@property (nonatomic, strong) UIView* view;
@property (nonatomic, assign) float paddingTop;
@property (nonatomic, assign) float paddingBottom;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithView:(UIView*)aView paddingTop:(float)top paddingBottom:(float)bottom;

@end
