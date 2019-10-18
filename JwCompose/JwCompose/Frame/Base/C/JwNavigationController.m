//
//  JwNavigationController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwNavigationController.h"

@interface JwNavigationController ()

@end

@implementation JwNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.barTintColor = JwColorHexString(@"#eff0f4");
    self.navigationBar.translucent = NO;
    //[self setupNavBar];
    
    //去掉底边阴影线
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupNavBar{
    UIImage *backImage = [UIImage jw_createImageWithColor:JwColorHexString(@"#eff0f4")];
    CGSize navBarSize = self.navigationBar.bounds.size;
    backImage = [UIImage jw_resizedSizeImage:backImage size:navBarSize];
    [self.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
}

/**
 重写PUSH方法
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
