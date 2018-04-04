//
//  KSHomeDetailModel.m
//  DKSProject
//
//  Created by aDu on 2018/3/29.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeDetailModel.h"

@implementation KSHomeDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"price": @"group.price"};
}

@end
