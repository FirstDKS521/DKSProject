//
//  KSMineNavView.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMineNavView.h"
#import "KSSetupController.h"

@interface KSMineNavView ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation KSMineNavView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(StatusBar_Height);
            make.bottom.equalTo(self.mas_bottom);
        }];

        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(StatusBar_Height);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@60);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}

#pragma mark ====== 设置按钮 ======
- (void)toSetupPage:(UIButton *)btn {
    KSSetupController *setupVC = [KSSetupController new];
    UIViewController *vc = [self findParentController:self];
    [vc.navigationController pushViewController:setupVC animated:YES];
}

#pragma mark ====== init ======
- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.text = @"我";
        _title.font = [UIFont systemFontOfSize:19];
        _title.textColor = [UIColor whiteColor];
        [self addSubview:_title];
    }
    return _title;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"设置" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Middle];
        [_rightBtn addTarget:self action:@selector(toSetupPage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

@end
