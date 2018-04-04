//
//  UIScrollView+HintView.h
//  Demo
//
//  Created by aDu on 2017/12/28.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKSHintView.h"

@interface UIScrollView (HintView)
/** 占位图 */
@property (nonatomic, strong) DKSHintView *hintView;

/**
 开始加载数据
 */
- (void)startLoading;

/**
 结束刷数据
 */
- (void)endLoading;

/**
 显示占位图
 */
- (void)showHintView;

/**
 隐藏占位图
 */
- (void)hideHintView;

@end
