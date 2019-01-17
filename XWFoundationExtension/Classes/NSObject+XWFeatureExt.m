//
//  NSObject+XWFeatureExt.m
//  XWFoundationExtension
//
//  Created by tianxuewei on 2019/1/8.
//

#import "NSObject+XWFeatureExt.h"
#import <objc/runtime.h>

@implementation NSObject (XWFeatureExt)

+ (void)xw_hookSwizzleSelector:(SEL)origSelector withSelector:(SEL)newSelector {
    Class class = [self class];
    
    Method oriMethod = class_getInstanceMethod(class, origSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    method_exchangeImplementations(oriMethod, newMethod);
}

+ (void)xw_hookSwizzleClassSelector:(SEL)origSelector withSelector:(SEL)newSelector {
    Class class = [self class];
    
    Method oriMethod = class_getClassMethod(class, origSelector);
    Method newMethod = class_getClassMethod(class, newSelector);
    method_exchangeImplementations(oriMethod, newMethod);
}

- (void)xw_enumerateKeysAndObjectsToBackwardClass:(Class)backwardClass block:(void (^)(NSString *key, id obj, BOOL *stop))block {
    
    Class class = [self class];
    if (backwardClass == nil) {
        backwardClass = [NSObject class];
    }
    BOOL isStop = NO;
    while (class != nil) {
        unsigned int outCount;
        Ivar *ivarList = class_copyIvarList(class, &outCount);
        for (unsigned int i = 0; i < outCount; i++) {
            if (block) {
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
                //SEL类型变量需要针对性处理
                if (strcmp(ivar_getTypeEncoding(ivarList[i]), @encode(SEL))) {
                    block(key, [self valueForKeyPath:key], &isStop);
                } else {
                    //非SEL类型变量
                    block(key, NSStringFromSelector((__bridge void *)object_getIvar(self, ivarList[i])), &isStop);
                }
                if (isStop){
                    break;
                }
            }
        }
        free(ivarList);
        if (isStop || (class == backwardClass)) {
            break;
        }
        class = class_getSuperclass(class);
    }
}

@end
