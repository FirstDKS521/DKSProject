//
//  AppDelegate+AppService.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "KSTabBarController.h"
#import "KSLoginController.h"

@implementation AppDelegate (AppService)

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark ====== 初始化服务 ======
- (void)initService {
    //检测登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:K_LoginStateChange object:nil];
}

#pragma mark ====== 初始化window ======
- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //防止同一页面多个button同时点击
    [[UIButton appearance] setExclusiveTouch:YES];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

#pragma mark ====== 初始化友盟 ======
- (void)initUMeng {
    
}

#pragma mark ====== 初始化微信SDK ======
- (void)initWXSDK {
    
}

#pragma mark ====== 检测登录状态 ======
- (void)checkLoginState {
    id loginState = [K_UserDefaults objectForKey:K_IsLogin];
    if (loginState) {
        [[NSNotificationCenter defaultCenter] postNotificationName:K_LoginStateChange object:@YES];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:K_LoginStateChange object:@NO];
    }
}

#pragma mark ====== 登录相关 ======
- (void)loginStateChange:(NSNotification *)notification {
    BOOL loginState = [notification.object boolValue];
    if (loginState) { //登录状态
        [K_UserDefaults setValue:@"isLogin" forKey:K_IsLogin];
        self.tabBarVC = [[KSTabBarController alloc] init];
        CATransition *anima = [CATransition animation];
        anima.type = @"cube";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        
        self.window.rootViewController = self.tabBarVC;
        [self.window.layer addAnimation:anima forKey:@"revealAnimation"];
    } else { //未登录状态
        [K_UserDefaults setValue:nil forKey:K_IsLogin];
        CATransition *anima = [CATransition animation];
        anima.type = @"cube";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        
        KSLoginController *loginVC = [[KSLoginController alloc] init];
        KSNavigationController *nav = [[KSNavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
        [self.window.layer addAnimation:anima forKey:@"revealAnimation"];
    }
}

#pragma mark ====== 监听网络状态 ======
- (void)monitorNetWorkStatus {
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType status) {
        switch (status) {
            case 0:
                NSLog(@"未知网络");
                break;
            case 1:
                NSLog(@"无网络");
                break;
            case 2:
                NSLog(@"手机网络");
                break;
            case 3:
                NSLog(@"WIFI网络");
                break;
            default:
                break;
        }
    }];
}

@end
