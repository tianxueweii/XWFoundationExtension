//
//  NSObject+XWFeatureExt.h
//  XWFoundationExtension
//
//  Created by tianxuewei on 2019/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XWFeatureExt)

/**
 交换实例方法
 */
+ (void)xw_hookSwizzleSelector:(SEL)origSelector withSelector:(SEL)newSelector;

/**
 交换类方法
 */
+ (void)xw_hookSwizzleClassSelector:(SEL)origSelector withSelector:(SEL)newSelector;

/**
 遍历成员属性
 @param backwardClass    遍历追溯的目标类
 @param block            每遍历到一个属性block被回调, *stop = YES, 停止遍历
 */
- (void)xw_enumerateKeysAndObjectsToBackwardClass:(Class)backwardClass block:(void (^)(NSString *key, id obj, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
