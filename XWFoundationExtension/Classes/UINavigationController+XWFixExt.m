//
//  UINavigationController+XWFixExt.m
//  Pods
//
//  Created by tianxuewei on 2019/1/17.
//

#import "UINavigationController+XWFixExt.h"
#import "NSObject+XWFeatureExt.h"

@interface UINavigationController ()<UIGestureRecognizerDelegate>
@end

@implementation UINavigationController (XWFixExt)

+ (void)load{
    [self xw_hookSwizzleSelector:@selector(pushViewController:animated:)
                    withSelector:@selector(xw_pushViewController:animated:)];
}

- (void)xw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.interactivePopGestureRecognizer.delegate != self) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    [self xw_pushViewController:viewController animated:animated];
}



#pragma mark - UIGestureRecognizerDelegate

/**
 必须实现该方法，否则会出现主视图侧滑bug
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;{
    return self.viewControllers.count > 1;
}

#pragma mark - Autorotate

/**
 根据最上层控制器判断是否可以旋转
 */
- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
