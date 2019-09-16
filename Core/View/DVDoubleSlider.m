//
//  DVDoubleSlider.m
//  MakeHave
//
//  Created by pppsy on 15/8/11.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVDoubleSlider.h"
#define kmarginTop 36
#define ksliderHeight ([UIScreen mainScreen].bounds.size.height - 190 - 38 )
#define kviewHeight ([UIScreen mainScreen].bounds.size.height - 190 )


@interface DVDoubleSlider ()
@property (nonatomic, strong)UIImageView *backgroudView;
@property (nonatomic, strong)UIImageView *activBackgroudView;
@property (nonatomic, strong)UIImageView *topBarView;
@property (nonatomic, strong)UIImageView *downBarView;
@end

//这里以top作为值的精确计算值
@implementation DVDoubleSlider {
    
    NSArray *_values;
    CGFloat _unitDistance;//单位之间的平均间距
    CGFloat _cellDistance;//两个滑块之间的最小间距
    
    CGFloat _marginDownTop;//底部滑块的最大值的顶部位置
    
    BOOL _maxThumbOn;
    BOOL _minThumbOn;
    
    CGFloat _initPointY;
    CGFloat _initTopY;
    CGFloat _initDownY;
    
    UILabel *_topValueLabel;
    UILabel *_downValueLabel;
    
}

NSString* descFromValue(int num) {
    if (num == INT_MAX) {
        return @"∞";
    }
    return [@(num) stringValue];
}

NSNumber *numberFromValue (int num) {
    if (num == INT_MAX) {
        return nil;
    }
    return @(num);
}

- (NSNumber*)minValue {
    return numberFromValue([self valueFromPos:_topBarView.top]);
}

- (NSNumber*)maxValue {
    return numberFromValue([self valueFromPos:_downBarView.top]);
}

- (void)setMinValue :(NSNumber*)minValue {
    [self manualSetValue:minValue forView:_topBarView];
}

- (void)setMaxValue :(NSNumber*)maxValue {
    [self manualSetValue:maxValue forView:_downBarView];
}

- (void)manualSetValue:(NSNumber*)numValue forView:(UIView*)view{
    if (!numValue) {
        return;
    }
    CGFloat pos = [self posFromValue:[numValue intValue]];
    if (pos < 0) {
        return;
    }
    view.top = pos;
    [self adjustActivBackgroudView];
    [self adjustActiveLabel];
}

#pragma mark -

-(id)initWithFrame:(CGRect)frame andSectionTitles:(NSArray *)sectionTitles {
    self = [super initWithFrame:frame];
    if (self) {
        
        _values = sectionTitles;
        _unitDistance = floorf(ksliderHeight / _values.count);
        _cellDistance = 26 + 4;
        _marginDownTop = kmarginTop + ksliderHeight - 26;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _backgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider_filter_bg_normal"]];
        [_backgroudView setFrame:CGRectMake(self.width / 2 - 5, kmarginTop, 10, ksliderHeight)];
        _backgroudView.backgroundColor = HEXCOLOR(0xcccccc);
        [self addSubview:_backgroudView];
        
        _activBackgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider_filter_bg_active"]];
        [_activBackgroudView setFrame:CGRectMake(self.width / 2 - 5, kmarginTop, 10, ksliderHeight)];
        _activBackgroudView.backgroundColor = HEXCOLOR(0xb29510);
        [self addSubview:_activBackgroudView];
        
        for (int i=0; i<=_values.count; i++) {
            UIView *line1 = [[UIView alloc] initWithFrame:DVRectMake(0, 0, 15, 1)];
            line1.right = _backgroudView.left - 10;
            line1.centerY = kmarginTop + _unitDistance * i;
            line1.backgroundColor = HEXCOLOR(0xcccccc);
            [self addSubview:line1];
            
            UIView *line2 = [[UIView alloc] initWithFrame:DVRectMake(0, 0, 15, 1)];
            line2.left = _backgroudView.right + 10;
            line2.centerY = kmarginTop + _unitDistance * i;
            line2.backgroundColor = HEXCOLOR(0xcccccc);
            [self addSubview:line2];
            
            NSString *str = @"∞";
            if (i<_values.count) {
                str = [NSString stringWithFormat:@"%@",_values[i]];
            }
            
            UILabel *label = [UILabel labelWithFrame:DVRectMake(0, 0, 60, 20) font:Font(12) andTextColor:HEXCOLOR(0x999999)];
            label.centerY = line1.centerY;
            label.textAlignment = NSTextAlignmentRight;
            label.text = str;
            [self addSubview:label];
        }
        _topValueLabel = [UILabel labelWithFrame:DVRectMake(_backgroudView.right + 40, 0, 60, 20) font:BoldFont(14) andTextColor:HEXCOLOR(0xb29510)];
        [self addSubview:_topValueLabel];
        
        _downValueLabel = [UILabel labelWithFrame:DVRectMake(_backgroudView.right + 40, 0, 60, 20) font:BoldFont(14) andTextColor:HEXCOLOR(0xb29510)];
        [self addSubview:_downValueLabel];
        
        _topBarView = makeImgView(DVRectMake(0, kmarginTop, 33, 26), @"icon_slider_bar");
        _topBarView.centerX = _backgroudView.centerX;
        _topBarView.userInteractionEnabled = NO;
        [self addSubview:_topBarView];
        
        _downBarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_slider_bar"]];
        _downBarView.centerX = _backgroudView.centerX;
        _downBarView.top = _marginDownTop;
        _downBarView.userInteractionEnabled = NO;
        [self addSubview:_downBarView];
        
    }
    return self;
}


