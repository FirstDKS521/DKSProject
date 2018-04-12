//
//  UIView+KSView.h
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KSView)

/**
 * 添加UIView的点击方法
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 * 找到当前UIView的视图控制器
 * 在UIView中调用
 */
- (UIViewController *)findParentController:(UIView *)currentView;

/**
 * 富文本，从哪个位置开始到哪个位置结束
 * @param color 想要的颜色
 * @param local 开始位置
 * @param end 结束位置
 */
- (void)label:(UILabel *)label text:(NSString *)text color:(UIColor *)color startLocal:(NSInteger)local endLocal:(NSInteger)end;

/**
 * 富文本，从哪个位置开始  多长
 * @param color 想要的颜色
 * @param local 开始位置
 * @param length 长度
 */
- (void)label:(UILabel *)label text:(NSString *)text color:(UIColor *)color startLocal:(NSInteger)local length:(NSInteger)length;

/**
 * 添加完成按钮
 */
- (UIToolbar *)addToolbar;

/**
 添加UITextField的LeftView的方法
 @param leftField 需要添加leftView的textField
 */
- (void)textFieldLeftView:(UITextField *)leftField;

/**
 设置UILabel的行间距
 @param space 间距大小
 @param label UILabel类型的label
 @param str 需要设置的文案
 */
- (void)setLabelLineSpacing:(CGFloat)space label:(UILabel *)label textStr:(NSString *)str;

@end
