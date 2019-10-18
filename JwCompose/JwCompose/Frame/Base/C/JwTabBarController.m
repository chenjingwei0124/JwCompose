//
//  JwTabBarController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwTabBarController.h"

#import "JwHomeController.h"
#import "JwFindController.h"
#import "JwMineController.h"

@interface JwTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) JwNavigationController *homeNC;
@property (nonatomic, strong) JwNavigationController *findNC;
@property (nonatomic, strong) JwNavigationController *mineNC;

@end

@implementation JwTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)setupView{
    
    self.homeNC = [self navigationWithRootViewController:[[JwHomeController alloc] init]
                                   tabBarItemImageString:@"tab_collection"
                           tabBarItemSelectedImageString:@"tab_collectioned"
                                                   title:@"发现"];
    self.findNC = [self navigationWithRootViewController:[[JwFindController alloc] init]
                                   tabBarItemImageString:@"tab_discover"
                           tabBarItemSelectedImageString:@"tab_discovered"
                                                   title:@"收藏"];
    self.mineNC = [self navigationWithRootViewController:[[JwMineController alloc] init]
                                   tabBarItemImageString:@"tab_me"
                           tabBarItemSelectedImageString:@"tab_meed"
                                                   title:@"我的"];
    
    self.delegate = self;
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = JwColorHexString(@"#eb3f37");
    self.viewControllers = @[self.homeNC, self.findNC, self.mineNC];
    self.selectedIndex = 2;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //if (viewController == [tabBarController.viewControllers firstObject]) {
    //if (self.selectedViewController == viewController) {
    //}
    //}
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    //if (viewController == [tabBarController.viewControllers objectAtIndex:2]) {
    //    return NO;
    //}
    return YES;
}

/**
 设置导航控制器
 */
- (JwNavigationController *)navigationWithRootViewController:(UIViewController *)controller
                                       tabBarItemImageString:(NSString *)imageString
                               tabBarItemSelectedImageString:(NSString *)selectedImageString
                                                       title:(NSString *)title{
    JwNavigationController *navc = [[JwNavigationController alloc] initWithRootViewController:controller];
    navc.tabBarItem.image = [[UIImage imageNamed:imageString] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    navc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageString] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    //[navc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    //[navc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    
    navc.title = title;
    controller.title = title;
    
    return navc;
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
