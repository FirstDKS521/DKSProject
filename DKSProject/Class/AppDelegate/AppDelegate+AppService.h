//
//  AppDelegate+AppService.h
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

/**
 单利获取AppDelegate
 */
+ (AppDelegate *)shareAppDelegate;

/**
 初始化服务
 */
- (void)initService;

/**
 初始化window
 */
- (void)initWindow;

/**
 初始化友盟
 */
- (void)initUMeng;

/**
 初始化微信SDK
 */
- (void)initWXSDK;

/**
 检测登录状态
 */
- (void)checkLoginState;

/**
 网络监听
 */
- (void)monitorNetWorkStatus;

@end
