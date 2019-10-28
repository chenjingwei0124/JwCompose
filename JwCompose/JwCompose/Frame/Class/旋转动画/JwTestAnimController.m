//
//  JwTestAnimController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/28.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwTestAnimController.h"

@interface JwTestAnimController ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *rotateView;
@property (nonatomic, assign) CGFloat angle;

@property (nonatomic, strong) UIView *moduPanView;
@property (nonatomic, strong) UIView *modu0View;


@end

@implementation JwTestAnimController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    [self setupAnim];
}

- (void)setupView{
    self.backView = [[UIView alloc] initWithFrame:(CGRectMake(50, 150, self.view.jw_width - 100, self.view.jw_width - 100))];
    self.backView.backgroundColor = JwColorRandom;
    [self.view addSubview:self.backView];
    
    self.rotateView = [[UIView alloc] initWithFrame:(self.backView.bounds)];
    self.rotateView.backgroundColor = JwColorRandom;
    self.rotateView.layer.cornerRadius = self.rotateView.jw_width * 0.5;
    [self.backView addSubview:self.rotateView];
    
    self.modu0View = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 40, 40))];
    self.modu0View.backgroundColor = JwColorRandom;
    self.modu0View.jw_centerX = self.rotateView.jw_width * 0.5;
    self.modu0View.jw_y = 0;
    self.modu0View.layer.cornerRadius = self.modu0View.jw_width * 0.5;
    self.modu0View.layer.masksToBounds = YES;
    [self.rotateView addSubview:self.modu0View];
    
    self.modu0View.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan0 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.modu0View addGestureRecognizer:pan0];
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    NSLog(@"%ld", (long)pan.state);
    CGRect rect = [self.rotateView convertRect:pan.view.frame toView:self.view];
    NSLog(@"%f--%f--%f--%f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        self.moduPanView = [[UIView alloc] initWithFrame:(CGRectMake(rect.origin.x, rect.origin.y, 40, 40))];
        self.moduPanView.backgroundColor = self.modu0View.backgroundColor;
        self.moduPanView.layer.cornerRadius = self.moduPanView.jw_width * 0.5;
        self.moduPanView.layer.masksToBounds = YES;
        [self.view addSubview:self.moduPanView];
        
    }else if (pan.state == UIGestureRecognizerStateChanged){

            CGPoint translation = [pan translationInView:self.view];
            self.moduPanView.center = CGPointMake(self.moduPanView.center.x + translation.x, self.moduPanView.center.y + translation.y);
            [pan setTranslation:CGPointZero inView:self.view];
        
    }else if (pan.state == UIGestureRecognizerStateEnded){
        [self.moduPanView removeFromSuperview];
    }
}

- (void)setupAnim{
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.rotateView.transform = endAngle;
    } completion:^(BOOL finished) {
        self.angle += 5;
        [self setupAnim];
    }];
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
