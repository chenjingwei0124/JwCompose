//
//  JwBaseViewController.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JwNavigationBarStyle) {
    JwNavigationBarDefault = 0,
    JwNavigationBarShow = 1,
    JwNavigationBarHidden = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface JwBaseViewController : UIViewController

@property (nonatomic, assign) JwNavigationBarStyle jw_navigationBarStyle;

@end

NS_ASSUME_NONNULL_END