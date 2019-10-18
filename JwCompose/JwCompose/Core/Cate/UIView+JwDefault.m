//
//  UIView+JwDefault.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/14.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UIView+JwDefault.h"
#import "UIView+JwCate.h"
#import <objc/runtime.h>

@implementation UIView (JwDefault)


- (void (^)(UIView *))jw_didShowBackAction{
    return objc_getAssociatedObject(self, @selector(jw_didShowBackAction));
}

- (void)setJw_didShowBackAction:(void (^)(UIView *))jw_didShowBackAction{
    objc_setAssociatedObject(self, @selector(jw_didShowBackAction), jw_didShowBackAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIView *)jw_showBackView{
    return objc_getAssociatedObject(self, @selector(jw_showBackView));
}

- (void)setJw_showBackView:(UIView *)jw_showBackView{
    objc_setAssociatedObject(self, @selector(jw_showBackView), jw_showBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jw_setupShowBackViewWithState:(Jw_ViewState)state{
    NSString *text = nil;
    NSString *button = @"重新加载";
    switch (state) {
        case Jw_ViewStateError:
            text = @"数据加载失败～";
            break;
        case Jw_ViewStateNothing:
            text = @"暂时没有数据喔～";
            button = nil;
            break;
            
        default:
            text = @"暂时没有数据喔～";
            break;
    }
    [self jw_setupShowBackViewWithImage:@"blank_tip" text:text button:button];
}

- (void)jw_setupShowBackViewWithImage:(NSString *)image text:(NSString *)text button:(NSString *)button{
    
    if ([self.subviews containsObject:self.jw_showBackView]) {
        return;
    }
    self.jw_showBackView = [[UIView alloc] init];
    self.jw_showBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.jw_showBackView];
    [self.jw_showBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
    }];
    
    [self.jw_showBackView layoutIfNeeded];
    CGRect frame = self.jw_showBackView.bounds;
    CGFloat sety = frame.size.height * 0.2;
    if (image) {
        UIImageView *imageView = [self setupShowViewImageView:image];
        imageView.jw_y = sety;
        [self.jw_showBackView addSubview:imageView];
        sety = imageView.jw_bottom + 10;
    }
    if (text) {
        UILabel *label = [self setupShowViewLabel:text];
        label.jw_y = sety;
        [self.jw_showBackView addSubview:label];
        sety = label.jw_bottom + 10;
    }
    if (button) {
        UIButton *btn = [self setupShowViewButton:button];
        btn.jw_y = sety;
        [self.jw_showBackView addSubview:btn];
    }
}

- (void)jw_removeShowBackView{
    if (self.jw_showBackView) {
        [self.jw_showBackView removeFromSuperview];
    }
}

- (UIImageView *)setupShowViewImageView:(NSString *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    CGSize size = imageView.image.size;
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    imageView.jw_centerX = self.jw_showBackView.jw_width * 0.5;
    return imageView;
}

- (UILabel *)setupShowViewLabel:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, self.jw_showBackView.jw_width - 50, 0))];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.textColor = JwColorHexString(@"#8F8F8F");
    label.text = text;
    [label sizeToFit];
    label.jw_centerX = self.jw_showBackView.jw_width * 0.5;
    return label;
}

- (UIButton *)setupShowViewButton:(NSString *)btn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 100, 35);
    button.jw_centerX = self.jw_showBackView.jw_width * 0.5;
    [button setTitle:btn forState:UIControlStateNormal];
    [button setTitleColor:JwColorHexString(@"#EB3F37") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)showButtonAction:(UIButton *)button{
    if (self.jw_didShowBackAction) {
        self.jw_didShowBackAction(self);
    }
}

@end
