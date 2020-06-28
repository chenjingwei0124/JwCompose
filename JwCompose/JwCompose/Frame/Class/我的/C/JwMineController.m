//
//  JwMineController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwMineController.h"
#import "JwMineCell.h"
#import "JwMineModel.h"
#import <LBXScanNative.h>

@interface JwMineController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation JwMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self setupTest];
    DLog(@"%@", kJwRootTabBarVC);
    DLog(@"%@", kJwRootNavigationVC);
    
    [self setupView];
    [self setupData];
}

- (void)setupTest{
    // 红色View
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    // 蓝色View
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    // 黄色View
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    // ---红色View--- 添加约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-80);
        make.height.equalTo([NSNumber numberWithInt:50]);
    }];
    // ---蓝色View--- 添加约束
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(redView.mas_right).with.offset(40);
        make.bottom.width.height.mas_equalTo(redView);
    }];
    
    // ---黄色View--- 添加约束
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(blueView.mas_right).with.offset(40);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.width.height.mas_equalTo(redView);
        
        // 优先级设置为250，最高1000（默认）
        make.left.mas_equalTo(redView.mas_right).with.offset(20).priority(250);
    }];
}

- (void)setupView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectZero) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kJwScreenNavBatBarHeight);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-kJwScreenTabBottomBarHeight);
        make.right.mas_equalTo(0);
    }];
}

- (void)setupData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mine" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(kNilOptions) error:nil];
    self.datas = [NSMutableArray arrayWithArray:[JwMineModel arrayOfModelsFromDictionaries:dic[@"data"] error:nil]];
    [JwProjectModel registerCollectionView:self.collectionView cellClassWithDatas:self.datas];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    JwProjectModel *projectModel = self.datas[section];
    return projectModel.jw_itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JwProjectModel *projectModel = self.datas[indexPath.section];
    JwMineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:projectModel.jw_cellName forIndexPath:indexPath];
    JwMineModel *model = projectModel.jw_itemDatas[indexPath.item];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JwProjectModel *projectModel = self.datas[indexPath.section];
    JwMineModel *model = projectModel.jw_itemDatas[indexPath.item];
    
    if ([model.Id isEqualToString:@"0"]) {
        [self showLoading];
    } else if ([model.Id isEqualToString:@"4"]) {
        [self showScreenshot];
    } else if ([model.Id isEqualToString:@"6"]) {
        NSArray *tArr = @[];
        DLog(@"%@", tArr[1]);
    }
    else {
        /**
         通过数据model来进行页面跳转和参数传递
         数据路由来源于JwJumpRoute.plist文件
         */
        JwJumpModel *jumpModel = [[JwJumpModel alloc] init];
        jumpModel.type = model.Id;
        [JwJumpHelper jumpHelperWithJumpModel:jumpModel];
    }
    
    /**
    if ([model.Id isEqualToString:@"1"]){
        JwNavAnimController *vc = [[JwNavAnimController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.Id isEqualToString:@"2"]){
        JwMenuViewController *vc = [[JwMenuViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.Id isEqualToString:@"3"]){
        
    }
     */
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    JwProjectModel *projectModel = self.datas[indexPath.section];
    JwMineModel *model = projectModel.jw_itemDatas[indexPath.item];
    return model.jw_cellSize;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    JwProjectModel *projectModel = self.datas[section];
    return projectModel.jw_edgeInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    JwProjectModel *projectModel = self.datas[section];
    return projectModel.jw_minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    JwProjectModel *projectModel = self.datas[section];
    return projectModel.jw_minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

/** 加载Loading */
- (void)showLoading{
    id hud = [JwProgressHelper showProgressAnimate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

/** 显示截图 */
- (void)showScreenshot{
    Weak(self);
    [JwScreenshot showScreenshotComplete:^(UIImage * _Nonnull image) {
        [wself saveScreenshotWithImage:image];
    }];
}

/** 保存拼接截图 */
- (void)saveScreenshotWithImage:(UIImage *)image{
    CGSize screenSize = kJwScreenSize;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.size = CGSizeMake(screenSize.width, screenSize.height + 150);
    
    UIImageView *ssImageView = [[UIImageView alloc] initWithImage:image];
    ssImageView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    [backView addSubview:ssImageView];
    
    CGSize qrSize = CGSizeMake(120, 120);
    NSString *qrStr = @"jw.compose://data?scheme=1&type=3&id=0";
    UIImage *qrImage = [LBXScanNative createQRWithString:qrStr QRSize:qrSize];
    UIImageView *qrImageView = [[UIImageView alloc] initWithImage:qrImage];
    qrImageView.frame = CGRectMake(0, ssImageView.jw_bottom, qrSize.width, qrSize.height);
    qrImageView.jw_centerX = backView.jw_width * 0.5;
    [backView addSubview:qrImageView];
    
    UILabel *descL = [[UILabel alloc] initWithFrame:(CGRectMake(0, qrImageView.jw_bottom, backView.jw_width, 30))];
    descL.font = [UIFont systemFontOfSize:13];
    descL.textAlignment = NSTextAlignmentCenter;
    descL.textColor = JwColorRandom;
    descL.numberOfLines = 0;
    descL.text = @"使用iPhone相机扫描此二维码拉起APP";
    [backView addSubview:descL];
    
    UIImage *saveImage = [UIImage jw_imageWithUIView:backView];
    JwSavedPhotos *sp = [[JwSavedPhotos alloc] init];
    [sp jw_setupSavePhotos:@[saveImage]];
    sp.didDoneOver = ^{
        [JwProgressHelper showText:@"拼接截图已保存相册"];
    };
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
