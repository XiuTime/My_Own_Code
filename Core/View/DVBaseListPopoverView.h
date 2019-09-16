//
//  DVBaseListPopoverView.h
//  DVOverseas
//
//  Created by pppsy on 16/8/27.
//  Copyright © 2016年 nebula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define MAX_LIST_HEIGHT ceilf([UIScreen mainScreen].bounds.size.height / 10 * 7)
//一个用于双层listview选择的基础组件

typedef void (^dismissBlock)();

@interface DVBaseListPopoverView : UIButton <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) dismissBlock dismissBlk;
@property (nonatomic, readonly) BOOL isShown;

@property (nonatomic, strong) UIView* contentView; //包含两个tableview
@property (nonatomic, strong) UIView* listContainerView; //包含两个tableview
@property (nonatomic, strong) UITableView* mainListView; //左边的list
@property (nonatomic, strong) UITableView* subListView; //右边的list

@property (nonatomic, strong) NSArray* mainDataArray; //左边list的data
@property (nonatomic, strong) NSArray* subDataArray; //右边list的data

@property (nonatomic, copy) void (^selectedBlock)(id selectedInfo);

+ (instancetype)popview;

- (void)showInView:(UIView*)superView withTopPadding:(CGFloat)top;
- (void)cancel;
- (void)hide;

@end

