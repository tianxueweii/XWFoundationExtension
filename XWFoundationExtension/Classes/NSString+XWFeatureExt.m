//
//  NSString+XWFeatureExt.m
//  XWFoundationExtension
//
//  Created by tianxuewei on 2019/1/8.
//

#import "NSString+XWFeatureExt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (XWFeatureExt)

/**
 空字符串
 
 @param str string
 @return bool
 */
+ (BOOL)xw_isBlankString:(NSString *)str {
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

/**
 获取MD5编码后字符串
 
 @param str 待编码
 @return 编码字符串
 */
+ (NSString *)xw_md5WithString:(NSString *)str {
    //转换成utf-8
    const char *cStr = [str UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
