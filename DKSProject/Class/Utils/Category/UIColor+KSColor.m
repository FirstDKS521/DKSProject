//
//  UIColor+KSColor.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "UIColor+KSColor.h"

@implementation UIColor (KSColor)

//主题颜色
+ (UIColor *)ks_mainColor {
    return [UIColor ks_colorWithString:@"#349B97"];
}

//title颜色
+ (UIColor *)ks_titleColor {
    return [UIColor colorWithWhite:0.353 alpha:1.000];
}

//返回按钮颜色
+ (UIColor *)ks_backColor {
    return [UIColor colorWithWhite:0.443 alpha:1.000];
}

//灰色线条颜色
+ (UIColor *)ks_grayColor {
    return [UIColor ks_colorWithString:@"#EBEBEB"];
}

//灰色字体颜色
+ (UIColor *)ks_grayTextColor {
    return [UIColor ks_colorWithString:@"#9D9D9D"];
}

//背景颜色
+ (UIColor *)ks_backgroundColor {
    return [UIColor ks_colorWithString:@"#EBEBEB"];
}

//绿色
+ (UIColor *)ks_greenColor {
    return [UIColor ks_colorWithString:@"#61B176"];
}

//红色
+ (UIColor *)ks_redColor {
    return [UIColor ks_colorWithString:@"#FE0000"];
}

+ (UIColor *)ks_colorWithString:(NSString *)str {
    return [UIColor ks_colorWithString:str alpha:1.0];
}

+ (UIColor *)ks_colorWithString:(NSString *)str alpha:(CGFloat)alpha {
    if (![str hasPrefix:@"#"]) {
        str = [NSString stringWithFormat:@"#%@", str];
    }
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [UIColor ks_colorWithHex:x alpha:alpha];
}

+ (UIColor *)ks_colorWithHex:(long)col alpha:(CGFloat)alpha {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:alpha];
}

@end
