//
//  MHCustomButton.m
//  MakeHave
//
//  Created by Lambda on 15/8/5.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVCustomButton.h"
#import "masonry.h"

@implementation DVCustomButton

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    
    _bgView = ({
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        imgV.backgroundColor = [UIColor clearColor];
        [self addSubview:imgV];
        imgV;
    });
    
    _imgView = ({
        UIImageView *imgV = [[UIImageView alloc] init];
        [self addSubview:imgV];
        imgV;
    });
    
    _txtlabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        label;
    });
    _padding = 0;
}

- (void)updateIcon:(NSString*)normalIcon hlIcon:(NSString*)hlIcon size:(CGSize)size {
    _imgView.size = size;
    _imgView.image = [UIImage imageNamed:normalIcon];
    _imgView.highlightedImage = [UIImage imageNamed:hlIcon];
}

- (void)updateTitle:(NSString*)title color:(UIColor*)color font:(UIFont*)font {
    _txtlabel.font = font;
    _txtlabel.textColor = color;
    _txtlabel.text = title;
}

- (void)resetUI {
    
    [_txtlabel sizeToFit];
    
    CGFloat bWidth = _txtlabel.width + _imgView.width + _padding;
    _imgView.left = (self.width - bWidth) /2;
    _imgView.centerY = self.height/2;
    _txtlabel.left = _imgView.right + _padding;
    _txtlabel.centerY = self.height / 2;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    _imgView.highlighted = selected;
    
}

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

@end
