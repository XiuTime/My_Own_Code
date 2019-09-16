//
//  DVTableCell.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/22.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@class DVTableItem, DVTableCell;

typedef void (^DVTbviewTapBlock)(UITableView* tbview, NSIndexPath* indexPath, DVTableItem* item, DVTableCell* cell);
typedef void (^DVTbviewExtendBlock)(DVTableItem* item, DVTableCell* cell);
typedef CGFloat (^DVTbCellHeightBlock)(DVTableItem* item);

//cellClassName 和 cellNibName不可以都为空
@interface DVTableItem : NSObject {
    NSString* _cellClassName;
    NSString* _cellNibName;
    Class _cellClass;
    CGFloat _cellHeight;
    SEL _selectAction;
}
@property (nonatomic, copy) NSString* cellClassName;
@property (nonatomic, copy) NSString* cellNibName;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) DVTbviewTapBlock tapBlock;
@property (nonatomic, copy) DVTbviewExtendBlock tapExtendBlk;
@property (nonatomic, copy) DVTbviewExtendBlock tapExtendBlk1;
@property (nonatomic, strong) id cellData;
@property (nonatomic, copy) DVTbCellHeightBlock cellHeightBlock;
@property (nonatomic, strong) NSMutableDictionary* cacheDict;



+ (id)itemWithCellClassName:(NSString*)cellClassName;
+ (id)itemWithCellNibName:(NSString*)cellNibName;

@end

@interface DVTableCell : UITableViewCell
//一般用不到
@property (nonatomic, strong) UIImageView* arrowView;
@property (nonatomic, strong) UIImageView* bottomLine;

@property (nonatomic, assign) BOOL showRightArrow;
@property (nonatomic, assign) BOOL showBottomLine;
@property (nonatomic, strong) DVTableItem* item; //set方法去做UI更新
@property (nonatomic, assign)BOOL isSelect;

@end

#pragma mark - quick tools

//这个会逐步推行
DVTableItem* makeCodeTbItem0(NSString* cellClassName, id data, DVTbviewTapBlock blk);
DVTableItem* makeNibTbItem0(NSString* cellNibName, id data, DVTbviewTapBlock blk);

//弱化
DVTableItem* makeCodeTbItem(NSString* cellClassName, CGFloat height, id data, DVTbviewTapBlock blk);
DVTableItem* makeNibTbItem(NSString* cellNibName, CGFloat height, id data, DVTbviewTapBlock blk);

//逐渐弱化(被误用和滥用了)  因为HeightBlock并没有实现在实际用到的时候动态计算高度的作用，也只是预先计算(不过更新cell高度的话这个block还是可以发挥作用)
DVTableItem* makeCodeTbItemWithHeightBlk(NSString* cellClassName, DVTbCellHeightBlock cellHeightBlk, id data, DVTbviewTapBlock blk);
DVTableItem* makeNibTbItemWithHeightBlk(NSString* cellNibName, DVTbCellHeightBlock cellHeightBlk, id data, DVTbviewTapBlock blk);
DVTableItem* makeNibInfoTbItem(NSString* cellNibName, CGFloat height, id data, DVTbviewTapBlock blk, DVTbviewExtendBlock extendBlk);
