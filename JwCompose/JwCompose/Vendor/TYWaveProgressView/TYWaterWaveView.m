//
//  TYWaterWaveView.m
//  TYWaveProgressDemo
//
//  Created by tanyang on 15/4/14.
//  Copyright (c) 2015 tanyang. All rights reserved.
//
#import "TYWaterWaveView.h"

#define kScale 0.5

@interface TYWaterWaveView ()

@property (nonatomic, strong) CADisplayLink *waveDisplaylink;

@property (nonatomic, strong) CAShapeLayer  *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer  *secondWaveLayer;

@end

@implementation TYWaterWaveView{
    
    CGFloat waveAmplitude;      // 波纹振幅
    CGFloat waveCycle;          // 波纹周期
    CGFloat waveSpeed;          // 波纹速度
    CGFloat waveGrowth;         // 波纹上升速度
    
    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;           // 波浪x位移
    CGFloat currentWavePointY; // 当前波浪上市高度Y（高度从大到小 坐标系向下增长）
    
    float variable;            //可变参数 更加真实 模拟波纹
    BOOL increase;             // 增减变化
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        [self setUp];
    }
    return self;
}


- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    waterWaveHeight = self.frame.size.height/2;
    waterWaveWidth  = self.frame.size.width;
    if (waterWaveWidth > 0) {
        waveCycle =  1.29 * M_PI / waterWaveWidth;
    }
    if (currentWavePointY <= 0) {
        currentWavePointY = self.frame.size.height;
    }
}

- (void)setUp{
    waterWaveHeight = self.frame.size.height/2;
    waterWaveWidth  = self.frame.size.width;
    _firstWaveColor = JwColorHexAString(@"#ff9343", 1);
    _secondWaveColor = JwColorHexAString(@"#ff9343", 0.6);
    
    waveGrowth = 0.5;
    waveSpeed = 0.4/M_PI;
    
    [self resetProperty];
}

- (void)resetProperty{
    currentWavePointY = self.frame.size.height;
    variable = 1.6 * kScale;
    increase = NO;
    offsetX = 0;
}

- (void)setFirstWaveColor:(UIColor *)firstWaveColor{
    _firstWaveColor = firstWaveColor;
    _firstWaveLayer.fillColor = firstWaveColor.CGColor;
}

- (void)setSecondWaveColor:(UIColor *)secondWaveColor{
    _secondWaveColor = secondWaveColor;
    _secondWaveLayer.fillColor = secondWaveColor.CGColor;
}

- (void)setPercent:(CGFloat)percent{
    _percent = percent;
    [self resetProperty];
}

-(void)startWave{
    if (self.state == WaterWaveStateRunning) return;
    [self resetProperty];
    
    if (_firstWaveLayer == nil) {
        // 创建第一个波浪Layer
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (_secondWaveLayer == nil) {
        // 创建第二个波浪Layer
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
        [self.layer addSublayer:_secondWaveLayer];
    }
    if (_waveDisplaylink) {
        [self stopWave];
    }
    if (_waveDisplaylink) return;
    // 启动定时调用
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)reset{
    [self stopWave];
    [self resetProperty];
    
    [_firstWaveLayer removeFromSuperlayer];
    _firstWaveLayer = nil;
    [_secondWaveLayer removeFromSuperlayer];
    _secondWaveLayer = nil;
    
    self.state = WaterWaveStateStop;
}

- (void)animateWave{
    if (increase) {
        variable += 0.01;
    }else{
        variable -= 0.01;
    }
    
    if (variable<=1) {
        increase = YES;
    }
    
    if (variable>=1.6) {
        increase = NO;
    }
    
    waveAmplitude = variable*4;
}

- (void)getCurrentWave:(CADisplayLink *)displayLink{
    
    self.state = WaterWaveStateRunning;
    [self animateWave];
    if (currentWavePointY <= -10 ) {
        currentWavePointY = waterWaveHeight * 2;
    }
    // 波浪高度未到指定高度 继续上涨
    currentWavePointY -= waveGrowth;
    
    // 波浪位移
    offsetX += waveSpeed;
    
    [self setCurrentFirstWaveLayerPath];
    [self setCurrentSecondWaveLayerPath];
}

- (void)setCurrentFirstWaveLayerPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = waveAmplitude * sin(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

- (void)setCurrentSecondWaveLayerPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 余弦波浪公式
        y = waveAmplitude * cos(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _secondWaveLayer.path = path;
    CGPathRelease(path);
}

- (void)stopWave{
    
    if (self.state == WaterWaveStateStop) return;
    [_waveDisplaylink invalidate];
    _waveDisplaylink = nil;
    
    self.state = WaterWaveStateStop;
}

- (void)dealloc{
    [self reset];
}

@end
