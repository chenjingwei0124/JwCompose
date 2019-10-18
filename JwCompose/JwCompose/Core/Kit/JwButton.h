//
//  JwButton.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/8/30.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JwButton : UIButton

@property (nonatomic, strong) NSString *jw_identifier;
@property (nonatomic, assign) NSInteger jw_index;

@end

NS_ASSUME_NONNULL_END
