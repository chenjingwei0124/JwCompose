//
//  JwBaseBackController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseBackController.h"

@interface JwBaseBackController ()

@end

@implementation JwBaseBackController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.jw_baseBackImage = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.jw_baseBackImage
                                                                             style:(UIBarButtonItemStyleDone)
                                                                            target:self
                                                                            action:@selector(backBaseAction:)];
}

- (void)backBaseAction:(UIBarButtonItem *)barButton{
    [self.navigationController popViewControllerAnimated:YES];
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
