//
//  UITableViewExtension.m
//  IBY
//
//  Created by pan Shiyu on 14/11/11.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import "UITableViewExtension.h"
#import "TPKeyboardAvoidingTableView.h"

@implementation UITableView (helper)

+ (instancetype)tableViewWithFrame:(CGRect)frame delegete:(id)delegate
{
    UITableView* tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    //    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;

    tableView.separatorColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    tableView.showsVerticalScrollIndicator = NO;
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    return tableView;
}

+ (instancetype)tableViewWithFrame:(CGRect)frame delegete:(id)delegate reuseClass:(Class)reuseClass reuseId:(NSString*)reuseId
{
    UITableView* tableView = [self tableViewWithFrame:frame delegete:delegate];
    [tableView registerClass:reuseClass forCellReuseIdentifier:reuseId];
    return tableView;
}

+ (instancetype)tableViewWithFrame:(CGRect)frame delegete:(id)delegate reuseNib:(UINib*)reuseNib reuseId:(NSString*)reuseId
{
    UITableView* tableView = [self tableViewWithFrame:frame delegete:delegate];
    [tableView registerNib:reuseNib forCellReuseIdentifier:reuseId];
    return tableView;
}

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace{
    [self addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:leftSpace hasSectionLine:YES];
}

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    CGColorRef lineColor = HEXCOLOR(0xdddddd).CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    //    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    //    CGColorRef sectionLineColor = self.separatorColor.CGColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}

- (void)layer:(CALayer *)layer addLineUp:(BOOL)isUp andLong:(BOOL)isLong andColor:(CGColorRef)color andBounds:(CGRect)bounds withLeftSpace:(CGFloat)leftSpace{
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, top;
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
    }else{
        left = leftSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+left, top, bounds.size.width-left, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}



@end