#pragma mark -

-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touch locationInView:self];
    _initPointY = touchPoint.y;
    _initTopY = _topBarView.top;
    _initDownY = _downBarView.top;
    
    //这里要注意，增加edge是为了点击更灵敏，但是不可以影响到其他滑块的移动
    //所以你在看上滑动不增加bottomEdge，下滑动不增加topEdge
    CGRect topRespondArea = UIEdgeInsetsInsetRect(_topBarView.frame, UIEdgeInsetsMake(-15, -15, 0, -15));
    CGRect downRespondArea = UIEdgeInsetsInsetRect(_downBarView.frame, UIEdgeInsetsMake(0, -15, -15, -15));
    
    if(CGRectContainsPoint(topRespondArea, touchPoint)){
        _minThumbOn = YES;
    }
    else if(CGRectContainsPoint(downRespondArea, touchPoint)){
        _maxThumbOn = YES;
        
    }
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    if(_minThumbOn){
        CGFloat newY = touchPoint.y - _initPointY + _initTopY;
        if (newY >= kmarginTop && newY < _downBarView.top - _cellDistance) {
            _topBarView.top = newY;
        }
    }
    if(_maxThumbOn){
        CGFloat newY = touchPoint.y - _initPointY + _initDownY;
        if (newY <= _marginDownTop && newY > _topBarView.top + _cellDistance) {
            _downBarView.top = newY;
        }
    }

    [self adjustActivBackgroudView];
    [self adjustActiveLabel];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    _minThumbOn = NO;
    _maxThumbOn = NO;
    
    [self adjustActivBackgroudView];
    [self adjustActiveLabel];
    [self sendActionsForControlEvents:UIControlEventTouchDragExit];
}

#pragma mark -

/**计算原理
 1,通过商计算所在的数组
 2,根据余数计算所在的两单位之间的均分差值
 
 */
- (int)valueFromPos:(CGFloat)ypos{
    CGFloat num = (ypos - kmarginTop) / _unitDistance;
    NSInteger index = (NSInteger)num;
    CGFloat subNum = num - index;
    
    if (index >= _values.count - 1) {
        return INT_MAX;
    }
    
    int beginValue = [_values[index] intValue];
    int endValue = [_values[index+1] intValue];
    
    return (int)( beginValue + (endValue - beginValue) * subNum );
}

- (CGFloat)posFromValue:(CGFloat)value {
    NSInteger index = NSNotFound;
    for (int i=0; i<_values.count - 1; i++) {
        if (value >= [_values[i] intValue] && value < [_values[i+1] intValue]) {
            index = i;
            break;
        }
    }
    if (index == NSNotFound) {
        return -1;
    }
    
    CGFloat basePos = [_values[index] intValue] ;
    CGFloat delDistance = (value - basePos) * _unitDistance / ([_values[index+1] intValue] - [_values[index] intValue]);
    return ceilf((_unitDistance * index + delDistance + kmarginTop));
}

- (void)adjustActiveLabel {
    _topValueLabel.centerY = _topBarView.centerY;
    _downValueLabel.centerY = _downBarView.centerY;
    
    _topValueLabel.text = descFromValue([self valueFromPos:_topBarView.top]);
    _downValueLabel.text = descFromValue([self valueFromPos:_downBarView.top]);
}

- (void)adjustActivBackgroudView {
    [_activBackgroudView setFrame:CGRectMake(self.width / 2 - 5, _topBarView.top, 10, _downBarView.top - _topBarView.top)];
}

@end
