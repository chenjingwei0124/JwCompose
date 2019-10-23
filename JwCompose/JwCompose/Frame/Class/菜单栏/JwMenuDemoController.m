//
//  JwMenuDemoController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/23.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwMenuDemoController.h"
#import "JwMenuViewController.h"

@interface JwMenuDemoController ()

@end

@implementation JwMenuDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"菜单栏使用";
    
    JwMenuViewController *vc = [[JwMenuViewController alloc] init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, kJwScreenNavBatBarHeight, self.view.jw_width, self.view.jw_height - kJwScreenNavBatBarHeight);
    [self.view addSubview:vc.view];
    
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
