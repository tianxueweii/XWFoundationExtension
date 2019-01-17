//
//  NSString+XWFeatureExt.h
//  XWFoundationExtension
//
//  Created by tianxuewei on 2019/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XWFeatureExt)

/**
 空字符串
 
 @param str string
 @return bool
 */
+ (BOOL)xw_isBlankString:(NSString *)str;

/**
 获取MD5编码后字符串
 
 @param str 待编码
 @return 编码字符串
 */
+ (NSString *)xw_md5WithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
