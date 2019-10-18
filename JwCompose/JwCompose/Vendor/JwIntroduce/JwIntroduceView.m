//
//  JwIntroduceView.m
//  ZeroBuy
//
//  Created by 陈警卫 on 2018/9/25.
//  Copyright © 2018年 namei. All rights reserved.
//

#import "JwIntroduceView.h"
#import "JwIntroDefaultCell.h"
#import <TAPageControl.h>

@interface JwIntroduceView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UIImageView *bImg;
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) TAPageControl *pageController;

@end

@implementation JwIntroduceView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    self.bImg = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bImg.image = [UIImage imageNamed:@"intro_b"];
    [self addSubview:self.bImg];
    
    self.datas = @[@"intro_0", @"intro_1", @"intro_2", @"intro_3", @"intro_4"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.jw_width, self.jw_height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.bounces = NO;
    self.collectView.pagingEnabled = YES;
    self.collectView.backgroundColor = [UIColor clearColor];
    self.collectView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectView];
    [self.collectView registerNib:[UINib nibWithNibName:NSStringFromClass([JwIntroDefaultCell class]) bundle:nil] forCellWithReuseIdentifier:@"JwIntroDefaultCell"];
    
    self.pageController = [[TAPageControl alloc] initWithFrame:(CGRectMake(self.jw_width/4.0, self.jw_height - 100, self.jw_width/2.0, 30))];
    self.pageController.numberOfPages = self.datas.count;
    self.pageController.currentPage = 0;
    self.pageController.dotImage = [UIImage imageNamed:@"intro_nosel"];
    self.pageController.currentDotImage = [UIImage imageNamed:@"intro_sel"];
    [self addSubview:self.pageController];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.collectView == scrollView) {
        CGFloat offsetx = scrollView.contentOffset.x;
        if (offsetx > self.collectView.jw_width * (self.datas.count - 2)) {
            self.pageController.hidden = YES;
        }else{
            self.pageController.hidden = NO;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.collectView == scrollView) {
        CGFloat offsetx = scrollView.contentOffset.x;
        [self.pageController setCurrentPage:offsetx / self.collectView.jw_width];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JwIntroDefaultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JwIntroDefaultCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"intro_%ld", (long)indexPath.item]];
    if (indexPath.item == (self.datas.count - 1)) {
        cell.nowB.hidden = NO;
    }else{
        cell.nowB.hidden = YES;
    }
    cell.didNowBAction = ^{
        if (self.didBackAction) {
            self.didBackAction();
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.jw_size;
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
