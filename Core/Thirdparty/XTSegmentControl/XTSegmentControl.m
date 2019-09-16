//
//  SegmentControl.m
//  GT
//
//  Created by tage on 14-2-26.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "XTSegmentControl.h"

#define XTSegmentControlItemNormalFont Font(15)
#define XTSegmentControlItemHightFont BoldFont(15)
#define XTSegmentControlItemNormalColor HEXACOLOR(0xffffff, 0.5)
#define XTSegmentControlItemHightColor HEXCOLOR(0xffffff)
#define XTSegmentControlBottomLineColor HEXCOLOR(0xffffff)
#define XTSegmentControlHspace (0)
#define XTSegmentControlLineHeight (2)
#define XTSegmentControlAnimationTime (0.3)



@interface XTSegmentControlItem : UIView

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, assign) CGRect redLineFrame;

@property (nonatomic,strong) UIColor *titleNormalColor;
@property (nonatomic,strong) UIColor *titleHighlightColor;

- (void)setSelected:(BOOL)selected;
@end

@implementation XTSegmentControlItem

- (UIColor*)normalColor{
    return _titleNormalColor?_titleNormalColor : XTSegmentControlItemNormalColor;
}

- (UIColor*)hlColor{
    return _titleHighlightColor?_titleHighlightColor : XTSegmentControlItemHightColor;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title normalColor:(UIColor *)normalColor
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _titleLabel = ({

            //                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XTSegmentControlHspace, 0, CGRectGetWidth(self.bounds) - 2 * XTSegmentControlHspace, CGRectGetHeight(self.bounds))];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
            label.font = XTSegmentControlItemNormalFont;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            label.textColor = normalColor?normalColor:XTSegmentControlItemNormalColor;
            label.backgroundColor = [UIColor clearColor];
            label;
        });

        [self addSubview:_titleLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected
{
    if (_titleLabel) {
        _titleLabel.font = (selected ? XTSegmentControlItemHightFont : XTSegmentControlItemNormalFont);
        _titleLabel.textColor = (selected ? [self hlColor] : [self normalColor]);
    }
}

- (CGRect)redLineFrame
{
//        CGFloat lineWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(1000, 100)].width + 6;
//        CGFloat centerX = self.centerX;
//    
//        return CGRectMake(floorf(centerX - lineWidth / 2), self.bottom - 3.5, lineWidth, 2);
    CGFloat lineWidth = self.width;
    CGFloat centerX = self.centerX;
    return CGRectMake(floorf(centerX - lineWidth / 2) + 4, self.bottom - 2, lineWidth - 8, 2);
}

@end

@interface XTSegmentControl () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* contentView;

@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) NSMutableArray* itemFrames;

@property (nonatomic, strong) NSMutableArray* items;

@property (nonatomic, copy) XTSegmentControlBlock block;

@end

@implementation XTSegmentControl

- (UILabel *)labelFromIndex:(NSInteger)index{
    if (index >= self.items.count)
        return nil;
    XTSegmentControlItem *bItem = self.items[index];
    return bItem.titleLabel;
}

- (UIColor*)lineColor{
    return _bottomLineColor?_bottomLineColor : XTSegmentControlBottomLineColor;
}

- (id)initWithFrame:(CGRect)frame Items:(NSArray*)titleItem
{
    if (self = [super initWithFrame:frame]) {
        [self initUIWith:NO Items:titleItem];
    }
    return self;
}

- (void)initUIWith:(BOOL)isIcon Items:(NSArray*)titleItem
{
    _contentView = ({
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        [self addSubview:scrollView];

        UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [scrollView addGestureRecognizer:tapGes];
        [tapGes requireGestureRecognizerToFail:scrollView.panGestureRecognizer];
        scrollView;
    });

    [self initItemsWithTitleArray:titleItem];
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray*)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.block = selectedHandle;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray*)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle customColors:(NSDictionary*)colorDict {
    
    if (self = [super initWithFrame:frame]) {
        if (colorDict) {
            _titleNormalColor = colorDict[@"tNormal"];
            _titleHighlightColor = colorDict[@"tHl"];
            _bottomLineColor = colorDict[@"line"];
        }
        [self initUIWith:NO Items:titleItem];
        self.block = selectedHandle;
    }
    return self;
}

- (void)doTap:(UITapGestureRecognizer*)sender
{
    CGPoint point = [sender locationInView:sender.view];

    __weak typeof(self) weakSelf = self;

    [_itemFrames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {

        CGRect rect = [obj CGRectValue];

        if (CGRectContainsPoint(rect, point)) {

            [weakSelf selectIndex:idx];

            [weakSelf transformAction:idx];

            *stop = YES;
        }
    }];
}

- (void)transformAction:(NSInteger)index
{
    if (self.block) {

        self.block(index);
    }
}

- (void)initItemsWithTitleArray:(NSArray*)titleArray
{
    _itemFrames = @[].mutableCopy;
    _items = @[].mutableCopy;
    float y = 0;
    float height = CGRectGetHeight(self.bounds);

    NSObject* obj = [titleArray firstObject];
    if ([obj isKindOfClass:[NSString class]]) {
        for (int i = 0; i < titleArray.count; i++) {
            float x = i > 0 ? CGRectGetMaxX([_itemFrames[i - 1] CGRectValue]) : 0;
            float width = self.size.width / titleArray.count;
            CGRect rect = CGRectMake(x, y, width, height);

            [_itemFrames addObject:[NSValue valueWithCGRect:rect]];
        }

        for (int i = 0; i < titleArray.count; i++) {
            CGRect rect = [_itemFrames[i] CGRectValue];
            NSString* title = titleArray[i];
            XTSegmentControlItem* item = [[XTSegmentControlItem alloc] initWithFrame:rect title:title normalColor:_titleNormalColor];
            item.titleNormalColor = _titleNormalColor;
            item.titleHighlightColor = _titleHighlightColor;
            if (i == 0) {
                [item setSelected:YES];
            }
            [_items addObject:item];
            [_contentView addSubview:item];
        }
    }
    [_contentView setContentSize:CGSizeMake(CGRectGetMaxX([[_itemFrames lastObject] CGRectValue]), CGRectGetHeight(self.bounds))];
    self.currentIndex = 0;
    [self selectIndex:0];
}

