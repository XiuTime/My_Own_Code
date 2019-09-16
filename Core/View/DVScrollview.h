//
//  BYScrollview.h
//  IBY
//
//  Created by panshiyu on 14/12/6.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVImageView.h"

#define DVScrollTime 3.0
@class DVScrollItem;
@class DVPageControl;
typedef void (^DVScrollTapBlock)(DVScrollItem* item);
typedef void (^DVScrollTapIndexBlock)(NSUInteger index);
typedef void (^DVScrollTapBtnBlock)(UIButton* btn);
//简单来说，就是scrollview + pageControl的功能
@interface DVScrollview : UIView


@property (nonatomic, copy) DVScrollTapBlock tapBlk;
@property (nonatomic, copy) DVScrollTapIndexBlock tapIndexBlk;
@property (nonatomic, assign) BOOL autoScrollEnable;
@property (nonatomic, assign) BOOL showPageControl;
@property (nonatomic, strong, readonly) NSArray* items;

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout*)layout;
- (void)update:(NSArray*)datas;
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib
    forCellWithReuseIdentifier:(NSString *)identifier;
- (void)setActivePointImage:(UIImage*)activeImage inActivePointImage:(UIImage*)inActiveImage;
@end


@interface DVScrollItem : NSObject
@property (nonatomic, copy) NSString* cellIdentifier;
@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString* imgUrl;
@property (nonatomic,assign) BOOL isActive;
@property (nonatomic,copy)DVScrollTapBtnBlock tapBtnBlk;
+ (instancetype)itemWithData:(id)data imgUrl:(NSString*)imgUrl;
@end

@interface DVScrollUnit : UICollectionViewCell
@property (nonatomic, strong) DVScrollItem* refIteml;
@property (nonatomic, strong) DVImageView* imgView;
@end
  

//space = 0 Horizontal
DVScrollview *makeScrollview(CGRect frame ,CGSize itemSize);


