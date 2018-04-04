//
//  UIViewController+KSNavBarItem.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "UIViewController+KSNavBarItem.h"

@implementation UIViewController (KSNavBarItem)

#pragma mark - 左边的按钮
/**
 * 返回 按钮
 * 修改左边的按钮
 */
- (id)addLeftBarButtonItem {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor ks_backColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Large];
    UIImage *image = [UIImage imageNamed:@"sy_back"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
    leftBtn.frame = CGRectMake(-5, 0, 60, 44);
    //将leftItem设置为自定义按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    return leftBtn;
}

- (void)doBack {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 右边的按钮
- (id)addRightBarButtonItem:(NSString *)titleStr {
    return [self addRightBarButtonItem:titleStr titleColor:[UIColor whiteColor]];
}

- (id)addRightBarButtonItem:(NSString *)titleStr titleColor:(UIColor *)color {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom]; [rightBtn setTitle:titleStr forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    [rightBtn setTitleColor:color forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    //将leftItem设置为自定义按钮
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView: rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    return rightBtn;
}

//添加右边图片按钮
- (void)addRightBarItemWithImage:(UIImage *)image {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarButtonItemAction:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//点击右边按钮的方法
- (void)rightBarButtonItemAction:(UIButton *)barButton {
    
}

#pragma mark ====== 改变导航栏的背景色 ======
- (void)changeNavBackgroundColorToDefault {
    //控制导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor ks_mainColor];
    //控制导航栏返回按钮的颜色
    self.navigationController.navigationBar.tintColor = [UIColor ks_backColor];
    //控制导航栏标题的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor ks_titleColor]}];
}

- (void)changeNavBackgroundColorToColor:(UIColor *)color {
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
