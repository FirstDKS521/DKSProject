//
//  KSMineOtherCell.h
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSMineOtherCell;
@protocol KSOtherDelegate <NSObject>

/**
 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(KSMineOtherCell *)cell andHeight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;

@end

@interface KSMineOtherCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id <KSOtherDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
