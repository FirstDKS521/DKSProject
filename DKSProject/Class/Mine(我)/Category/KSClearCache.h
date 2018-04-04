//
//  KSClearCache.h
//  DKSProject
//
//  Created by aDu on 2018/4/5.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ClearCacheBlock)(void);
@interface KSClearCache : NSObject

/**
 * 获取整个缓存目录的大小
 */
+ (float)folderSizeAtPath;

/**
 * 清除缓存
 */
+ (void)clearCache:(ClearCacheBlock)block;

@end
