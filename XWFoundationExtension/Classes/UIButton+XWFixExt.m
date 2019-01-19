//
//  UIButton+XWFixExt.m
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//

#import "UIButton+XWFixExt.h"
#import "NSObject+XWFeatureExt.h"
#import <objc/runtime.h>

@implementation UIButton (XWFixExt)

+ (void)load{
    [self xw_hookSwizzleSelector:@selector(setHighlighted:) withSelector:@selector(xw_setHighlighted:)];
}

/**
 修复UIKit.UIButton高亮Bug
 */
- (void)xw_setHighlighted:(BOOL)highlighted {
    if (self.adjustsImageWhenHighlighted) {
        [self xw_setHighlighted:highlighted];
    }
}


#pragma mark - TouchDown

- (void)setTouchDownBlock:(void (^)(UIButton * _Nonnull __weak))touchDownBlock {
    [self addTarget:self action:@selector(xw_touchDown:) forControlEvents:UIControlEventTouchDown];
    objc_setAssociatedObject(self, @selector(touchDownBlock), touchDownBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton * _Nonnull __weak))touchDownBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)xw_touchDown:sender {
    if (self.touchDownBlock) {
        self.touchDownBlock(self);
    }
}

#pragma mark - TouchDownRepeat

- (void)setTouchDownRepeatBlock:(void (^)(UIButton * _Nonnull __weak))touchDownRepeatBlock {
    [self addTarget:self action:@selector(xw_touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
    objc_setAssociatedObject(self, @selector(touchDownRepeatBlock), touchDownRepeatBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton * _Nonnull __weak))touchDownRepeatBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)xw_touchDownRepeat:sender {
    if (self.touchDownRepeatBlock) {
        self.touchDownRepeatBlock(self);
    }
}

#pragma mark - TouchUpInside

- (void)setTouchUpInsideBlock:(void (^)(UIButton * _Nonnull __weak))touchUpInsideBlock {
    [self addTarget:self action:@selector(xw_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, @selector(touchUpInsideBlock), touchUpInsideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton * _Nonnull __weak))touchUpInsideBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)xw_touchUpInside:sender {
    if (self.touchUpInsideBlock) {
        self.touchUpInsideBlock(self);
    }
}


@end
