//
//  KSNavigationController.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSNavigationController.h"

@interface KSNavigationController ()

@end

@implementation KSNavigationController

+ (void)initialize {
    //导航栏主题，title的属性配置
    UINavigationBar *navBar = [UINavigationBar appearance];
    //控制导航栏的背景颜色
    navBar.barTintColor = [UIColor ks_mainColor];
    //控制导航栏返回按钮的颜色
    navBar.tintColor = [UIColor whiteColor];
    //控制导航栏标题的颜色
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]]; //去掉阴影线
    //控制导航栏的不透明
    navBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    //获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    //创建全屏滑动手势，调用系统字啊带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    //设置手势代理，拦截手势触发
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    //禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count == 1 ? NO : YES;
}

//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[KSParentController class]]) {
        KSParentController *vc = (KSParentController *)viewController;
        if (vc.hideNavBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            vc.view.top = StatusNav_Height;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
