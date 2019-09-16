//
//  SegmentControl.h
//  GT
//
//  Created by tage on 14-2-26.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XTSegmentControlBlock)(NSInteger index);

@interface XTSegmentControl : UIView
@property (nonatomic) NSInteger currentIndex;

@property (nonatomic,strong) UIColor *titleNormalColor;
@property (nonatomic,strong) UIColor *titleHighlightColor;
@property (nonatomic,strong) UIColor *bottomLineColor;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray*)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle;
- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray*)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle customColors:(NSDictionary*)colorDict;

- (void)selectIndex:(NSInteger)index;
- (void)moveIndexWithProgress:(float)progress;
- (void)endMoveIndex:(NSInteger)index;


- (UILabel *)labelFromIndex:(NSInteger)index;

@end
