//
//  BYScrollview.m
//  IBY
//
//  Created by panshiyu on 14/12/6.
//  Copyright (c) 2014年 com.makehave. All rights reserved.
//

#import "DVPageControl.h"
#import "DVScrollview.h"

@interface DVScrollview () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView* listView;
@property (nonatomic, strong) DVPageControl* pageControl;
@property (nonatomic, strong) NSTimer* timer;

@end

@implementation DVScrollview

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout*)layout
{
    self = [super initWithFrame:frame];
    if (self) {
        _listView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.backgroundColor = [UIColor clearColor];
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
//        _listView.pagingEnabled = YES;

        [_listView registerClass:[DVScrollUnit class] forCellWithReuseIdentifier:@"DVScrollUnit"];
        [self addSubview:_listView];

        CGRect pageRect = CGRectMake(0, frame.size.height - 20, frame.size.width, 20);
        _pageControl = [[DVPageControl alloc] initWithFrame:pageRect dotSize:CGSizeMake(7, 7) ditPadding:5];
        [self addSubview:_pageControl];
    }
    return self;
}
- (void)setActivePointImage:(UIImage*)activeImage inActivePointImage:(UIImage*)inActiveImage
{
    _pageControl.activeImage = activeImage;
    _pageControl.inactiveImage = inActiveImage;
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString*)identifier
{
    [_listView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib
forCellWithReuseIdentifier:(NSString *)identifier{
    [_listView registerNib:nib forCellWithReuseIdentifier:identifier];
}

- (void)update:(NSArray*)datas
{
    if (datas.count >= 0) {

        //        dispatch_sync(dispatch_get_main_queue(),^{
        _items = [NSArray arrayWithArray:datas];
        [_listView reloadData];
        
        

        [_pageControl resetUIByTotal:(int)_items.count];
        _pageControl.currentIndex = 0;
        _pageControl.bottom = self.height;
        _pageControl.centerX = self.width / 2;
        

        if (self.autoScrollEnable) {
            [self beginAutoScroll];
        }
        //        });
    }
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    self.pageControl.hidden = !showPageControl;
}

#pragma mark - autoscroll

- (void)beginAutoScroll
{
    if (!_autoScrollEnable) {
        return;
    }

    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }

    _timer = [NSTimer scheduledTimerWithTimeInterval:DVScrollTime target:self selector:@selector(didAutoScroll) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)didAutoScroll
{
    if (!_items || _items.count == 0) {
        return;
    }

    NSInteger curIndex = _pageControl.currentIndex;
    NSInteger willIndex = (curIndex + 1) % _pageControl.total;
    NSIndexPath* path = [NSIndexPath indexPathForRow:willIndex inSection:0];

    [_listView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    _pageControl.currentIndex = willIndex;

     //       [self beginAutoScroll];
}

#pragma mark -

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (_tapBlk) {
        _tapBlk(_items[indexPath.row]);
    }
    if (_tapIndexBlk) {
        _tapIndexBlk(indexPath.row);
    }
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    DVScrollItem* item = _items[indexPath.row];
    //必须预先register item.cellIdentifier，否则这里会crash
    DVScrollUnit* unit = [collectionView dequeueReusableCellWithReuseIdentifier:item.cellIdentifier forIndexPath:indexPath];
    unit.refIteml = item;
//    if (<#condition#>) {
//        <#statements#>
//    }
//    unit.selected = YES;
    return unit;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
//{
//    [self beginAutoScroll];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    _pageControl.currentIndex = offset.x / bounds.size.width;
    if (!_autoScrollEnable) {
        return;
    }

    NSArray* visiblelist = self.listView.visibleCells;
    if (visiblelist.count == 1) {
        UICollectionViewCell* visibleCell = visiblelist.lastObject;
        NSIndexPath* curIndexPath = [self.listView indexPathForCell:visibleCell];
        _pageControl.currentIndex = curIndexPath.row;
    }
}

@end

@implementation DVScrollItem

+ (instancetype)itemWithData:(id)data imgUrl:(NSString*)imgUrl
{
    DVScrollItem* item = [[self alloc] init];
    item.data = data;
    item.imgUrl = imgUrl;
    return item;
}

- (NSString*)cellIdentifier
{
    if (_cellIdentifier) {
        return _cellIdentifier;
    }
    return @"DVScrollUnit";
}

@end

@implementation DVScrollUnit

- (void)setRefIteml:(DVScrollItem*)refIteml
{
    _refIteml = refIteml;
//    if (!_imgView) {
//        _imgView = [[DVImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//        [self.contentView addSubview:_imgView];
//    }
//
//    [_imgView setImageUrl:refIteml.imgUrl];
}

@end

#pragma mark -

DVScrollview* makeScrollview(CGRect frame, CGSize itemSize)
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.itemSize = itemSize;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    DVScrollview* listView = [[DVScrollview alloc] initWithFrame:frame layout:layout];
    listView.autoScrollEnable = YES;
    listView.showPageControl = NO;
    return listView;
}
