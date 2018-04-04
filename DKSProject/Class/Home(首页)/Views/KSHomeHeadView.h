//
//  KSHomeHeadView.h
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHomeModel.h"

typedef void(^BtnBlock)(void);
@interface KSHomeHeadView : UICollectionReusableView

/**
 点击查看全部按钮回调
 */
@property (nonatomic, copy) BtnBlock btnBlock;

@property (nonatomic, strong) KSHomeModel *model;

@end
