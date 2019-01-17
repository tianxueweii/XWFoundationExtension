//
//  UIColor+XWFeatureExt.m
//  XWFoundationExtension
//
//  Created by tianxuewei on 2019/1/8.
//

#import "UIColor+XWFeatureExt.h"

@implementation UIColor (XWFeatureExt)

+ (UIColor *)xw_randomColor {
    
    return [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0f];
}


// 16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *)xw_colorWithHex:(NSString *)hexString {
    
    if (hexString == nil) {
        return [UIColor whiteColor];
    }
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if (cString.length == 6){
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int r, g, b;
        
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }else if (cString.length == 8){
        
        // Separate into a, r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        
        NSString *aString = [cString substringWithRange:range];
        range.location = 2;
        NSString *rString = [cString substringWithRange:range];
        range.location = 4;
        NSString *gString = [cString substringWithRange:range];
        range.location = 6;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int a, r, g, b;
        
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:((float) a / 255.0f)];
        
    }else{
        return [UIColor blackColor];
    }
}

@end
