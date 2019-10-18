//
//  JwMenuView.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/5.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwMenuItem.h"

@class JwMenuView;

typedef NS_ENUM(NSInteger, JwMenuViewScrollDirection) {
    /** 竖直 */
    JwMenuViewScrollDirectionVertical,
    /** 水平 */
    JwMenuViewScrollDirectionHorizontal
};

@protocol JwMenuViewDelegate<NSObject>

/** menuItem点击事件代理 */
- (void)menuView:(JwMenuView *)menuView didiSelectAtIndex:(NSInteger)index data:(id)data;

@end

@protocol JwMenuViewDataSource<NSObject>

/**
 menuItem 返回控件代理
 */
- (JwMenuItem *)menuView:(JwMenuView *)menuView itemForIndex:(NSInteger)index;

@end

@interface JwMenuView : UIView

@property (nonatomic, weak) id <JwMenuViewDataSource> dataSource;
@property (nonatomic, weak) id <JwMenuViewDelegate> delegate;

/** 方向 */
@property (nonatomic, assign) JwMenuViewScrollDirection scrollDirection;
/**
 滚动条视图
 如有自定义功能 可在menuView初始化后进行progressView自定
 */
@property (nonatomic, strong) UIView *progressView;
/** 是否显示滚动条 */
@property (nonatomic, assign) BOOL isShowProgress;
/**
 滚动条颜色
 子类menuItem 需要设置背景为透明可以显示
 */
@property (nonatomic, strong) UIColor *progressColor;
/**
 滚动条宽度 如果传入值 则认为滚动条定长 仅水平时有效
 默认 水平 则为menuItem宽度 竖直 则为menuItem高度
 */
@property (nonatomic, assign) CGFloat progressValue;
/** 滚动条边距 */
@property (nonatomic, assign) UIEdgeInsets progressEdge;
/**
 item两端间隔
 水平时 取值 left right
 竖直时 取值 top bottom
 */
@property (nonatomic, assign) UIEdgeInsets itemEdge;
/** item中间间隔 */
@property (nonatomic, assign) CGFloat itemSpace;
/** 是否可以滚动 */
@property (nonatomic, assign) BOOL isScroll;
/** 是否显示间隔线 默认不显示 显示宽度或高度 默认值为1 */
@property (nonatomic, assign) BOOL isShowSpaceLine;
/** 间隔线颜色 */
@property (nonatomic, strong) UIColor *spaceLineColor;
/** 平均分值 水平为宽度 竖直为高度 */
@property (nonatomic, assign) CGFloat averageItemValue;
/**
 是否均分menuItem
 默认不均分 子类item设置数据时 自计算宽度或高度
 YES时 averageItemValue不传或为0 时 averageItemValue为menuView宽度或高度均分值
 (menuView宽度或高度 - 间隔值 - 间隔线值)/count
 */
@property (nonatomic, assign) BOOL isAverageItem;
/** 数据源 */
@property (nonatomic, strong) NSArray *datas;

- (void)reloadData;

- (void)setValueWithOffset:(CGFloat)offset width:(CGFloat)width count:(NSInteger)count;

- (void)setValue:(CGFloat)value fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end
