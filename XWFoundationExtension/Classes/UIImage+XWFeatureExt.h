//
//  UIImage+XWFeatureExt.h
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//
//  本类所有图片异步绘制方法，均在主线程回调
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XWFeatureExt)

/**
 生成二维码图片
 
 @param string url
 @param imageSize 图片尺寸
 @param red     R
 @param green   G
 @param blue    B
 @return 生成图片实例
 */
+ (UIImage *)xw_qrImageForString:(NSString *)string imageSize:(CGFloat)imageSize red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;


#pragma mark - 绘图
/**
 获取矩形图片

 @param color 颜色
 @param size 尺寸
 @return 图片
 */
+ (UIImage *)xw_imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 异步绘制矩形

 @param color 颜色
 @param size 尺寸
 @param comp 完成块
 */
+ (void)xw_drawImageWithColor:(UIColor *)color size:(CGSize)size completion:(void(^)(UIImage *img))comp;

/**
 绘制圆形图片
 
 @param color 颜色
 @param diam 直径
 
 @return 圆
 */
+ (UIImage *)xw_circleImageWithColor:(UIColor *)color diam:(CGFloat)diam;

/**
 异步绘制圆形图片

 @param color 颜色
 @param diam 直径
 @param comp 完成块
 */
+ (void)xw_drawCircleImageWithColor:(UIColor *)color diam:(CGFloat)diam completion:(void(^)(UIImage *img))comp;


#pragma mark - 文字绘图
/**
 获取指定文字图片
 
 @param str 字符
 @param attributes 富文本
 @param color 颜色
 */
+ (UIImage *)xw_imageWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attributes backgroundColor:(UIColor *)color;

/**
 异步绘制指定文字图片

 @param str 字符
 @param attributes 富文本
 @param color 颜色
 @param comp 完成快
 */
+ (void)xw_drawImageWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attributes backgroundColor:(UIColor *)color completion:(void(^)(UIImage *img))comp;


#pragma mark - 裁剪

/**
 裁剪为圆形图片

 @return 返回新生成的UIImage对象
 */
- (UIImage *)xw_clipCircleImage;

/**
 裁剪图片圆角

 @param corners 选择圆角
 @param radii 圆角半径
 @return 返回新生成的UIImage对象
 */
- (UIImage *)xw_clipBorderWithRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radii;

/**
 异步绘制圆形图片

 @param sourceImage 原图片
 @param comp 完成块
 */
+ (void)xw_clipCircleImage:(UIImage *)sourceImage completion:(void(^)(UIImage *img))comp;

/**
 异步绘制圆角图片

 @param sourceImage 原图片
 @param corners 选择圆角
 @param radii 圆角半径
 @param comp 完成块
 */
+ (void)xw_clipBorderWithImage:(UIImage *)sourceImage roundedCorners:(UIRectCorner)corners radius:(CGFloat)radii completion:(void(^)(UIImage *img))comp;


@end

NS_ASSUME_NONNULL_END
