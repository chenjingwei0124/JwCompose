//
//  JwBaseTabBar.h
//  JwPart
//
//  Created by 陈警卫 on 2020/6/1.
//  Copyright © 2020 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JwBaseTabBar : UITabBar

@property (nonatomic, copy) void(^didMidAction)(void);

@end

NS_ASSUME_NONNULL_END
