//
//  JwCarouselView.h
//  ZeroBuy
//
//  Created by 陈警卫 on 2019/1/3.
//  Copyright © 2019年 namei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwCarouselCell.h"

@class JwCarouselView;

@protocol JwCarouselViewDelegate <UICollectionViewDelegate>

- (NSString *)jw_carouselView:(JwCarouselView *)carouselView cellNameForItemAtIndex:(NSInteger)index;

@end

@interface JwCarouselView : UIView
//代理
@property (nonatomic, weak) id <JwCarouselViewDelegate> delegate;
//当前位置
@property (nonatomic, copy) void(^didScrollCurrentIndex)(NSInteger index);
//点击事件
@property (nonatomic, copy) void(^didSelectAction)(NSInteger index);

//数据 --> 最后赋值 刷新
@property (nonatomic, strong) NSArray *datas;
//注册Cell
- (void)registerCellWithName:(NSString *)name isXib:(BOOL)isXib;

@end
