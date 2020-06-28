//
//  JwBaseTabBar.m
//  JwPart
//
//  Created by 陈警卫 on 2020/6/1.
//  Copyright © 2020 陈警卫. All rights reserved.
//

#import "JwBaseTabBar.h"

@interface JwBaseTabBar ()

@property (strong, nonatomic) UIButton *midB;

@end

@implementation JwBaseTabBar

- (instancetype)init{
    if (self = [super init]){
        [self initView];
    }
    return self;
}

- (void)initView{
    UIView *backView = [[UIView alloc] init];
    [self insertSubview:backView atIndex:0];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-33);
        make.left.right.offset(0);
        make.height.mas_equalTo(kJwScreenTabBottomBarHeight + 33);
    }];
    
    //加载图片
    UIImage *image = [UIImage imageNamed:@"tabbar"];
    //设置不拉伸区域
    CGFloat top = 0;
    CGFloat left = 0;
    CGFloat bottom = 0;
    CGFloat right = 0;
    //拉伸图片
    UIImage *bgImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    
    UIImageView *backImgV = [[UIImageView alloc] initWithImage:bgImage];
    backImgV.contentMode = UIViewContentModeScaleAspectFill;
    [backView addSubview:backImgV];
    [backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-kJwScreenBottomHeight);
    }];
    
    [self addSubview:self.midB];
    [self.midB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(45);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(backView.mas_top).offset(16.5);
    }];
    [self layoutIfNeeded];
    
    //去除顶部横线
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:[UIImage new]];

}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.midB convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.midB.bounds, tempPoint)){
            //返回按钮
            return self.midB;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}

- (void)midBAction {
    if (self.didMidAction) {
        self.didMidAction();
    }
}

- (UIButton *)midB{
    if (!_midB) {
        _midB = [UIButton buttonWithType:UIButtonTypeCustom];
        _midB.adjustsImageWhenHighlighted = false;
        [_midB setImage:[UIImage imageNamed:@"tab_mid"] forState:UIControlStateNormal];
        [_midB addTarget:self action:@selector(midBAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _midB;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
