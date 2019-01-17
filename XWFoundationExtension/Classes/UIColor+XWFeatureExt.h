//
//  UIColor+XWFeatureExt.h
//  XWFoundationExtension
//
//  Created by tianxuewei on 2019/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (XWFeatureExt)

/**
 生成随机色
 */
+ (UIColor *)xw_randomColor;

/**
 16进制颜色(html颜色值)字符串转为UIColor
 支持6位或8位色值
 */
+ (UIColor *)xw_colorWithHex:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
