//
//  KSParentController.h
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSParentController : UIViewController

/**
 隐藏导航栏
 */
@property (nonatomic, assign) BOOL hideNavBar;

/**
 是否显示返回按钮，默认YES
 */
@property (nonatomic, assign) BOOL isShowLeftBack;

@property (nonatomic, strong) NSMutableArray *dataAry;

/**
 修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 加载最新数据
 */
- (void)loadNewData;

/**
 加载更多数据
 */
- (void)loadMoreData;

@end
