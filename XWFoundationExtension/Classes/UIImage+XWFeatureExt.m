//
//  UIImage+XWFeatureExt.m
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//

#import "UIImage+XWFeatureExt.h"

static dispatch_queue_t xw_image_feature_draw_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.xw.image.draw.queue.creation", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

@implementation UIImage (XWFeatureExt)

#pragma mark - 图片二维码生成

void XWProviderReleaseDataCallback (void *info, const void *data, size_t size){
    free((void*)data);
}

+ (UIImage *)xw_qrImageForString:(NSString *)string imageSize:(CGFloat)imageSize red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    UIImage *image = [self xw_qrImageForString:string imageSize:imageSize];
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = red * 255;
            ptr[2] = green * 255;
            ptr[1] = blue * 255;
        }else{
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 取出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, XWProviderReleaseDataCallback);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    
    return resultImage;
}

// 生成二维码图片
+ (UIImage *)xw_qrImageForString:(NSString *)string imageSize:(CGFloat)imageSize {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *outPutImage = [filter outputImage];
    
    // 尺寸限定
    CGRect extent = CGRectIntegral(outPutImage.extent);
    CGFloat scale = MIN(imageSize/CGRectGetWidth(extent), imageSize/CGRectGetHeight(extent));
    
    // 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *bitmapContext = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [bitmapContext createCGImage:outPutImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap图片
    CGImageRef blackCGImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage *blackImage = [UIImage imageWithCGImage:blackCGImage];
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return blackImage;
}

#pragma mark -

+ (UIImage *)xw_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)xw_drawImageWithColor:(UIColor *)color size:(CGSize)size completion:(void(^)(UIImage *img))comp {
    if (!comp) return;
    dispatch_async(xw_image_feature_draw_queue(), ^{
        UIImage *img = [UIImage xw_imageWithColor:color size:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            comp(img);
        });
    });
}

+ (UIImage *)xw_circleImageWithColor:(UIColor *)color diam:(CGFloat)diam {
    CGRect coverRect = CGRectMake(0.f, 0.f, diam, diam);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(diam, diam), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:coverRect];
    CGContextAddPath(context, [path CGPath]);
    CGContextClip(context);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, coverRect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

+ (void)xw_drawCircleImageWithColor:(UIColor *)color diam:(CGFloat)diam completion:(void(^)(UIImage *img))comp {
    if (!comp) return;
    dispatch_async(xw_image_feature_draw_queue(), ^{
        UIImage *img = [UIImage xw_circleImageWithColor:color diam:diam];
        dispatch_async(dispatch_get_main_queue(), ^{
            comp(img);
        });
    });
}

#pragma mark -

+ (UIImage *)xw_imageWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attributes backgroundColor:(UIColor *)color {
    CGSize strSize = [str sizeWithAttributes:attributes];
    // 设置画布大小
    CGRect coverRect = CGRectMake(0.f, 0.f, strSize.width, strSize.height);
    UIGraphicsBeginImageContextWithOptions(coverRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0.f, 0.f, coverRect.size.width, coverRect.size.height));
    
    // 绘制文字
    [str drawInRect:coverRect withAttributes:attributes];
    
    // 生产图片
    UIImage *wordImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return wordImage;
}

+ (void)xw_drawImageWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attributes backgroundColor:(UIColor *)color completion:(void(^)(UIImage *img))comp {
    if (!comp) return;
    dispatch_async(xw_image_feature_draw_queue(), ^{
        UIImage *img = [UIImage xw_imageWithString:str attributes:attributes backgroundColor:color];
        dispatch_async(dispatch_get_main_queue(), ^{
            comp(img);
        });
    });
}

#pragma mark -

- (UIImage *)xw_clipCircleImage {
    CGSize sourceSize = self.size;
    CGFloat minSide = MIN(sourceSize.width, sourceSize.height);
    // 设置画布大小
    CGRect coverRect = CGRectMake(0.f, 0.f, minSide, minSide);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(minSide, minSide), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 裁剪
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:coverRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(minSide / 2, minSide / 2)];
    CGContextAddPath(context, [rounded CGPath]);
    CGContextClip(context);
    
    // 绘制图片
    if (sourceSize.width > sourceSize.height) {
        [self drawAtPoint:CGPointMake(-(sourceSize.width - sourceSize.height) / 2, 0)];
    } else {
        [self drawAtPoint:CGPointMake(0, -(sourceSize.height - sourceSize.width) / 2)];
    }
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)xw_clipBorderWithRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radii {
    CGSize sourceSize = self.size;
    // 设置画布大小
    CGRect coverRect = CGRectMake(0.f, 0.f, sourceSize.width, sourceSize.height);
    UIGraphicsBeginImageContextWithOptions(sourceSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 裁剪
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:coverRect byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
    CGContextAddPath(context, [rounded CGPath]);
    CGContextClip(context);
    
    // 绘制图片
    [self drawInRect:coverRect];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (void)xw_clipCircleImage:(UIImage *)sourceImage completion:(void(^)(UIImage *img))comp {
    if (!comp) return;
    dispatch_async(xw_image_feature_draw_queue(), ^{
        UIImage *image = [sourceImage xw_clipCircleImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            comp(image);
        });
    });
}

+ (void)xw_clipBorderWithImage:(UIImage *)sourceImage roundedCorners:(UIRectCorner)corners radius:(CGFloat)radii completion:(void(^)(UIImage *img))comp {
    if (!comp) return;
    dispatch_async(xw_image_feature_draw_queue(), ^{
        UIImage *image = [sourceImage xw_clipBorderWithRoundedCorners:corners radius:radii];
        dispatch_async(dispatch_get_main_queue(), ^{
            comp(image);
        });
    });
}

@end
