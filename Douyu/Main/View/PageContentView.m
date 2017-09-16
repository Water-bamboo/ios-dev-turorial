//
//  PageContentView.m
//  Douyu
//
//  Created by Shui on 2017/9/10.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import "PageContentView.h"

@interface PageContentView() <UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;
@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, strong) UICollectionView *uiCollectionView;

//scroll offset
@property (nonatomic, assign) CGPoint contentOffset;

@end

#define kCellId @"kCellId"

@implementation PageContentView

- (instancetype) initWithChildVC:(CGRect) frame
                         vcArray:(NSArray<UIViewController *>*) vcArray
            parentViewController:(UIViewController *) parentVC
{
    self = [super initWithFrame:frame];
    if (self) {
        _childVCs = [NSArray arrayWithArray:vcArray];
        _parentVC = parentVC;
        [self setupUI];
    }
    
    return self;
}

- (void) setupUI
{
    //add child view.
    for (UIViewController *vc in _childVCs) {
        [_parentVC addChildViewController:vc];
    }

    //init collectionview
    UICollectionViewFlowLayout * collectionViewLayer = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayer.itemSize = self.bounds.size;
    collectionViewLayer.minimumLineSpacing = 0;
    collectionViewLayer.minimumInteritemSpacing = 0;
    collectionViewLayer.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    _uiCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:collectionViewLayer];
    _uiCollectionView.showsHorizontalScrollIndicator = false;
    _uiCollectionView.dataSource = self;
    ((UIScrollView*)_uiCollectionView).delegate = self;
    _uiCollectionView.pagingEnabled = true;
    _uiCollectionView.bounces = false;
    [_uiCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellId];
    _uiCollectionView.backgroundColor = [UIColor redColor];
    
    [self addSubview:_uiCollectionView];
}

#pragma mark: datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
//    NSLog(@"indexPath.item=%d", indexPath.item);
    UIViewController *vc = _childVCs[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma pagetitle click event:
- (void)itemSelected:(NSInteger)newIndex
{
    _uiCollectionView.contentOffset = CGPointMake(newIndex * self.bounds.size.width, 0);
}

#pragma delegate of scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //往zuo边拽
//    if (scrollView.contentOffset.x > _contentOffset.x) {
        CGFloat offset = scrollView.contentOffset.x - _contentOffset.x;
        CGFloat progress = offset/self.bounds.size.width;

    if (progress == 1 || progress == -1)
    {
        if ([self.delegate respondsToSelector:@selector(viewScrolled:scrollDirection:)]) {
            [self.delegate viewScrolled:progress scrollDirection:0];
        }
    }
//    }
    //往you拽，看右边
//    else {
//        CGFloat offset = _contentOffset.x - scrollView.contentOffset.x;
//        CGFloat progress = offset/self.bounds.size.width;
//
//        if ([self.delegate respondsToSelector:@selector(viewScrolled:scrollDirection:)]) {
//            [self.delegate viewScrolled:progress scrollDirection:1];
//        }
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _contentOffset = scrollView.contentOffset;
}


@end
