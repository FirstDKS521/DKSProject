//
//  KSMineOrderCell.h
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSMineOrderModel.h"

@interface KSMineOrderCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) KSMineOrderModel *model;

@end
