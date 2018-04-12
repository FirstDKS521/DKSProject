//
//  PublicMacros.h
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#ifndef PublicMacros_h
#define PublicMacros_h

//不打印NSLog
#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define NSLog(...) printf("[%s %s 第%d行] %s \n\n", __TIME__, [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

//URL相关配置
#define K_Url @"http://192.168.1.24:8080/product"  //生产
//#define K_Url @"http://192.168.1.24:8080/develop"  //测试

//动画时长
#define K_Animation_Time 2.0

//本地存储的对象获取
#define K_UserDefaults [NSUserDefaults standardUserDefaults]

//获取屏幕的宽度和高度
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
//判断是否是iPhoneX
#define isIphoneX (Screen_Width == 375.f && Screen_Height == 812.f ? YES : NO)
//状态栏和导航栏的总高度
#define StatusNav_Height (isIphoneX ? 88 : 64)
#define Nav_Height 44
//状态栏高度
#define StatusBar_Height (isIphoneX ? Nav_Height : 20)
//TabBar的高度
#define TabBar_Height ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)

//版本号判断
#define iOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]

//字体相关
#define Font_Large 17.0 //大字体
#define Font_Middle 14.0 //中间字体
#define Font_Little 12.0 //小字体


#endif /* PublicMacros_h */
