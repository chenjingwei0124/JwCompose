//
//  TYWaveProgressDemo.h
//  TYWaveProgressDemo
//
//  Created by tanyang on 15/4/14.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//  自定义外观view

#import <UIKit/UIKit.h>
#import "TYWaterWaveView.h"

@interface TYWaveProgressView : UIView

@property (nonatomic, weak,readonly) UIImageView *backgroundImageView;
@property (nonatomic, assign) WaterWaveState state;

- (void)startWave;

- (void)resetWave;

- (void)stopWave;

@end
