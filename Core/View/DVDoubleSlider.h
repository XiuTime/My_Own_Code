//
//  DVDoubleSlider.h
//  MakeHave
//
//  Created by pppsy on 15/8/11.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVDoubleSlider : UIControl

@property (nonatomic,strong)NSNumber *minValue;
@property (nonatomic,strong)NSNumber *maxValue;

-(id)initWithFrame:(CGRect)frame andSectionTitles:(NSArray *)sectionTitles;



@end
