//
//  KSTableHeaderView.h
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KSTableHeaderView : NSObject

/**
 创建区头视图

 @param tableView 当前的tableView
 @param view 内容视图
 */
- (void)stretchHeaderForTableView:(UITableView *)tableView
                         withView:(UIView *)view;

/**
 滚动视图滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 调整大小
 */
- (void)resizeView;

/*
 *使用时要实现以下两个代理方法
 *- (void)scrollViewDidScroll:(UIScrollView *)scrollView
 *- (void)viewDidLayoutSubviews
 */
@end
