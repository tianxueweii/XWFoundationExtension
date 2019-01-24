//
//  UIButton+XWFeatureExt.h
//  Pods
//
//  Created by tianxuewei on 2019/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XWFeatureExt)

/**
 触碰响应
 */
@property (nonatomic, copy) void (^touchDownBlock)(__weak UIButton *button);
/**
 多次触碰响应
 */
@property (nonatomic, copy) void (^touchDownRepeatBlock)(__weak UIButton *button);
/**
 点击响应
 */
@property (nonatomic, copy) void (^touchUpInsideBlock)(__weak UIButton *button);


@end

NS_ASSUME_NONNULL_END
