//
//  KSChatController.m
//  DKSProject
//
//  Created by aDu on 2018/4/10.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSChatController.h"
#import "KSChatRTextCell.h"
#import "KSChatRTextModel.h"
#import "KSKeyboardView.h"

static CGFloat textViewHeight = 52;
@interface KSChatController ()<KSKeyboardDelegate>

@property (nonatomic, strong) KSChatRTextCell *textCell;
@property (nonatomic, strong) KSKeyboardView *keyView;

@end
static NSString *kCell = @"cell";
@implementation KSChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataAry = @[@{@"msg":@"春眠不觉晓，哈欠上门找，晚上睡不着，白天醒不了。"},
                     @{@"msg":@"路见不平一声吼，吼完接着走~"},
                     @{@"msg":@"别人夸我太帅气，我夸别人好眼力。"}].mutableCopy;
    [self setTableView];
    //给UITableView添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.delegate = self;
    [self.tableView addGestureRecognizer:tapGesture];
    
    //添加输入框
    self.keyView = [[KSKeyboardView alloc] initWithFrame:CGRectMake(0, Screen_Height - StatusNav_Height - textViewHeight, Screen_Width, textViewHeight)];
    //设置代理方法
    _keyView.delegate = self;
    [self.view addSubview:_keyView];
}

#pragma mark ====== UITableViewDelegate ======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

//cell行高计算
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSChatRTextModel *model = [KSChatRTextModel modelWithJSON:self.dataAry[indexPath.row]];
    if (model.cellHeight == 0) {
        CGFloat cellHeight = [self.textCell cellHeight:model];
        model.cellHeight = cellHeight;
        return cellHeight;
    } else {
        return model.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSChatRTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    KSChatRTextModel *model = [KSChatRTextModel modelWithJSON:self.dataAry[indexPath.row]];
    [cell setModel:model];
    return cell;
}

#pragma mark ====== DKSKeyboardDelegate ======
//发送的文案
- (void)textViewContentText:(NSString *)textStr {
    [self.dataAry addObject:@{@"msg":textStr}];
    [self.tableView reloadData];
    [self scrollToBottom];
}

//keyboard的frame改变
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY {
    [self scrollToBottom];
    // 获取对应cell的rect值（其值针对于UITableView而言）
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.dataAry.count - 1 inSection:0];
    CGRect rect = [self.tableView rectForRowAtIndexPath:lastIndex];
    CGFloat lastMaxY = rect.origin.y + rect.size.height;
    //如果最后一个cell的最大Y值大于tableView的高度
    if (lastMaxY <= self.tableView.height) {
        if (lastMaxY >= minY) {
            self.tableView.top = minY - lastMaxY;
        } else {
            self.tableView.top = 0;
        }
    } else {
        self.tableView.top += minY - self.tableView.bottom;
    }
}

#pragma mark ====== UITableView滚动到底部 ======
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollToBottom];
}

- (void)scrollToBottom {
    if (self.dataAry.count >= 1) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:MAX(0, self.dataAry.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

#pragma mark ====== 点击UITableView ======
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //收回键盘
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardHide" object:nil];
    //若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

#pragma mark ====== init ======
- (void)setTableView {
    self.tableView.height = Screen_Height - StatusNav_Height - textViewHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[KSChatRTextCell class] forCellReuseIdentifier:kCell];
    self.textCell = [[KSChatRTextCell alloc] initWithStyle:0 reuseIdentifier:kCell];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = NO;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
}

@end
