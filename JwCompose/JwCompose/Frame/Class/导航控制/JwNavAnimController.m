//
//  JwNavAnimController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/25.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwNavAnimController.h"

@interface JwNavAnimController ()

@end

@implementation JwNavAnimController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"导航栏控制";
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)setupView{
    JwButton *btn0 = [JwButton buttonWithType:(UIButtonTypeSystem)];
    btn0.frame = CGRectMake(0, 100, self.view.jw_width, 30);
    [btn0 setTitle:@"显示导航栏" forState:(UIControlStateNormal)];
    [btn0 addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn0];
    
    JwButton *btn1 = [JwButton buttonWithType:(UIButtonTypeSystem)];
    btn1.frame = CGRectMake(0, btn0.jw_bottom + 20, self.view.jw_width, 30);
    [btn1 setTitle:@"隐藏导航栏" forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
    btn0.jw_index = 0;
    btn1.jw_index = 1;
    
    JwButton *btn2 = [JwButton buttonWithType:(UIButtonTypeSystem)];
    btn2.frame = CGRectMake(0, btn1.jw_bottom + 20, self.view.jw_width, 30);
    [btn2 setTitle:@"浅色导航栏" forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn2];
    
    JwButton *btn3 = [JwButton buttonWithType:(UIButtonTypeSystem)];
    btn3.frame = CGRectMake(0, btn2.jw_bottom + 20, self.view.jw_width, 30);
    [btn3 setTitle:@"深色导航栏" forState:(UIControlStateNormal)];
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn3];
    
    btn2.jw_index = 2;
    btn3.jw_index = 3;
}

- (void)btnAction:(JwButton *)btn{
    JwNavAnimController *vc = [[JwNavAnimController alloc] init];
    if (btn.jw_index == 0) {
        vc.jw_navigationBarStyle = JwNavigationBarShow;
    }else if (btn.jw_index == 1){
        vc.jw_navigationBarStyle = JwNavigationBarHidden;
    }else if (btn.jw_index == 2){
        vc.jw_navigationBarTintColor = [UIColor whiteColor];
    }else if (btn.jw_index == 3){
        vc.jw_navigationBarTintColor = [UIColor redColor];
    }
    [self.navigationController pushViewController:vc animated:YES];
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
