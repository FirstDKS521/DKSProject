//
//  KSLoginView.m
//  DKSProject
//
//  Created by aDu on 2018/3/16.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSLoginView.h"

@interface KSLoginView ()

@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIView *wxView;
@property (nonatomic, strong) UIView *qqView;
@property (nonatomic, strong) UIView *wbView;

@end

@implementation KSLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews {
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@15);
    }];
    
    NSArray *viewsAry = @[self.wxView, self.qqView, self.wbView];
    [viewsAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:70 leadSpacing:20 tailSpacing:20];
    [viewsAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hintLabel.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@70);
    }];
}

#pragma mark ====== 登录方式 ======
- (void)wxLogin {
    UIViewController *vc = [self findParentController:self];
    [vc ks_toastProgress:@"登录中..." completBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:K_LoginStateChange object:@YES];
    }];
}

#pragma mark ====== init ======
- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [UILabel new];
        _hintLabel.text = @"其它登录方式";
        _hintLabel.font = [UIFont systemFontOfSize:Font_Little];
        _hintLabel.textColor = [UIColor ks_grayTextColor];
        [self addSubview:_hintLabel];
    }
    return _hintLabel;
}

- (UIView *)wxView {
    if (!_wxView) {
        _wxView = [[UIView alloc] init];
        [self addImgAndLabel:_wxView imageName:@"weixin_icon" titleStr:@"微信登录"];
        [_wxView addTarget:self action:@selector(wxLogin)];
        [self addSubview:_wxView];
    }
    return _wxView;
}

- (UIView *)qqView {
    if (!_qqView) {
        _qqView = [[UIView alloc] init];
        [self addImgAndLabel:_qqView imageName:@"qq_icon" titleStr:@"QQ登录"];
        [_qqView addTarget:self action:@selector(wxLogin)];
        [self addSubview:_qqView];
    }
    return _qqView;
}

- (UIView *)wbView {
    if (!_wbView) {
        _wbView = [[UIView alloc] init];
        [self addImgAndLabel:_wbView imageName:@"weibo_icon" titleStr:@"微博登录"];
        [_wbView addTarget:self action:@selector(wxLogin)];
        [self addSubview:_wbView];
    }
    return _wbView;
}

- (void)addImgAndLabel:(UIView *)view imageName:(NSString *)name titleStr:(NSString *)title {
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:name];
    [view addSubview:imageView];

    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = [UIColor ks_backColor];
    label.font = [UIFont systemFontOfSize:Font_Little];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(10);
        make.left.equalTo(view.mas_left).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.height.equalTo(imageView.mas_width);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(view);
        make.top.equalTo(imageView.mas_bottom);
    }];
}

@end
