//
//  KSParentController.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSParentController.h"

@interface KSParentController ()

@end

@implementation KSParentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //是否显示返回按钮
    self.isShowLeftBack = YES;
    //默认状态栏样式高亮
    self.statusBarStyle = UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark ====== 改变状态栏颜色 ======
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

//动态更新状态栏颜色
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark ====== 刷新、加载数据 ======
- (void)loadNewData {
    
}

- (void)loadMoreData {
    
}

#pragma mark ====== init ======
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - StatusNav_Height) style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        //顶部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadNewData];
            [_tableView.mj_header endRefreshing];
        }];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        _tableView.mj_header = header;
        //底部刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
            [_tableView.mj_footer endRefreshing];
        }];
        _tableView.backgroundColor = [UIColor ks_backgroundColor];
        _tableView.scrollsToTop = YES; //返回顶部
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - StatusNav_Height) collectionViewLayout:flowLayout];
        //顶部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadNewData];
            [_collectionView.mj_header endRefreshing];
        }];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        _collectionView.mj_header = header;
        //底部刷新
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
            [_collectionView.mj_footer endRefreshing];
        }];
        _collectionView.backgroundColor = [UIColor ks_backgroundColor];
        _collectionView.scrollsToTop = YES; //返回顶部
    }
    return _collectionView;
}

- (NSMutableArray *)dataAry {
    if (!_dataAry) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

#pragma mark ====== 移除通知 ======
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
