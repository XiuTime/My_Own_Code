//
//  DVBaseListPopoverView.m
//  DVOverseas
//
//  Created by pppsy on 16/8/27.
//  Copyright © 2016年 nebula. All rights reserved.
//

#import "DVBaseListPopoverView.h"


@implementation DVBaseListPopoverView

#pragma mark - 基础方法

- (void)cancel
{
    if (_selectedBlock) {
        _selectedBlock(nil);
    }
    
    
    [self removeFromSuperview];
}

/**
 出现动画是
 content下拉出现
 背景色逐渐透明黑
 */
- (void)showInView:(UIView*)superView withTopPadding:(CGFloat)top
{
    _isShown = YES;
    
    CGFloat aimHeight = self.contentView.height;
    self.contentView.height = 0;
    self.backgroundColor = [UIColor clearColor];
    
    self.top = top;
    
    [superView addSubview:self];
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.contentView.height =aimHeight;
                         self.backgroundColor = HEXACOLOR(0, 0.7);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)hide
{
    _isShown = NO;
    if (_dismissBlk) {
        _dismissBlk();
    }
    [self removeFromSuperview];
}


- (void)dealloc
{
    _mainListView.delegate = nil;
    _mainListView.dataSource = nil;
    _subListView.delegate = nil;
    _subListView.dataSource = nil;
}

+ (instancetype)popview{
    return [[self alloc] init];
}

- (id)init
{
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        [self initUI];
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = HEXACOLOR(0, 0.7);
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAX_LIST_HEIGHT)];
    _contentView.clipsToBounds = YES;
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    
    _listContainerView = [[UIView alloc] init];
    _listContainerView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_listContainerView];
    
    _subListView = [UITableView tableViewWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, _listContainerView.height) delegete:self];
    _subListView.showsVerticalScrollIndicator = NO;
    _subListView.showsHorizontalScrollIndicator = NO;
    [self.listContainerView addSubview:_subListView];
    
    _mainListView = [UITableView tableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, _listContainerView.height) delegete:self];
    _mainListView.showsVerticalScrollIndicator = NO;
    _mainListView.showsHorizontalScrollIndicator = NO;
    [self.listContainerView addSubview:_mainListView];
    
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(MAX_LIST_HEIGHT));
    }];
    
    [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentView);
    }];
    
    [_mainListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_listContainerView);
    }];
    
    [_subListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_listContainerView);
    }];
    _subListView.hidden = YES;
}

#pragma mark -

#pragma mark - UITableViewDataSource and UITableViewDelegate, 需要重写的部分

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mainListView) {
        return _mainDataArray.count;
    }
    else {
        return _subDataArray.count;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    //初始化cell，需要重写
    return nil;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 44;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    //选中cell
}

@end

