//
//  JwBaseViewController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseViewController.h"

@interface JwBaseViewController ()

@end

@implementation JwBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.jw_navigationBarStyle == JwNavigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else if (self.jw_navigationBarStyle == JwNavigationBarShow){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else if (self.jw_navigationBarStyle == JwNavigationBarDefault){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    if (self.jw_navigationBarTintColor) {
        self.navigationController.navigationBar.barTintColor = self.jw_navigationBarTintColor;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
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
