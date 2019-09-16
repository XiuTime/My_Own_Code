//
//  UITableViewExtension.h
//  IBY
//
//  Created by pan Shiyu on 14/11/11.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (helper)

+ (instancetype)tableViewWithFrame:(CGRect)frame delegete:(id)delegate;
+ (instancetype)tableViewWithFrame:(CGRect)frame delegete:(id)delegate reuseClass:(Class)reuseClass reuseId:(NSString*)reuseId;
+ (instancetype)tableViewWithFrame:(CGRect)frame delegete:(id)delegate reuseNib:(UINib*)reuseNib reuseId:(NSString*)reuseId;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;

@end
