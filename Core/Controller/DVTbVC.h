//
//  DVTableViewController.h
//  DVMobile
//
//  Created by pan Shiyu on 14/11/1.
//  Copyright (c) 2014年 mobile. All rights reserved.
//

#import "DVBaseVC.h"
#import "DVTableCell.h"
#import "DVCustomTableCells.h"
#import "MJRefresh.h"

/**
 cell会先判断 cellClassName，如果有，创建相应的cell
    如果木有，去判断 cellNibName，通过nib创建cell
 这两个货的identityfier都是对应的名称，so，如果你要register，请注意
 
 */

@class DVTableCell, DVTableItem;

@interface DVTbVC : DVBaseVC <UITableViewDataSource, UITableViewDelegate> {
    UITableView* _tableView;
    NSMutableArray* _items;
}
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, assign) UITableViewStyle tableStyle;
@property (nonatomic, strong) NSMutableArray* items; //不含section信息
@property (nonatomic, strong) NSMutableArray* sections; //section的title数组，数量可以小于items的组数

@property (nonatomic, assign) BOOL enableHeaderRefresh;
@property (nonatomic, assign) BOOL enableFooterRefresh;
- (void)loadMore;
- (void)refreshData;

- (id)initWithStyle:(UITableViewStyle)tableStyle;

@end

@interface UITableView (refresh)
- (void)endRefresh;
@end
