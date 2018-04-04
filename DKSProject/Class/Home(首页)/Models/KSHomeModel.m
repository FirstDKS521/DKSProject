//
//  KSHomeModel.m
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeModel.h"

@implementation KSHomeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children": KSHomeChildrenModel.class};
}

@end

@implementation KSHomeChildrenModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"aId": @"id"};
}

@end
