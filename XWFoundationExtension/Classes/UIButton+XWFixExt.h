//
//  UIButton+XWFixExt.h
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XWFixExt)

/**
 Button响应
 */
@property (nonatomic, copy) void (^touchDownBlock)(__weak UIButton *button);
@property (nonatomic, copy) void (^touchDownRepeatBlock)(__weak UIButton *button);
@property (nonatomic, copy) void (^touchUpInsideBlock)(__weak UIButton *button);

@end

NS_ASSUME_NONNULL_END
