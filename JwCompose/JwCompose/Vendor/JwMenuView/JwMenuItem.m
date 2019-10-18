//
//  JwMenuItem.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/5.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwMenuItem.h"

@implementation JwMenuItem

- (void)setRate:(CGFloat)rate{
    _rate = rate >= 0.0f ? rate : 0.0f;
    _rate = rate <= 1.0f ? rate : 1.0f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
