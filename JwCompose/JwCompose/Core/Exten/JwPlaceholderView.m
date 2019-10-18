//
//  JwPlaceholderView.m
//  lushu
//
//  Created by 陈警卫 on 2019/7/26.
//  Copyright © 2019年 陈警卫. All rights reserved.
//

#import "JwPlaceholderView.h"

@interface JwPlaceholderView ()

@end

@implementation JwPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JwColorHexString(@"fafafa");
        self.jw_imageView = [[UIImageView alloc] init];
        self.jw_imageView.image = [UIImage imageNamed:@"image_placeholder"];
        [self addSubview:self.jw_imageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.jw_width * 0.6;
    CGFloat h = self.jw_height * 0.6;
    CGFloat v = w > h ? h : w;
    self.jw_imageView.frame = CGRectMake(0, 0, v, v);
    self.jw_imageView.center = self.center;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
