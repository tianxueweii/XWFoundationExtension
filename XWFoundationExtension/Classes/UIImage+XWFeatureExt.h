//
//  UIImage+XWFeatureExt.h
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
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

#pragma mark -
/**
 获取颜色图片

 @param color 颜色
 @param size 尺寸
 @return 图片
 */
+ (UIImage *)xw_imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 异步绘制

 @param color 颜色
 @param size 尺寸
 @param comp 完成块
 */
+ (void)xw_drawImageWithColor:(UIColor *)color size:(CGSize)size completion:(void(^)(UIImage *img))comp;

#pragma mark -
/**
 获取指定大小文字图片

 */
+ (UIImage *)xw_imageWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attributes backgroundColor:(UIColor *)color;
/**
 获取指定大小文字图片
 
 @param str 文字
 @param clr 颜色
 @param font 字体
 @param size 大小
 @param comp 完成块
 */
+ (void)xw_drawImageWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attributes backgroundColor:(UIColor *)color completion:(void(^)(UIImage *img))comp;


#pragma mark -
/**
 *  画一条虚线
 *
 *  @param size        大小
 *  @param color       颜色
 *  @param borderWidth 宽度
 *  @param type        类型
 *
 *  @return 虚线图片
 */
//+ (UIImage*)xw_dottedLineWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth Type:(ZbcoreDottedLineType)type;
/**
 裁剪图片为圆形
 
 @param sourceImage 原图片
 
 */
//+ (UIImage *)xw_circleImageWithImage:(UIImage *)sourceImage;

/**
 裁剪图片为圆形
 
 @param sourceImage 原图片
 @param borderWidth 边框
 @param borderColor 边框颜色
 
 */
+ (UIImage *)xw_circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 绘制圆点
 
 @param pointColor 圆点颜色
 @param pointSize  圆点大小
 
 @return 圆点
 */
+ (UIImage *)xw_circlePointImageWithColor: (UIColor *)pointColor size: (CGSize)pointSize;

/**
 绘制圆点
 
 @param pointColor 圆点颜色
 @param pointSize  圆点大小
 
 @return 圆点
 */
+ (UIView *)xw_circlePointViewWithColor: (UIColor *)pointColor size: (CGSize)pointSize;

@end

NS_ASSUME_NONNULL_END
