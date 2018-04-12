//
//  KSMineOrderCell.h
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSMineOrderModel.h"

@protocol KSMineOrderDelegate <NSObject>

/**
 更新CollectionView的高度
 */
- (void)updateCollectionViewHeight:(CGFloat)height;

@end

@interface KSMineOrderCell : UICollectionViewCell

@property (nonatomic, weak) id <KSMineOrderDelegate>delegaet;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) KSMineOrderModel *model;

@end
