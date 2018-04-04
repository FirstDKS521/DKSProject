//
//  KSHomeTableCell.h
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHomeModel.h"

@interface KSHomeTableCell : UITableViewCell

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) KSHomeModel *model;

@end
