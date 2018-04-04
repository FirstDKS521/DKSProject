//
//  KSHomeUrl.h
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSHomeUrl : NSObject

/**
 获取首页数据
 */
+ (NSString *)getHomePageUrl;

/**
 获取首页详情数据
 */
+ (NSString *)getHomeDetailUrl;

@end
