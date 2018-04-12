//
//  KSMessageController.m
//  DKSProject
//
//  Created by aDu on 2018/3/18.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMessageController.h"
#import "KSMsgSearchController.h"
#import "KSChatController.h"
#import "KSMessageCell.h"
#import "KSMessageModel.h"
#import "KSSearchBar.h"

//区头视图的高度
static CGFloat headHeight = 40.0f;
@interface KSMessageController ()

@property (nonatomic, strong) KSMsgSearchController *msgSearchVC;
@property (nonatomic, strong) KSSearchBar *searchBar;

@end

@implementation KSMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataAry = @[@{@"headImg":@"msg_dudage", @"title":@"杜大哥",
                       @"msg":@"晚上约不约"},
                     @{@"headImg":@"msg_head1", @"title":@"无须蔠有",
                       @"msg":@"微视频 | 中国开放大的大门不会关上"},
                     @{@"headImg":@"msg_head2", @"title":@"天王大哥",
                       @"msg":@"兄弟，你666啊"},
                     @{@"headImg":@"msg_head3", @"title":@"孟婆丶来碗汤",
                       @"msg":@"[语音通话]"},
                     @{@"headImg":@"msg_head4", @"title":@"一个演员",
                       @"msg":@"曾经有一份爱情摆在我的面前，我没有珍惜，直到失去后才追悔莫及"},
                     @{@"headImg":@"msg_head5", @"title":@"First灬DKS",
                       @"msg":@"今天加班吗小伙儿"},
                     @{@"headImg":@"msg_head6", @"title":@"情殇、为谁了",
                       @"msg":@"这里的化妆品质量非常好"},
                     @{@"headImg":@"msg_head7", @"title":@"~给力&浮云~",
                       @"msg":@"今晚网吧五连坐"},
                     @{@"headImg":@"msg_head8", @"title":@"無※所⭐️謂",
                       @"msg":@"小仙女的魔法棒~"}].mutableCopy;
    [self setTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.tableView setContentOffset:CGPointMake(0, headHeight) animated:NO];
    self.tableView.contentInset = UIEdgeInsetsMake(-headHeight, 0, 0, 0);
}

#pragma mark ====== UITableViewDelegate ======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self creatSearchView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    KSMessageModel *model = [KSMessageModel modelWithJSON:self.dataAry[indexPath.row]];
    cell.model = model;
    return cell;
}

/**
 * 这段代码主要是为了消除UITableView与底部留有的空白
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" "; //设置为空格
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KSMessageModel *model = [KSMessageModel modelWithJSON:self.dataAry[indexPath.row]];
    KSChatController *chatVC = [KSChatController new];
    chatVC.title = model.title;
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark ====== 创建搜素框 ======
- (UIView *)creatSearchView {
    UIView *headView = [UIView new];
    [headView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView).insets(UIEdgeInsetsMake(0, 8, 0, 8));
    }];
    UIView *clearView = [UIView new];
    [headView addSubview:clearView];
    [clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [clearView addTarget:self action:@selector(showSearchController)];
    return headView;
}

#pragma mark ====== UIScrollViewDelegate 优化输入框慢慢出现的情况 ======
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    if (y >= 0 && y <= headHeight / 2 && (!scrollView.dragging)) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else if (39 <= y && y <= 41) {
        self.tableView.contentInset = UIEdgeInsetsMake(-headHeight, 0, 0, 0);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat y = scrollView.contentOffset.y;
    if (y <= headHeight / 2) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark ====== 跳转到搜索页面 ======
- (void)showSearchController {
    KSMsgSearchController *searchVC = [KSMsgSearchController new];
    KSNavigationController *nav = [[KSNavigationController alloc] initWithRootViewController:searchVC];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark ====== init ======
- (void)setTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - StatusNav_Height - TabBar_Height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[KSMessageCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.tableView.sectionFooterHeight = 0.01;
//    self.tableView.estimatedRowHeight = 0;
//    self.tableView.estimatedSectionHeaderHeight = 0;
//    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}

- (KSSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [KSSearchBar new];
    }
    return _searchBar;
}

@end
