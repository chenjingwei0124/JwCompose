//
//  JwStarsProgress.m
//  ZeroBuy
//
//  Created by 陈警卫 on 2019/1/10.
//  Copyright © 2019年 namei. All rights reserved.
//

#import "JwStarsProgress.h"

@interface JwStarsProgress ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *progressView;

@end


@implementation JwStarsProgress

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.jw_width, self.jw_height))];
        self.backView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backView];
        [self.backView addSubview:[self setImageViewWithFrame:self.backView.bounds image:@"stars_empty"]];
        
        self.progressView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 0, self.jw_height))];
        self.progressView.backgroundColor = [UIColor clearColor];
        self.progressView.clipsToBounds = YES;
        [self addSubview:self.progressView];
        [self.progressView addSubview:[self setImageViewWithFrame:self.backView.bounds image:@"stars_full"]];
        
    }
    return self;
}

- (UIImageView *)setImageViewWithFrame:(CGRect)frame image:(NSString *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(frame)];
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:image];
    return imageView;
}

- (void)setStarsProgressWithValue:(CGFloat)value{
    CGRect frame = self.progressView.frame;
    frame.size.width = self.backView.jw_width * value;
    self.progressView.frame = frame;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
