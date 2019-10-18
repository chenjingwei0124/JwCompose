//
//  JwMenuTextItem.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/19.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwMenuTextItem.h"

@interface JwMenuTextItem ()

@property (nonatomic, strong) UILabel *titleL;

@end

@implementation JwMenuTextItem

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.titleL = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 0, 0))];
        self.titleL.font = [UIFont systemFontOfSize:13];
        self.titleL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleL];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleL.frame = CGRectMake(0, 0, self.jw_width, self.jw_height);
}

- (void)setRate:(CGFloat)rate{
    [super setRate:rate];
    if (rate < 0.0 || rate > 1.0) {
        return;
    }
    self.titleL.textColor = [UIColor jw_colorWithFormColor:[UIColor blackColor] toColor:[UIColor redColor] value:rate];
}

- (void)setData:(id)data{
    [super setData:data];
    
    NSString *title = data;
    self.titleL.text = title;
    [self.titleL sizeToFit];
    
    CGRect rect = self.titleL.frame;
    rect.size.width = rect.size.width + 5;
    self.frame = rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
