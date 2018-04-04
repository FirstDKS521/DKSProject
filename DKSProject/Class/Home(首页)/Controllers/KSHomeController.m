//
//  KSHomeController.m
//  DKSProject
//
//  Created by aDu on 2018/3/18.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeController.h"
#import "KSHomeDetailController.h"
#import "KSHomeTableCell.h"
#import "KSHomeCollecCell.h"
#import "KSHomeHeadView.h"
#import "KSHomeModel.h"
#import "KSHomeUrl.h"

#define Left_Cell @"leftCell"
#define Right_Cell @"rightCell"
#define Head_View @"headView"
@interface KSHomeController ()

@property (nonatomic, assign) BOOL isScrollDown; //滑动方向

@end

@implementation KSHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
    [self loadNewData];
}

#pragma mark ====== 加载数据 ======
- (void)loadNewData {
    __weak __typeof(self) ws = self;
    NSDictionary *paraDic = @{@"pdduid": @"6344734573"};
    [PPNetworkHelper POST:[KSHomeUrl getHomePageUrl] parameters:paraDic responseCache:^(id responseCache) {
        [ws resultData:responseCache];
    } success:^(id responseObject) {
        [ws resultData:responseObject];
    } failure:^(NSError *error) {
        [self ks_toastString:@"网络不给力"];
    }];
}

- (void)resultData:(id)responseObject {
    [self.dataAry removeAllObjects];
    __weak __typeof(self) ws = self;
    for (NSDictionary *dic in responseObject) {
        KSHomeModel *model = [KSHomeModel modelWithJSON:dic];
        [ws.dataAry addObject:model];
    }
    [ws.tableView reloadData];
    [ws.collectionView reloadData];
    [ws defaultSelectFirstRow];
}

#pragma mark ====== 默认选中第一行 ======
- (void)defaultSelectFirstRow {
    if (self.dataAry.count) {
        //默认选中第一行
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

#pragma mark ====== UITableViewDelegate ======
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Left_Cell forIndexPath:indexPath];
    cell.model = self.dataAry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [self collectionViewScrollToIndexPath:indexPath];
}

#pragma mark ====== 解决CollectionView区头视图被隐藏的问题 ======
- (void)collectionViewScrollToIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *rIndexPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];//获取要滚动的区
    //获取此区的布局属性
    UICollectionViewLayoutAttributes *att = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:rIndexPath];
    //滚动位置
    CGPoint top = CGPointMake(0, att.frame.origin.y - self.collectionView.contentInset.top);
    //如果需要滚动到的区域+CollectionView的高度大于CollectionView的contentSize.height
    if ((top.y + self.collectionView.frame.size.height) > self.collectionView.contentSize.height) {
        CGPoint offset = CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height);
        //collectionView滚动到底部
        [self.collectionView setContentOffset:offset animated:YES];
    } else {
        //collectionView滚动到相应的位置
        [self.collectionView setContentOffset:top animated:YES];
    }
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    KSHomeModel *model = self.dataAry[section];
    return model.children.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    KSHomeHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:Head_View forIndexPath:indexPath];
    KSHomeModel *model = self.dataAry[indexPath.section];
    headView.model = model;
    __weak __typeof(self) ws = self;
    [headView setBtnBlock:^{
        [ws jumpDetailPage:model.opt_id title:model.opt_name];
    }];
    return headView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSHomeCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Right_Cell forIndexPath:indexPath];
    KSHomeModel *model = self.dataAry[indexPath.section];
    KSHomeChildrenModel *childrenModel = model.children[indexPath.row];
    cell.chilerenModel = childrenModel;
    return cell;
}

#pragma mark ====== 点击Item ======
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KSHomeModel *model = self.dataAry[indexPath.section];
    KSHomeChildrenModel *childrenModel = model.children[indexPath.row];
    [self jumpDetailPage:childrenModel.aId title:childrenModel.opt_name];
}

#pragma mark ====== 进入详情页面 ======
- (void)jumpDetailPage:(NSInteger)aId title:(NSString *)opt_name {
    KSHomeDetailController *detailVC = [KSHomeDetailController new];
    detailVC.opt_id = aId;
    detailVC.title = opt_name;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark ====== collectionView区头视图将要展示 ======
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    //主要判断collectionView用户拖拽而滚动的，还是点击TableView而滚动的
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating)) { //向下滚动
        if (indexPath.section == 0) {
            [self selectRowAtIndexPath:indexPath.section];
        } else {
            [self selectRowAtIndexPath:indexPath.section - 1];
        }
    }
}

#pragma mark ====== 视图将要展示结束 向上滚动 ======
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == (self.dataAry.count - 1)) {
        return;
    }
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

//当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark ====== UIScrollViewDelegate ======
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        return;
    }
    static float lastOffSetY = 0;
    self.isScrollDown = lastOffSetY < scrollView.contentOffset.y;
    lastOffSetY = scrollView.contentOffset.y;
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    //滚动到底部
    if (bottomOffset < height) {
        [self selectRowAtIndexPath:self.dataAry.count - 1];
    }
}

#pragma mark ====== init ======
- (void)setUpCollectionView {
    CGFloat width = (Screen_Width * 0.7 - 41) / 3;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(width, width + 20);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(0, 30);
    
    self.collectionView.frame = CGRectMake(Screen_Width * 0.3, 0, Screen_Width * 0.7, Screen_Height - StatusNav_Height - TabBar_Height);
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[KSHomeCollecCell class] forCellWithReuseIdentifier:Right_Cell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.mj_footer.hidden = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[KSHomeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Head_View];
    [self.view addSubview:self.collectionView];
    
    self.tableView.frame = CGRectMake(0, 0, Screen_Width * 0.3, Screen_Height - StatusNav_Height - TabBar_Height);
    [self.tableView registerClass:[KSHomeTableCell class] forCellReuseIdentifier:Left_Cell];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

@end
