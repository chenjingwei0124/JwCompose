//
//  JwRouteJumpController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/24.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwRouteJumpController.h"

@interface JwRouteJumpController ()

@property (weak, nonatomic) IBOutlet UILabel *descL;


@end

@implementation JwRouteJumpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"路由跳转";
    NSString *title = @"跳转参数";
    NSString *scheme = kJwCheckToString(self.jumpModel.params[@"scheme"]);
    if ([scheme isEqualToString:@"1"]) {
        title = @"URL Scheme拉起参数";
    }
    self.descL.text = [NSString stringWithFormat:@"%@\n%@", title, self.jumpModel.params];
    
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
