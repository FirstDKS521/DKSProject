//
//  KSSetupController.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSSetupController.h"
#import "KSClearCache.h"
#import "KSAlertView.h"
#import "KSSetupCell.h"

@interface KSSetupController ()

@property (nonatomic, strong) UIButton *logoutBtn;

@end

@implementation KSSetupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    self.dataAry = [@[@[@"账号管理", @"安全中心", @"支付设置"],
                      @[@"缓存", @"消息通知", @"隐私", @"通用", @"关于我们"]] mutableCopy];
    [self setTableView];
}

#pragma mark ====== UITableViewDelegate ======
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataAry[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 70;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *footView = [UIView new];
        [footView addSubview:self.logoutBtn];
        [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(footView);
            make.top.equalTo(footView.mas_top).offset(20);
            make.height.equalTo(@40);
        }];
        return footView;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSSetupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setValue:self.dataAry forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self clearCache:indexPath];
        }
    }
}

#pragma mark ====== 退出登录 ======
- (void)logoutMethod {
    [KSAlertView showAlertWithTitle:nil message:@"是否确定退出登录" cancleButtonTitle:@"取消" otherButtonTitle:@"确定" clickAtIndex:^(NSInteger buttonIndex) {
        if (buttonIndex) {
            [[NSNotificationCenter defaultCenter] postNotificationName:K_LoginStateChange object:@NO];
        }
    }];
}

#pragma mark ====== 清理缓存 ======
- (void)clearCache:(NSIndexPath *)indexPath {
    __weak typeof(self) ws = self;
    [KSAlertView showAlertWithTitle:@"是否确定清理缓存" message:nil cancleButtonTitle:@"取消" otherButtonTitle:@"确定" clickAtIndex:^(NSInteger buttonIndex) {
        if (buttonIndex) {
            [KSClearCache clearCache:^{
                [ws.tableView reloadRow:indexPath.row inSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }];
}

#pragma mark ====== init ======
- (void)setTableView {
    self.tableView.height = Screen_Height - StatusNav_Height;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[KSSetupCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
}

- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.backgroundColor = [UIColor whiteColor];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor ks_backColor] forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Large];
        [_logoutBtn addTarget:self action:@selector(logoutMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}

@end