- (void)addRedLine
{
    if (!_lineView) {
        XTSegmentControlItem* zeroItem = _items[0];

        _lineView = [[UIView alloc] init];
        _lineView.frame = zeroItem.redLineFrame;
        _lineView.backgroundColor = [self lineColor];
        _lineView.hidden = YES;
        [_contentView addSubview:_lineView];

//        UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//        bottomLineView.backgroundColor = HEXCOLOR(0xc8c7cc);
//        bottomLineView.bottom = _lineView.bottom;
//        [_contentView addSubview:bottomLineView];

        [_contentView bringSubviewToFront:_lineView];
    }
}

- (void)selectIndex:(NSInteger)index
{
    [self addRedLine];

    if (index < 0) {
        _currentIndex = -1;
        _lineView.hidden = TRUE;
        for (XTSegmentControlItem* curItem in _items) {
            [curItem setSelected:NO];
        }
    }
    else {
        _lineView.hidden = FALSE;

        if (index != _currentIndex) {
            XTSegmentControlItem* curItem = [_items objectAtIndex:index];

            if (_currentIndex < 0) {
                _lineView.frame = curItem.redLineFrame;
                [curItem setSelected:YES];
                _currentIndex = index;
            }
            else {
                [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
                    _lineView.frame = curItem.redLineFrame;
                }
                    completion:^(BOOL finished) {
                        [_items enumerateObjectsUsingBlock:^(XTSegmentControlItem* item, NSUInteger idx, BOOL* stop) {
                            [item setSelected:NO];
                        }];
                        [curItem setSelected:YES];
                        _currentIndex = index;
                    }];
            }
        }
        [self setScrollOffset:index];
    }
}

- (void)moveIndexWithProgress:(float)progress
{
    progress = MAX(0, MIN(progress, _items.count));

    float delta = progress - _currentIndex;

    XTSegmentControlItem* fromItem = _items[_currentIndex];

    CGRect origionRect = fromItem.redLineFrame;
    CGRect origionLineRect = fromItem.redLineFrame;

    CGRect rect;

    if (delta > 0) {
        //        如果delta大于1的话，不能简单的用相邻item间距的乘法来计算距离
        if (delta > 1) {
            self.currentIndex += floorf(delta);
            fromItem = _items[_currentIndex];

            delta -= floorf(delta);
            origionRect = fromItem.redLineFrame;
            origionLineRect = fromItem.redLineFrame;
        }

        if (_currentIndex == _itemFrames.count - 1) {
            return;
        }

        rect = [_itemFrames[_currentIndex + 1] CGRectValue];

        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);

        XTSegmentControlItem* fromItem1 = _items[_currentIndex + 1];
        lineRect = fromItem1.redLineFrame;
        CGRect moveRect = CGRectZero;

        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) + delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        moveRect.origin = CGPointMake(CGRectGetMidX(origionLineRect) + delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(origionLineRect) - CGRectGetMidY(moveRect));
        _lineView.frame = moveRect;
    }
    else if (delta < 0) {

        if (_currentIndex == 0) {
            return;
        }
        XTSegmentControlItem* fromItem1 = _items[_currentIndex - 1];

        CGRect lineRect = fromItem1.redLineFrame;
        CGRect moveRect = CGRectZero;
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) - delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        moveRect.origin = CGPointMake(CGRectGetMidX(origionLineRect) - delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(origionLineRect) - CGRectGetMidY(moveRect));
        _lineView.frame = moveRect;
        if (delta < -1) {
            self.currentIndex -= 1;
        }
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    currentIndex = MAX(0, MIN(currentIndex, _items.count));

    if (currentIndex != _currentIndex) {
        XTSegmentControlItem* preItem = [_items objectAtIndex:_currentIndex];
        XTSegmentControlItem* curItem = [_items objectAtIndex:currentIndex];
        [preItem setSelected:NO];
        [curItem setSelected:YES];
        _currentIndex = currentIndex;
    }
}

- (void)endMoveIndex:(NSInteger)index
{
    [self selectIndex:index];
}

- (void)setScrollOffset:(NSInteger)index
{
    if (_contentView.contentSize.width <= SCREEN_WIDTH) {
        return;
    }

    CGRect rect = [_itemFrames[index] CGRectValue];

    float midX = CGRectGetMidX(rect);

    float offset = 0;

    float contentWidth = _contentView.contentSize.width;

    float halfWidth = CGRectGetWidth(self.bounds) / 2.0;

    if (midX < halfWidth) {
        offset = 0;
    }
    else if (midX > contentWidth - halfWidth) {
        offset = contentWidth - 2 * halfWidth;
    }
    else {
        offset = midX - halfWidth;
    }

    [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
        [_contentView setContentOffset:CGPointMake(offset, 0) animated:NO];
    }];
}

int ExceMinIndex(float f)
{
    int i = (int)f;
    if (f != i) {
        return i + 1;
    }
    return i;
}

@end
