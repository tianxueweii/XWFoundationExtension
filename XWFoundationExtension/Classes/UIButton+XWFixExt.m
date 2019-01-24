//
//  UIButton+XWFixExt.m
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//

#import "UIButton+XWFixExt.h"
#import "NSObject+XWFeatureExt.h"

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

@end
