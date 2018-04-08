//
//  UITabBar+KSBrdge.h
//  DKSProject
//
//  Created by aDu on 2018/4/8.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (KSBrdge)

/**
 *  显示小红点
 *
 *  @param index 传入需要现实的位置
 */
- (void)showBadgeIndex:(NSInteger)index;

/**
 *  隐藏小红点
 *
 *  @param index 传入需要隐藏的位置
 */
- (void)hideBadgeIndex:(NSInteger)index;

@end
