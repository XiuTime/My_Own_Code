//
//  BYCustomTableCells.h
//  MakeHave
//
//  Created by pan Shiyu on 15/7/27.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVTableCell.h"
#import <Foundation/Foundation.h>

//空cell，全空，什么都没有
@interface DVEmptyTableCell : DVTableCell

@end

@interface DVWhiteEmptyTableCell : DVTableCell

@end

//空白页 cell，用来做空白页提示，可以有内容
@interface DVBlankTableCell : DVTableCell

@end

// DVTitleTableCell 可采用dict的形式去改变keyvalue的一些属性，后续可以考虑换成 attr的形式
//{   @"keyText" : @"text",
//    @"keyColor" : @"color",
//    @"keyFont" : @"font",
//
//    @"valueText" : @"text",
//    @"valueColor" : @"color",
//    @"valueFont" : @"font",
//}
@interface DVTitleTableCell : DVTableCell

@property (nonatomic, strong) UILabel* keyLabel;
@property (nonatomic, strong) UILabel* valueLabel;
@end

DVTableItem* emptyItem(int height);
DVTableItem* whiteEmptyItem(int height);
DVTableItem* emptyTipsItem(int height,NSString *tips);
DVTableItem* blankItem(int height, NSString* tips, NSString* icon);
