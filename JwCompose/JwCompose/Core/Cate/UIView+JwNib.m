//
//  UIView+JwNib.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/2.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "UIView+JwNib.h"

@implementation UIView (JwNib)

+ (instancetype)jw_createViewFromNib{
    return [self jw_createViewFromNibName:NSStringFromClass(self.class)];
}

+ (instancetype)jw_createViewFromNibName:(NSString *)nibName{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nibs firstObject];
}

@end
