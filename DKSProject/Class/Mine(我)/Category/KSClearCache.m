//
//  KSClearCache.m
//  DKSProject
//
//  Created by aDu on 2018/4/5.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSClearCache.h"

@implementation KSClearCache

//计算单个文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//计算整个目录的大小
+ (float)folderSizeAtPath {
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFiles = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFiles nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}

//异步清除缓存
+ (void)clearCache:(ClearCacheBlock)block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //文件路径
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSArray *subPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
        for (NSString *subPath in subPaths) {
            NSString *path = [filePath stringByAppendingPathComponent:subPath];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}

@end
