//
//  KSHomeModel.h
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSHomeModel : NSObject

@property (nonatomic, assign) NSInteger opt_id;
@property (nonatomic, copy) NSString *opt_name; //title名字
@property (nonatomic, strong) NSArray *children;

@end

@interface KSHomeChildrenModel : NSObject

@property (nonatomic, assign) NSInteger aId;
@property (nonatomic, strong) NSURL *image_url; //图片
@property (nonatomic, copy) NSString *opt_name; //title

@end
