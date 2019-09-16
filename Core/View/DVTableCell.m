//
//  DVTableCell.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/22.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVTableCell.h"
#import "Masonry.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DVTableItem

+ (id)itemWithCellClassName:(NSString*)cellClassName
{
    DVTableItem* item = [[self alloc] init];
    item.cellClassName = cellClassName;
    return item;
}

+ (id)itemWithCellNibName:(NSString*)cellNibName
{
    DVTableItem* item = [[self alloc] init];
    item.cellNibName = cellNibName;
    return item;
}

- (id)init
{
    self = [super init];
    if (self) {
        _cellHeight = 44;
        _cacheDict = [NSMutableDictionary dictionary];
    }
    return self;
}

@end

@implementation DVTableCell

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[self class] description]];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];

        self.showBottomLine = NO;
        self.showRightArrow = NO;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];

    self.showBottomLine = NO;
    self.showRightArrow = NO;
}

- (void)setShowRightArrow:(BOOL)showRightArrow
{
    if (showRightArrow) {
        [self.contentView bringSubviewToFront:self.arrowView];
        _arrowView.hidden = NO;
    }
    else {
        _arrowView.hidden = YES;
    }
    [self setNeedsDisplay];
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    if (showBottomLine) {
        [self.contentView bringSubviewToFront:self.bottomLine];
        _bottomLine.hidden = NO;
    }
    else {
        _bottomLine.hidden = YES;
    }
    [self setNeedsDisplay];
}

- (UIImageView*)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = makeSepline();
        [self.contentView addSubview:_bottomLine];

        [_bottomLine mas_makeConstraints:^(MASConstraintMaker* make) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(@1);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return _bottomLine;
}

- (UIImageView*)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self addSubview:_arrowView];

        [_arrowView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.size.equalTo(_arrowView);
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).with.offset(-12);
        }];
    }
    return _arrowView;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //This line of code is to solve the contentView frame problem.
    self.contentView.frame = self.bounds;
}

@end

#pragma mark -

DVTableItem* makeCodeTbItem0(NSString* cellClassName, id data, DVTbviewTapBlock blk) {
    DVTableItem* item = [DVTableItem itemWithCellClassName:cellClassName];
    item.cellData = data;
    item.tapBlock = blk;
    return item;
}
DVTableItem* makeNibTbItem0(NSString* cellNibName, id data, DVTbviewTapBlock blk) {
    DVTableItem* item = [DVTableItem itemWithCellNibName:cellNibName];
    item.cellData = data;
    item.tapBlock = blk;
    return item;
}

DVTableItem* makeCodeTbItem(NSString* cellClassName, CGFloat height, id data, DVTbviewTapBlock blk)
{
    DVTableItem* item = [DVTableItem itemWithCellClassName:cellClassName];
    item.cellHeight = height;
    item.cellData = data;
    item.tapBlock = blk;
    return item;
}

DVTableItem* makeNibTbItem(NSString* cellNibName, CGFloat height, id data, DVTbviewTapBlock blk)
{
    DVTableItem* item = [DVTableItem itemWithCellNibName:cellNibName];
    item.cellHeight = height;
    item.cellData = data;
    item.tapBlock = blk;
    return item;
}

DVTableItem* makeNibInfoTbItem(NSString* cellNibName, CGFloat height, id data, DVTbviewTapBlock blk, DVTbviewExtendBlock extendBlk)
{
    DVTableItem* item = [DVTableItem itemWithCellNibName:cellNibName];
    item.cellHeight = height;
    item.cellData = data;
    item.tapBlock = blk;
    item.tapExtendBlk = extendBlk;
    return item;
}

DVTableItem* makeCodeTbItemWithHeightBlk(NSString* cellClassName, DVTbCellHeightBlock cellHeightBlk, id data, DVTbviewTapBlock blk)
{
    DVTableItem* item = [DVTableItem itemWithCellClassName:cellClassName];
    item.cellHeightBlock = cellHeightBlk;
    item.cellData = data;
    item.tapBlock = blk;
    return item;
}

DVTableItem* makeNibTbItemWithHeightBlk(NSString* cellNibName, DVTbCellHeightBlock cellHeightBlk, id data, DVTbviewTapBlock blk)
{
    DVTableItem* item = [DVTableItem itemWithCellNibName:cellNibName];
    item.cellHeightBlock = cellHeightBlk;
    item.cellData = data;
    item.tapBlock = blk;
    return item;
}
