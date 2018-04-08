//
//  UIColor+KSColor.h
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KSColor)

/**
 * 主题颜色
 */
+ (UIColor *)ks_mainColor;

/**
 * 强调颜色(title)
 */
+ (UIColor *)ks_titleColor;

/**
 * 一般颜色(返回）
 */
+ (UIColor *)ks_backColor;

/**
 * 灰色线条的颜色
 */
+ (UIColor *)ks_grayColor;

/**
 * 灰色字体的颜色
 */
+ (UIColor *)ks_grayTextColor;

/**
 * 背景颜色
 */
+ (UIColor *)ks_backgroundColor;

/**
 * 绿色
 */
+ (UIColor *)ks_greenColor;

/**
 * 红色
 */
+ (UIColor *)ks_redColor;

/**
 * 根据字符串变成颜色
 */
+ (UIColor *)ks_colorWithString:(NSString *)str;

/**
 * 根据字符串和透明度获取颜色
 * str 十六进制字符串
 * alpha 透明度
 */
+ (UIColor *)ks_colorWithString:(NSString *)str alpha:(CGFloat)alpha;

@end
