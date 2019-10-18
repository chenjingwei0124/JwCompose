//
//  TYWaterWaveView.h
//  TYWaveProgressDemo
//
//  Created by tanyang on 15/4/14.
//  Copyright (c) 2015 tanyang. All rights reserved.
//  核心波浪view

#import <UIKit/UIKit.h>

/**  波浪状态 */
typedef NS_ENUM(NSUInteger, WaterWaveState) {
    WaterWaveStateStop = 0,
    WaterWaveStateRunning
};


@interface TYWaterWaveView : UIView

@property (nonatomic, strong) UIColor *firstWaveColor;    // 第一个波浪颜色
@property (nonatomic, strong) UIColor *secondWaveColor;   // 第二个波浪颜色

@property (nonatomic, assign) CGFloat percent;            // 百分比
@property (nonatomic, assign) WaterWaveState state;

- (void)startWave;
- (void)stopWave;
- (void)reset;

@end
