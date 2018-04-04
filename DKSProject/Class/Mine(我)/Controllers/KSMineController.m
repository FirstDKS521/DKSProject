//
//  KSMineController.m
//  DKSProject
//
//  Created by aDu on 2018/3/18.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMineController.h"
#import "KSMineHeadView.h"
#import "KSTableHeaderView.h"
#import "KSMineNavView.h"
#import "KSMineOrderModel.h"
#import "KSMineFirstCell.h"
#import "KSMineCell.h"

#define K_Fell @"fell"
#define K_Cell @"cell"
#define K_Oell @"oell"
@interface KSMineController () {
    CGFloat alpha;
}

@property (nonatomic, assign) CGFloat imgHeight;
@property (nonatomic, strong) KSMineHeadView *headView;
@property (nonatomic, strong) KSTableHeaderView *headerView;
@property (nonatomic, strong) KSMineNavView *navView;
@property (nonatomic, strong) NSMutableDictionary *dicH;

@end

@implementation KSMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideNavBar = YES;
    
    [self setTableView];
    [self addNavagitonView];
    [self initStretchHeaderView];
    self.dataAry = [@[@{@"title": @"钱包", @"imgName": @"mine_wallet"},
                      @{@"title": @"积分商城", @"imgName": @"mine_shop"},
                      @{@"title": @"优惠券", @"imgName": @"mine_ticket"},
                      @{@"title": @"我的收藏", @"imgName": @"mine_collect"},
                      @{@"title": @"我的足迹", @"imgName": @"mine_foot"}] mutableCopy];
}

- (void)initStretchHeaderView {
    self.headerView = [KSTableHeaderView new];
    [self.headerView stretchHeaderForTableView:self.tableView withView:self.headView];
}

#pragma mark ====== 添加自定义的导航栏 ======
- (void)addNavagitonView {
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.equalTo(@(StatusNav_Height));
    }];
}

#pragma mark ====== UITableViewDelegate ======
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return self.dataAry.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            NSNumber *num = self.dicH[indexPath];
            return [num floatValue];
        }
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [tableView registerClass:[KSMineFirstCell class] forCellReuseIdentifier:K_Fell];
            KSMineFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:K_Fell];
            return cell;
        } else {
            [tableView registerClass:[KSMineOtherCell class] forCellReuseIdentifier:K_Oell];
            KSMineOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:K_Oell];
            cell.delegate = self;
            cell.indexPath = indexPath;
            return cell;
        }
    } else {
        [tableView registerClass:[KSMineCell class] forCellReuseIdentifier:K_Cell];
        KSMineCell *cell = [tableView dequeueReusableCellWithIdentifier:K_Cell];
        KSMineOrderModel *model = [KSMineOrderModel modelWithJSON:self.dataAry[indexPath.row]];
        cell.model = model;
        return cell;
    }
}

#pragma mark ====== RootTableCellDelegate ======
- (void)updateTableViewCellHeight:(KSMineOtherCell *)cell andHeight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
        self.dicH[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

#pragma mark ====== 放大缩小图片 ======
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView scrollViewDidScroll:scrollView];
    CGFloat offset = scrollView.contentOffset.y ;
    if (offset >= 0) {
        alpha = fabs((offset) / (self.imgHeight - StatusNav_Height));
        alpha = alpha >= 1 ? 1 : alpha;
        self.navView.backgroundColor = [UIColor ks_colorWithString:@"#349B97" alpha:alpha];
    } else {
        self.navView.backgroundColor = [UIColor clearColor];
    }
}

- (void)viewDidLayoutSubviews {
    [self.headerView resizeView];
}

#pragma mark ====== init ======
- (void)setTableView {
    self.tableView.height = Screen_Height - TabBar_Height;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
}

- (KSMineHeadView *)headView {
    if (!_headView) {
        _headView = [[KSMineHeadView alloc] init];
        UIImage *img = [UIImage imageNamed:@"mine_head"];
        self.imgHeight = img.size.height * Screen_Width / img.size.width;
        _headView.frame = CGRectMake(0, 0, Screen_Width, _imgHeight);
    }
    return _headView;
}

- (KSMineNavView *)navView {
    if (!_navView) {
        _navView = [KSMineNavView new];
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (NSMutableDictionary *)dicH {
    if (!_dicH) {
        _dicH = [[NSMutableDictionary alloc] init];
    }
    return _dicH;
}

@end
