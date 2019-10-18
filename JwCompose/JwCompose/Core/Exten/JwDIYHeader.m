//
//  JwDIYHeader.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/6.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwDIYHeader.h"

@interface JwDIYHeader ()

@property (nonatomic, strong) UILabel *tipL;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong) UIImageView *imgV_0;
@property (nonatomic, strong) UIImageView *imgV_1;
@property (nonatomic, strong) UIImageView *imgV_2;
@property (nonatomic, strong) UIImageView *imgV_3;

@property (nonatomic, strong) UIImageView *bImgV;
@property (nonatomic, strong) UIImageView *rImgV;

@property (nonatomic, strong) CABasicAnimation *rotationAnimation;

@end

@implementation JwDIYHeader

#pragma mark 重写方法
- (void)prepare{
    [super prepare];
    
    self.tipL = [[UILabel alloc] init];
    self.tipL.text = @"拉到顶啦~";
    self.tipL.font = [UIFont systemFontOfSize:15];
    self.tipL.textColor = [UIColor redColor];
    self.tipL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tipL];
    
    self.lineV = [[UIView alloc] init];
    [self addSubview:self.lineV];
    
    self.imgV_0 = [[UIImageView alloc] init];
    [self addSubview:self.imgV_0];
    self.imgV_1 = [[UIImageView alloc] init];
    [self addSubview:self.imgV_1];
    self.imgV_2 = [[UIImageView alloc] init];
    [self addSubview:self.imgV_2];
    self.imgV_3 = [[UIImageView alloc] init];
    [self addSubview:self.imgV_3];
    
    self.bImgV = [[UIImageView alloc] init];
    [self addSubview:self.bImgV];
    self.rImgV = [[UIImageView alloc] init];
    [self addSubview:self.rImgV];
    
    self.imgV_0.image = [UIImage imageNamed:@"loading_down03"];
    self.imgV_1.image = [UIImage imageNamed:@"loading_down02"];
    self.imgV_2.image = [UIImage imageNamed:@"loading_down01"];
    self.imgV_3.image = [UIImage imageNamed:@"loading_down00"];
    
    self.bImgV.image = [UIImage imageNamed:@"loading_bg"];
    self.rImgV.image = [UIImage imageNamed:@"loading_rbg"];
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    [super placeSubviews];
    
    //设置控件的高度
    self.mj_h = 90 * kJwScale_Width;
    
    CGFloat imgW = self.jw_width * 2/5;
    CGFloat imgH = imgW * 52/304;
    CGFloat bImgH = 30 * kJwScale_Width;
    
    CGFloat space = self.jw_height - imgH - bImgH + 10;
    CGFloat totalH = 20 + space * 4 + imgH * 3;
    
    
    self.tipL.frame = CGRectMake(0, -totalH, self.jw_width, 20);
    
    self.lineV.frame = CGRectMake(self.jw_width/2 - 0.5, self.tipL.jw_bottom, 1, totalH - self.tipL.jw_height + self.jw_height - bImgH);
    [self drawDashLine:self.lineV lineLength:2 lineSpacing:1 lineColor:[UIColor redColor]];
    
    self.imgV_0.frame = CGRectMake(0, self.tipL.jw_bottom + space, imgW, imgH);
    self.imgV_0.jw_centerX = self.lineV.jw_centerX;
    
    self.imgV_1.frame = CGRectMake(0, self.imgV_0.jw_bottom + space, imgW, imgH);
    self.imgV_1.jw_centerX = self.lineV.jw_centerX;
    
    self.imgV_2.frame = CGRectMake(0, self.imgV_1.jw_bottom + space, imgW, imgH);
    self.imgV_2.jw_centerX = self.lineV.jw_centerX;
    
    self.imgV_3.frame = CGRectMake(0, self.imgV_2.jw_bottom + space, imgW, imgH);
    self.imgV_3.jw_centerX = self.lineV.jw_centerX;
    
    self.bImgV.frame = CGRectMake(0, self.jw_height - bImgH - 5, bImgH, bImgH);
    self.bImgV.jw_centerX = self.jw_centerX;

    self.rImgV.frame = CGRectMake(5*kJwScale_Width, 5*kJwScale_Width, 20*kJwScale_Width, 20*kJwScale_Width);
    [self.bImgV addSubview:self.rImgV];
    
}

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    [lineView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame), CGRectGetHeight(lineView.frame)/2.0)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.rImgV.layer removeAllAnimations];
            break;
        case MJRefreshStatePulling:
           
            break;
        case MJRefreshStateRefreshing:
            [self startAnimation];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
}

- (void)startAnimation {
    self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    self.rotationAnimation.duration = 0.5;
    self.rotationAnimation.cumulative = YES;
    self.rotationAnimation.repeatCount = 1000;
    [self.rImgV.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
}


@end
