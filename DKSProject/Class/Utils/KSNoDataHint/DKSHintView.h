//
//  DKSHintView.h
//  Demo
//
//  Created by aDu on 2017/12/26.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKSHintView : UIView

/**
 是否自动显示占位图，默认YES
 */
@property (nonatomic, assign) BOOL autoShowHintView;

/**
 只显示图片

 @param imageStr 图片名臣
 @return 返回一个占位图
 */
+ (instancetype)showHintViewWithImageStr:(NSString *)imageStr;

/**
 只显示提示文案
 
 @param titleStr 提示文案
 @return 返回一个占位图
 */
+ (instancetype)showHintViewWithTitleStr:(NSString *)titleStr;

/**
 显示图片、提示文案

 @param imageStr 图片名称
 @param titleStr 提示文案
 @return 返回一个占位图
 */
+ (instancetype)showHintViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr;

/**
 显示提示文案、按钮

 @param titleStr 提示文案
 @param btnTitleStr 按钮文案
 @param target 相应事件的对象
 @param action 相应事件的方法
 @return 返回一个占位图
 */
+ (instancetype)showHintViewWithTitleStr:(NSString *)titleStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action;

/**
 总的方法，如果不显示某个控件，只需传入nil即可

 @param imageStr 图片名称
 @param titleStr 提示文案
 @param btnTitleStr 按钮文案
 @param target 相应事件的对象
 @param action 相应事件的方法
 @return 返回一个占位图
 */
+ (instancetype)showHintViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action;

/**
 自定义一个需要显示占位图的视图

 @param customView 定义的视图
 @param imageStr 图片名称
 @param titleStr 提示文案
 @param btnTitleStr 按钮文案
 @param target 相应事件的对象
 @param action 相应事件的方法
 */
+ (void)showHintViewWithCustomView:(UIView *)customView imageStr:(NSString *)imageStr titleStr:(NSString *)titleStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action;

@end
