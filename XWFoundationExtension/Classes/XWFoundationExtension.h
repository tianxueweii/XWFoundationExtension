//
//  XWFoundationExtension.h
//  Pods
//
//  Created by 田学为 on 2019/1/17.
//

#ifndef XWFoundationExtension_h
#define XWFoundationExtension_h

#import "NSObject+XWFeatureExt.h"
#import "NSString+XWFeatureExt.h"
#import "UIButton+XWFixExt.h"
#import "UIColor+XWFeatureExt.h"
#import "UIImage+XWFeatureExt.h"
#import "UINavigationController+XWFixExt.h"
#import "UIView+XWFeatureExt.h"


#define weakDef(obj)  __weak __typeof(&*obj) weak_##obj = obj;

#pragma mark -

/**
 屏幕宽度
 */
#define _screenWidth        [[UIScreen mainScreen] bounds].size.width
/**
 屏幕高度
 */
#define _screenHeight       [[UIScreen mainScreen] bounds].size.heigh
/**
 状态栏高度
 */
#define _statusBarHeight    [UIApplication sharedApplication].statusBarFrame.size.height

#pragma mark -

/**
 RGB初始化颜色
 */
#define UIColorRGB(a,b,c)       [UIColor colorWithRed:(a / 255.0) green:(b / 255.0) blue:(c / 255.0) alpha:1.0]
/**
 RGBA初始化颜色
 */
#define UIColorRGBA(a,b,c,d)    [UIColor colorWithRed:(a / 255.0) green:(b / 255.0) blue:(c / 255.0) alpha:d]
/**
 Hex初始化颜色
 */
#define UIColorHex(h)           [UIColor xw_colorWithHex:h]

/**
 资源名初始化图片
 */
#define UIImage(n) [UIImage imageNamed:n]


#pragma mark -

/**
 系统当前语言
 */
#define _currentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark -

/**
 获取temp路径
 */
#define _sandboxPathTemp        NSTemporaryDirectory()
/**
 获取沙盒 Document 路径
 */
#define _sandboxPathDocument    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/**
 获取沙盒 Cache 路径
 */
#define _sandboxPathCache       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#pragma mark -

#define _isiPhoneXSeries \
({BOOL isPhoneX = NO;\
    if (@available(iOS 11.0, *)) {\
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
    }\
(isPhoneX);})

#pragma mark -

/**
 输出堆栈
 */
#define NSLogStackSymbols NSLog(@"－－－%@",[NSThread callStackSymbols]);

#pragma mark -

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* XWFoundationExtension_h */
