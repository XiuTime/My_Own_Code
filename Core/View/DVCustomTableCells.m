//
//  BYCustomTableCells.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVCustomTableCells.h"
#import "DVPoolNetworkView.h"

@implementation DVEmptyTableCell{
    UILabel *_tipsLabel;
}

- (void)setItem:(DVTableItem*)item
{
    super.item = item;
    self.showBottomLine = NO;
    self.backgroundColor  = HEXCOLOR(0xe6ede6);
    
    if (!_tipsLabel) {
        _tipsLabel = [UILabel labelWithFrame:DVRectMake(0, 0, SCREEN_WIDTH, item.cellHeight) font:Font(15) andTextColor:HexColor1];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_tipsLabel];
    }
    _tipsLabel.frame =DVRectMake(0, 0, SCREEN_WIDTH, item.cellHeight);
    _tipsLabel.text = item.cellData;
}

@end

@implementation DVWhiteEmptyTableCell{
    UILabel *_tipsLabel;
}
- (void)setItem:(DVTableItem*)item
{
    super.item = item;
    self.showBottomLine = NO;
    self.backgroundColor  = HEXCOLOR(0xffffff);
    
    if (!_tipsLabel) {
        _tipsLabel = [UILabel labelWithFrame:DVRectMake(0, 0, SCREEN_WIDTH, item.cellHeight) font:Font(15) andTextColor:HEXCOLOR(0x999999)];
        _tipsLabel.numberOfLines = 0;
        [self.contentView addSubview:_tipsLabel];
    }
    _tipsLabel.frame =DVRectMake(0, 0, SCREEN_WIDTH, item.cellHeight);
    _tipsLabel.text = item.cellData;
}

@end

@implementation DVBlankTableCell {
    DVEmptyView* _emptyView;
}

- (void)setItem:(DVTableItem*)item
{
    super.item = item;
    self.showBottomLine = NO;

    NSDictionary* data = item.cellData;
    if (!_emptyView) {
        _emptyView = [DVEmptyView emptyviewWithIcon:data[@"icon"] tips:data[@"tips"]];
        [self.contentView addSubview:_emptyView];
    }
    _emptyView.tipsLabel.text = data[@"tips"];
    _emptyView.iconView.image = [UIImage imageNamed:data[@"icon"]];
}

@end

@implementation DVTitleTableCell

- (void)setItem:(DVTableItem*)item
{
    super.item = item;
    self.backgroundColor = [UIColor whiteColor];
    self.showBottomLine = YES;

    NSDictionary* mapDict = item.cacheDict;

    if (!_keyLabel) {
        _keyLabel = [UILabel labelWithFrame:DVRectMake(15, 0, SCREEN_WIDTH - 15, self.height) font:Font(13) andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_keyLabel];
    }

    if (!_valueLabel) {
        _valueLabel = [UILabel labelWithFrame:DVRectMake(15, 0, SCREEN_WIDTH - 35, self.height) font:Font(13) andTextColor:[UIColor blackColor]];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_valueLabel];
    }

    if (mapDict[@"keyText"]) {
        _keyLabel.text = mapDict[@"keyText"];
    }
    if (mapDict[@"keyColor"]) {
        _keyLabel.textColor = mapDict[@"keyColor"];
    }
    if (mapDict[@"keyFont"]) {
        _keyLabel.font = mapDict[@"keyFont"];
    }
    
    if (mapDict[@"valueText"]) {
        _valueLabel.text = mapDict[@"valueText"];
    }
    if (mapDict[@"valueColor"]) {
        _valueLabel.textColor = mapDict[@"valueColor"];
    }
    if (mapDict[@"valueFont"]) {
        _valueLabel.font = mapDict[@"valueFont"];
    }
}

@end

DVTableItem* emptyItem(int height)
{
    return makeCodeTbItem(@"DVEmptyTableCell", height, nil, nil);
}
DVTableItem* whiteEmptyItem(int height)
{
    return makeCodeTbItem(@"DVWhiteEmptyTableCell", height, nil, nil);
}
DVTableItem* emptyTipsItem(int height,NSString *tips) {
    return makeCodeTbItem(@"DVEmptyTableCell", height, tips, nil);
}

DVTableItem* blankItem(int height, NSString* tips, NSString* icon)
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict safeSetValue:icon forKey:@"icon"];
    [dict safeSetValue:tips forKey:@"tips"];
    return makeCodeTbItem(@"DVBlankTableCell", height, dict, nil);
}
