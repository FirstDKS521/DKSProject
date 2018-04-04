//
//  KSLoginController.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSLoginController.h"
#import "KSLoginView.h"

@interface KSLoginController ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *userField; //账号
@property (nonatomic, strong) UITextField *pwdField; //密码

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *jumpBtn;

@property (nonatomic, strong) KSLoginView *loginView;

@end

@implementation KSLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    [self layoutViews];
}

- (void)layoutViews {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
    }];
    
    [self.userField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(20);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.right.equalTo(self.backView.mas_right).offset(-16);
        make.height.equalTo(@40);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userField.mas_bottom).offset(20);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.right.equalTo(self.backView.mas_right).offset(-16);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-20);
        make.height.equalTo(@40);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@45);
    }];
    
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.height.equalTo(@90);
    }];
}

#pragma mark ====== 登录 ======
- (void)loginMethod {
    if (![KSCheckWordTool checkForMobilePhoneNo:self.userField.text]) {
        [self ks_toastString:@"手机号码有误"];
        return;
    }
    [self ks_toastProgress:@"登录中..." completBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:K_LoginStateChange object:@YES];
    }];
}

#pragma mark ====== 跳过登录 ======
- (void)jumpMethod {
    [[NSNotificationCenter defaultCenter] postNotificationName:K_LoginStateChange object:@YES];
}

#pragma mark ====== init ======
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.layer.borderWidth = 1;
        _backView.layer.borderColor = [UIColor ks_grayColor].CGColor;
        _backView.layer.cornerRadius = 4;
        [self.view addSubview:_backView];
    }
    return _backView;
}

- (UITextField *)userField {
    if (!_userField) {
        _userField = [[UITextField alloc] init];
        _userField.placeholder = @"手机号或邮箱账号";
        _userField.clearButtonMode = UITextFieldViewModeAlways;
        [self setFieldView:_userField];
        [self.backView addSubview:_userField];
    }
    return _userField;
}

- (UITextField *)pwdField {
    if (!_pwdField) {
        _pwdField = [[UITextField alloc] init];
        _pwdField.placeholder = @"输入密码";
        _pwdField.secureTextEntry = YES;
        [self setFieldView:_pwdField];
        [self.backView addSubview:_pwdField];
    }
    return _pwdField;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = [UIColor ks_mainColor];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 4;
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpBtn setTitleColor:[UIColor ks_mainColor] forState:UIControlStateNormal];
        _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Middle];
        [_jumpBtn setTitle:@"跳过登录" forState:UIControlStateNormal];
        [_jumpBtn addTarget:self action:@selector(jumpMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_jumpBtn];
    }
    return _jumpBtn;
}

- (KSLoginView *)loginView {
    if (!_loginView) {
        _loginView = [KSLoginView new];
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

- (void)setFieldView:(UITextField *)textField {
    [textField textFieldLeftView:textField];
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor ks_grayColor].CGColor;
    textField.layer.cornerRadius = 4;
    textField.font = [UIFont systemFontOfSize:Font_Middle];
    textField.inputAccessoryView = [_pwdField addToolbar];
}

@end
