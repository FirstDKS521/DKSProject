//
//  UIViewController+KSNavBarItem.h
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KSNavBarItem)

#pragma mark - 左边的按钮
/**
 * 返回 按钮
 * 修改左边的按钮
 */
- (id)addLeftBarButtonItem;

#pragma mark - 右边的按钮
/**
 * 添加导航栏右边的按钮
 * @author titleStr 文案
 */
- (id)addRightBarButtonItem:(NSString *)titleStr;

/**
 添加导航栏右边按钮
 @param titleStr 文案
 @param color 文案颜色
 */
- (id)addRightBarButtonItem:(NSString *)titleStr titleColor:(UIColor *)color;

/**
 * 添加右边图片按钮
 */
- (void)addRightBarItemWithImage:(UIImage *)image;

/**
 * 点击右边导航栏按钮的方法
 */
- (void)rightBarButtonItemAction:(UIButton *)barButton;

#pragma mark ====== 改变导航栏的背景色 ======
/**
 设置导航栏为默认的颜色
 */
- (void)changeNavBackgroundColorToDefault;

/**
 改变导航栏背景颜色
 
 @param color 需要改变的颜色
 */
- (void)changeNavBackgroundColorToColor:(UIColor *)color;

@end
