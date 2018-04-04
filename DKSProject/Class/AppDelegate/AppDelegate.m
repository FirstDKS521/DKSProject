//
//  AppDelegate.m
//  DKSProject
//
//  Created by aDu on 2018/3/12.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AppService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置启动画面的时长，如果有网络请求，同时也会根据网路状态进行判断
//    sleep(2);
    
    //初始化
    [self initWindow];
    
    //初始化服务
    [self initService];
    
    //初始化友盟
    [self initUMeng];
    
    //初始化微信SDK
    [self initWXSDK];
    
    //监控网络状态
    [self monitorNetWorkStatus];
    
    //检测登录状态
    [self checkLoginState];
    
    return YES;
}

#pragma mark ====== AppDelegate ======
//程序即将变成活跃状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

//程序已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

//程序将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

//程序将要变成活跃状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

//程序将要被终止
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
