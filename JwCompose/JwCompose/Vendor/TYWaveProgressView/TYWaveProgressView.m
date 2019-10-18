//
//  TYWaveProgressDemo.m
//  TYWaveProgressDemo
//
//  Created by tanyang on 15/4/14.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYWaveProgressView.h"

@interface TYWaveProgressView ()

@property (nonatomic, weak,readwrite) UIImageView *backgroundImageView;
@property (nonatomic, weak) TYWaterWaveView *waterWaveView;

@end

@implementation TYWaveProgressView{
    UIImageView *maskView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self addBackgroudImageView];
    [self addWaterWaveView];
}

- (void)addBackgroudImageView{
    UIImageView *backgroundImageView = [[UIImageView alloc]init];
    [self addSubview:backgroundImageView];
    _backgroundImageView = backgroundImageView;
    
    maskView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:maskView];
}

- (void)addWaterWaveView{
    TYWaterWaveView *waterWaveView = [[TYWaterWaveView alloc]init];
    [self addSubview:waterWaveView];
    _waterWaveView = waterWaveView;
}



- (void)startWave{
    if (self.state == WaterWaveStateRunning) return;
    
    [_waterWaveView startWave];
    maskView.image = _backgroundImageView.image;
    self.layer.mask = maskView.layer;
}

- (void)resetWave{
    [_waterWaveView reset];
}

- (void)stopWave{
    [_waterWaveView stopWave];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _waterWaveView.frame = self.bounds;
    _backgroundImageView.frame = _waterWaveView.frame;
}

- (WaterWaveState)state{
    return self.waterWaveView.state;
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(70, 60);
}


@end
