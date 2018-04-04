//
//  KSHomeUrl.m
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeUrl.h"

@implementation KSHomeUrl

/**
 获取首页数据
 
 数据来源于拼多多
 */
+ (NSString *)getHomePageUrl {
    return [NSString stringWithFormat:@"http://apiv4.yangkeduo.com/operations"];
}

/**
 获取首页详情数据
 */
+ (NSString *)getHomeDetailUrl {
    return [NSString stringWithFormat:@"http://apiv3.yangkeduo.com/search"];
}

@end
