//
//  UIView+JwNib.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/2.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JwNib)

+ (instancetype)jw_createViewFromNib;
+ (instancetype)jw_createViewFromNibName:(NSString *)nibName;

@end

NS_ASSUME_NONNULL_END
