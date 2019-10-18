//
//  JwMenuItem.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/5.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 基类控件
 继承此控件 实现自定义功能
 重写init布局 复用rate data的Set方法进行自定
 */

@interface JwMenuItem : UIView

@property (nonatomic, assign) NSInteger index;
/** 设置变化值0~1 */
@property (nonatomic, assign) CGFloat rate;
/** 数据 */
@property (nonatomic, strong) id data;

@end
