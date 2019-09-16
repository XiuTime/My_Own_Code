//
//  DVCollectionViewCell.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/28.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVCollectionViewCell.h"

@implementation DVCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = [UIColor clearColor];
}

@end
