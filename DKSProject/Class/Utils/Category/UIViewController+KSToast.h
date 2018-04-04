//
//  UIViewController+KSToast.h
//  DKSProject
//
//  Created by aDu on 2018/3/16.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KSToast)

/**
 * 仅文字提示,自动隐藏
 */
- (void)ks_toastString:(NSString *)content;

/**
 * 仅文字,需手动隐藏
 */
- (void)ks_toastNotHideString:(NSString *)content;

/**
 * 文字提示，自动隐藏，隐藏之后的回调
 */
- (void)ks_toastString:(NSString *)content completBlock:(void (^)(void))block;

/**
 * 文字加菊花,自动隐藏
 */
- (void)ks_toastProgressHiden:(NSString *)content;

/**
 * 文字加菊花,需手动隐藏
 */
- (void)ks_toastProgressString:(NSString *)content;

/**
 * 文字加菊花，自动隐藏，隐藏回调
 */
- (void)ks_toastProgress:(NSString *)content completBlock:(void (^)(void))block;

/**
 * 隐藏弹框
 */
- (void)ks_toastHiden;

@end
