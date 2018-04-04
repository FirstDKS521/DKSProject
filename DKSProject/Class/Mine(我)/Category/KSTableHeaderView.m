//
//  KSTableHeaderView.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSTableHeaderView.h"

@interface KSTableHeaderView ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *view;

@end

@implementation KSTableHeaderView
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}

- (void)stretchHeaderForTableView:(UITableView *)tableView withView:(UIView *)view {
    self.tableView = tableView;
    self.view = view;
    
    initialFrame = view.frame;
    defaultViewHeight = initialFrame.size.height;
    
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    self.tableView.tableHeaderView = emptyTableHeaderView;
    [_tableView addSubview:_view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect f = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame = f;
    
    if (scrollView.contentOffset.y < 0) {
        CGFloat offsety = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        initialFrame.origin.y = -offsety * 1;
        initialFrame.origin.x = -offsety / 2;
        
        initialFrame.size.width = _tableView.frame.size.width + offsety;
        initialFrame.size.height = defaultViewHeight + offsety;
        
        _view.frame = initialFrame;
    }
}

- (void)resizeView {
    initialFrame.size.width = _tableView.frame.size.width;
    _view.frame = initialFrame;
}

@end
