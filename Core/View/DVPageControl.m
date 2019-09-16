//
//  MHPageControl.m
//  MakeHave
//
//  Created by forbertl on 15/12/2.
//  Copyright © 2015年 makehave. All rights reserved.
//

#import "DVPageControl.h"

@interface DVPageControl ()
@property (nonatomic, strong) NSMutableArray* dotlist;
@end

@implementation DVPageControl {
    CGSize _dotSize;
    CGFloat _dotPadding;
}

- (instancetype)initWithFrame:(CGRect)frame
                      dotSize:(CGSize)dotSize
                   ditPadding:(CGFloat)dotPadding
{
    self = [super initWithFrame:frame];
    if (self) {
        _dotlist = [@[] mutableCopy];
        _dotSize = dotSize;
        _dotPadding = dotPadding;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)resetUIByTotal:(int)total
{
    for (UIImageView* dot in _dotlist) {
        [dot removeFromSuperview];
    }
    [_dotlist removeAllObjects];

    _total = total;

    if (total < 2) {
        //1个不显示dot
        return;
    }

    CGFloat dotAllWidth = _dotSize.width * _total + _dotPadding * (_total - 1);
    CGFloat leftMargin = (self.width - dotAllWidth) / 2;
    CGFloat cellWidth = _dotSize.width;

    for (int i = 0; i < _total; i++) {
        UIImageView* img = [[UIImageView alloc] initWithImage:_activeImage highlightedImage:_inactiveImage];
        img.size = _dotSize;
        img.center = CGPointMake(leftMargin + (cellWidth + _dotPadding) * i + cellWidth / 2, self.height / 2);
        [self addSubview:img];
        [_dotlist addObject:img];
    }

    [self setCurrentIndex:0];
}
- (void)setCurrentIndex:(NSInteger)index
{
    if (index >= _dotlist.count) {
        return;
    }

    _currentIndex = index;

    for (UIImageView* dot in _dotlist) {
        dot.highlighted = NO;
    }
    ((UIImageView*)_dotlist[index]).highlighted = YES;
}

@end
