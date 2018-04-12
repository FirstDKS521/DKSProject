//
//  KSMsgSearchController.m
//  DKSProject
//
//  Created by aDu on 2018/4/12.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMsgSearchController.h"
#import "KSSearchBar.h"

@interface KSMsgSearchController ()

@property (nonatomic, strong) KSSearchBar *searchBar;
@property (nonatomic, strong) UIButton *cancleBtn;

@end

@implementation KSMsgSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Nav_Height)];
    self.searchBar.frame = CGRectMake(0, 3, titleView.width - 60, titleView.height - 6);
    self.cancleBtn.frame = CGRectMake(_searchBar.right, _searchBar.top, titleView.width - _searchBar.right - 10, _searchBar.height);
    [titleView addSubview:self.searchBar];
    [titleView addSubview:self.cancleBtn];
    [self.navigationItem setTitleView:titleView];
    [self initTableView];
}

#pragma mark ====== UITableViewDelegate ======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行", @(indexPath.row)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark ====== UISearchBarDelegate ======
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

//点击话筒触发该方法
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    [KSAlertView showAlertWithTitle:@"" message:@"说话了亲~" cancleButtonTitle:@"取消" otherButtonTitle:@"确定" clickAtIndex:^(NSInteger buttonIndex) {
        
    }];
}

#pragma mark ====== 取消按钮 ======
- (void)cancleMethod {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark ====== init ======
- (void)initTableView {
    self.tableView.height = Screen_Height - StatusNav_Height;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
}

- (KSSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [KSSearchBar new];
        [_searchBar becomeFirstResponder];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Large];
        [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

@end
