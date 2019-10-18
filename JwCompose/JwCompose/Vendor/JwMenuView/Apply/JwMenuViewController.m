//
//  JwMenuViewController.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/19.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwMenuViewController.h"
#import "JwMenuView.h"
#import "JwMenuViewCell.h"
#import "JwMenuTextItem.h"

@interface JwMenuViewController ()<JwMenuViewDelegate, JwMenuViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) JwMenuView *menuView;
@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation JwMenuViewController

- (void)loadView{
    [super loadView];
    [self setupView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.menuView.datas = @[@"1", @"12", @"123", @"1234", @"12345", @"123456", @"1234567", @"1", @"12", @"123", @"1234", @"12345", @"123456", @"1234567"];
    [self.menuView reloadData];
    [self.menuView setValue:1 fromIndex:0 toIndex:0];
    [self.collectView reloadData];
}

- (void)setupView{
    self.menuView = [[JwMenuView alloc] initWithFrame:(CGRectMake(0, 0, self.view.jw_width, 40))];
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    self.menuView.scrollDirection = JwMenuViewScrollDirectionHorizontal;
    self.menuView.isScroll = YES;
    self.menuView.isAverageItem = NO;
    self.menuView.isShowSpaceLine = NO;
    self.menuView.itemEdge = UIEdgeInsetsMake(0, 10, 0, 10);
    self.menuView.itemSpace = 10;
    self.menuView.isShowProgress = YES;
    self.menuView.progressColor = [UIColor redColor];
    self.menuView.progressValue = 0;
    self.menuView.progressEdge = UIEdgeInsetsMake(35, 2, 3, 2);
    self.menuView.progressView.layer.cornerRadius = 1;
    self.menuView.progressView.layer.masksToBounds = YES;
    [self.view addSubview:self.menuView];
    [self.menuView reloadData];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, self.menuView.jw_bottom, self.view.jw_width, self.view.jw_height - self.menuView.jw_height)) collectionViewLayout:layout];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.pagingEnabled = YES;
    self.collectView.bounces = NO;
    self.collectView.showsVerticalScrollIndicator = NO;
    self.collectView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectView];
    
    [self.collectView registerClass:[JwMenuViewCell class] forCellWithReuseIdentifier:@"JwMenuViewCell"];
    [self.menuView setValue:1 fromIndex:0 toIndex:0];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectView.frame = CGRectMake(0, self.menuView.jw_bottom, self.view.jw_width, self.view.jw_height - self.menuView.jw_height);
}

- (void)menuView:(JwMenuView *)menuView didiSelectAtIndex:(NSInteger)index data:(id)data{
    [self.collectView setContentOffset:(CGPointMake(index * self.collectView.jw_width, 0)) animated:YES];
}

- (JwMenuItem *)menuView:(JwMenuView *)menuView itemForIndex:(NSInteger)index{
    JwMenuTextItem *item = [[JwMenuTextItem alloc] init];
    return item;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.collectView) {
        CGFloat offsetx = scrollView.contentOffset.x;
        [self.menuView setValueWithOffset:offsetx width:scrollView.jw_width count:self.menuView.datas.count];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menuView.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JwMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JwMenuViewCell" forIndexPath:indexPath];
    cell.backgroundColor = JwColorRandom;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.jw_width, collectionView.jw_height);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
