//
//  KSHomeDetailModel.h
//  DKSProject
//
//  Created by aDu on 2018/3/29.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSHomeDetailModel : NSObject

@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, strong) NSURL *hd_thumb_url;
@property (nonatomic, assign) NSInteger price; //价格
@property (nonatomic, assign) NSInteger cnt; //出售数量

@end
