//
//  KSMineOrderModel.h
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSMineOrderModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, assign) NSInteger newCount; //未读消息个数

@end
