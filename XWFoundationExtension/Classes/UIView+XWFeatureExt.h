//
//  UIView+XWFeatureExt.h
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XWFeatureExt)

/**
 设置部分圆角(绝对布局)
 
 @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 @param radii   需要设置的圆角半径
 */
- (void)xw_addRoundedCorners:(UIRectCorner)corners
                              radius:(CGFloat)radii;

/**
 从视图树中返回指定类型实例子视图数组，如果子视图没有指定的类型，则返回空数组
 
 @param cls 指定Class
 @return 子视图数组
 */
- (NSArray *)xw_subviewsWithTargetClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
