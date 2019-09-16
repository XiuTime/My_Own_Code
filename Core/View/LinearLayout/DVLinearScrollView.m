//
//  MTAutoLinearLayoutScrollView.m
//  iMeituan
//
//  Created by pp on 6/27/13.
//  Copyright (c) 2013 iby. All rights reserved.
//

#import "DVLinearScrollView.h"

@implementation DVLinearScrollView {
    UITapGestureRecognizer* _tapTextViewGesture;
}

- (NSUInteger)by_addEmptyViewWithPaddingTop:(CGFloat)top
{
    UIView* emptyView = [[UIView alloc] initWithFrame:DVRectMake(0, 0, self.width, 8)];
    emptyView.backgroundColor = [UIColor clearColor];
    return [self by_addSubview:emptyView paddingTop:top];
}

- (NSUInteger)by_addSubview:(UIView*)view paddingTop:(CGFloat)top
{
    return [self by_addSubview:view paddingTop:top paddingBottom:0];
}

- (NSUInteger)by_addSubview:(UIView*)view paddingTop:(CGFloat)top paddingBottom:(CGFloat)bottom
{
    [super addSubview:view];

    DVLinearItem* item = [[DVLinearItem alloc] initWithView:view paddingTop:top paddingBottom:bottom];
    [_items addObject:item];

    if (_autoAdjustFrameSize) {
        [self resetFrameSize];
    }

    if (_autoAdjustContentSize) {
        [self resetContentSize];
    }

    [self by_updateDisplay];
    return _items.count - 1;
}

- (void)by_removeSubview:(UIView*)view
{
    DVLinearItem* realItem = [_items bk_match:^BOOL(DVLinearItem* obj) {
        return obj.view == view;
    }];
    if (realItem) {
        [realItem.view removeFromSuperview];
        [_items removeObject:realItem];
        [self by_updateDisplay];
    }
}

- (void)by_removeSubviewAtIndex:(NSUInteger)index
{
    if (index >= _items.count) {
        return;
    }

    DVLinearItem* realItem = _items[index];
    [realItem.view removeFromSuperview];
    [_items removeObject:realItem];
    [self by_updateDisplay];
}

- (void)by_removeAllSubviews
{
    [_items bk_each:^(DVLinearItem* obj) {
        [obj.view removeFromSuperview];
    }];
    [_items removeAllObjects];
    [self by_updateDisplay];
}

- (void)by_removeItemWithoutUpdate:(DVLinearItem*)item {
    if (item) {
        [item.view removeFromSuperview];
        [_items removeObject:item];
    }
}

- (void)by_insertSubview:(UIView*)newView atIndex:(NSUInteger)index
{
    if (index >= _items.count) {
        return;
    }

    [super addSubview:newView];
    DVLinearItem* realItem = [[DVLinearItem alloc] initWithView:newView paddingTop:0 paddingBottom:0];
    [_items insertObject:realItem atIndex:index];
 
}

- (void)by_updateDisplay
{
    float curBottom = 0;
    for (DVLinearItem* item in _items) {
        if (item.view.hidden) {
            continue;
        }
        curBottom += item.paddingTop;
        item.view.top = curBottom;
        curBottom = curBottom + item.view.height + item.paddingBottom;
    }
    
    curBottom = MAX(curBottom, _minContentSizeHeight);
    
    self.contentSize = CGSizeMake(self.frame.size.width, curBottom);
    
    if (_autoAdjustFrameSize) {
        [self resetFrameSize];
    }
}

- (CGFloat)by_layoutOffset
{
    return [self layoutOffset];
}

#pragma mark -

- (void)resetFrameSize
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [self layoutOffset]);
}

- (void)resetContentSize
{
    float curOffset = [self layoutOffset];
    curOffset = MAX(curOffset, _minContentSizeHeight);
    self.contentSize = CGSizeMake(self.frame.size.width, curOffset);
}

- (CGFloat)layoutOffset
{
    CGFloat curOffset = 0;
    for (DVLinearItem* item in _items) {
        if (item.view.hidden) {
            continue;
        }
        curOffset = curOffset + item.paddingTop + item.view.height + item.paddingBottom;
    }
    return curOffset;
}

#pragma mark - init things

- (id)init
{
    self = [super init];
    if (self) {
        [self setupLinearScrollView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLinearScrollView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupLinearScrollView];
    }
    return self;
}

- (void)setupLinearScrollView
{
    [self observeTextView:YES];
    _items = [[NSMutableArray alloc] init];
    _autoAdjustFrameSize = NO;
    _autoAdjustContentSize = YES;
    self.autoresizesSubviews = NO;

    self.backgroundColor = [UIColor clearColor];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (void)observeTextView:(BOOL)isObserveTextView
{
    if (!isObserveTextView) {
        if (_tapTextViewGesture) {
            [self removeGestureRecognizer:_tapTextViewGesture];
            _tapTextViewGesture = nil;
        }
    }
    else {
        if (!_tapTextViewGesture) {
            _tapTextViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap)];
            _tapTextViewGesture.cancelsTouchesInView = NO;
            _tapTextViewGesture.delegate = self;
            [self addGestureRecognizer:_tapTextViewGesture];
        }
    }
}

- (void)onBackgroundTap
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end

DVLinearScrollView* makeLinearScrollView(UIViewController* vc)
{
    DVLinearScrollView* bodyView = makeSimpleLinearScrollView(vc);
    bodyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return bodyView;
}

DVLinearScrollView* makeSimpleLinearScrollView(UIViewController* vc)
{
    DVLinearScrollView* bodyView = [[DVLinearScrollView alloc] initWithFrame:DVRectMake(0, 0, vc.view.width, vc.view.height)];
    bodyView.backgroundColor = [UIColor clearColor];
    return bodyView;
}
