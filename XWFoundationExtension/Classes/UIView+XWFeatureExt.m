//
//  UIView+XWFeatureExt.m
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//

#import "UIView+XWFeatureExt.h"

@implementation UIView (XWFeatureExt)

/**
 设置部分圆角(frame布局)
 
 @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 @param radii   需要设置的圆角半径
 */
- (void)xw_addRoundedCorners:(UIRectCorner)corners
                              radius:(CGFloat)radii {
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (NSArray *)xw_subviewsWithTargetClass:(Class)cls {
    NSMutableArray *queue = [NSMutableArray array];
    NSMutableArray *result = [NSMutableArray array];
    // 将当前视图进队列
    [queue addObject:self];
    while (queue.count) {
        UIView *removeView = queue[0];
        if ([removeView isKindOfClass:cls]) {
            [result addObject:removeView];
        }
        // 出队列
        [queue removeObjectAtIndex:0];
        // 将出队列子视图加入队列
        [queue addObjectsFromArray:removeView.subviews];
    }
    return result;
}

@end
