//
//  JwCarouselView.m
//  ZeroBuy
//
//  Created by 陈警卫 on 2019/1/3.
//  Copyright © 2019年 namei. All rights reserved.
//

#import "JwCarouselView.h"

@interface JwCarouselView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JwCarouselView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = self.bounds.size;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:(self.bounds) collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.clipsToBounds = NO;
    self.collectionView.layer.masksToBounds = NO;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[JwCarouselCell class] forCellWithReuseIdentifier:@"JwCarouselCell"];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)timerAction:(NSTimer *)timer{
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.jw_width;
    if (page == self.datas.count - 1) {
        [self.collectionView setContentOffset:(CGPointZero) animated:NO];
        [self.collectionView setContentOffset:(CGPointMake(self.collectionView.jw_width, 0)) animated:YES];
    }else{
        [self.collectionView setContentOffset:(CGPointMake(self.collectionView.contentOffset.x + self.collectionView.jw_width , 0)) animated:YES];
    }
    NSInteger index = self.collectionView.contentOffset.x / self.collectionView.jw_width;
    if (self.didScrollCurrentIndex) {
        self.didScrollCurrentIndex(index);
    }
}

- (void)registerCellWithName:(NSString *)name isXib:(BOOL)isXib{
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:name bundle:nil] forCellWithReuseIdentifier:name];
    }else{
        [self.collectionView registerClass:NSClassFromString(name) forCellWithReuseIdentifier:name];
    }
}


- (void)setDatas:(NSArray *)datas{
    [(NSMutableArray *)datas insertObject:[datas lastObject] atIndex:0];
    _datas = datas;
    [self.collectionView reloadData];
    self.collectionView.contentOffset = CGPointMake(self.collectionView.jw_width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint nowPoint = scrollView.contentOffset;
    if (nowPoint.x > (self.datas.count - 1) * scrollView.jw_width) {
        [scrollView setContentOffset:(CGPointZero) animated:NO];
    }
    if (nowPoint.x < 0) {
        [scrollView setContentOffset:(CGPointMake((self.datas.count - 1) * scrollView.jw_width, 0)) animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger page = scrollView.contentOffset.x / scrollView.jw_width;
    NSInteger index = 0;
    if (page == self.datas.count || page == 0) {
        index = self.datas.count - 1;
    }else{
        index = page - 1;
    }
    if (self.didScrollCurrentIndex) {
        self.didScrollCurrentIndex(index);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellName = [self.delegate jw_carouselView:self cellNameForItemAtIndex:indexPath.item];
    JwCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    cell.data = self.datas[indexPath.item];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectAction) {
        NSInteger index = indexPath.item - 1;
        if (index < 0) {
            index = 0;
        }
        self.didSelectAction(index);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.jw_width, collectionView.jw_height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
