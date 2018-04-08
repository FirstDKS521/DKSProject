//
//  UIView+KSBrdge.h
//  DKSProject
//
//  Created by aDu on 2018/4/8.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KSBrdge)

/**
 *  通过创建label，显示小红点；
 */
@property (nonatomic, strong) UILabel *badge;

/**
 *  显示小红点
 */
- (void)showBadge;

/**
 * 显示几个小红点儿
 * parameter redCount 小红点儿个数
 */
- (void)showBadgeWithCount:(NSInteger)redCount;

/**
 *  隐藏小红点
 */
- (void)hideBadge;

@end
