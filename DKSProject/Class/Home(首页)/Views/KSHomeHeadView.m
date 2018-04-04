//
//  KSHomeHeadView.m
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeHeadView.h"
#import "KSButton.h"

@interface KSHomeHeadView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) KSButton *moreBtn;

@end

@implementation KSHomeHeadView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(10);
        }];
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.right.equalTo(self.mas_right);
        }];
    }
    return self;
}

- (void)setModel:(KSHomeModel *)model {
    if (model) {
        _model = model;
        self.titleLabel.text = model.opt_name;
    }
}

#pragma mark ====== 查看全部 ======
- (void)lookMore:(UIButton *)btn {
    if (self.btnBlock) {
        self.btnBlock();
    }
}

#pragma mark ====== init ======
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor ks_backColor];
        _titleLabel.font = [UIFont systemFontOfSize:Font_Middle];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (KSButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [KSButton buttonWithType:UIButtonTypeCustom withSpace:8];
        _moreBtn.buttonStyle = KSButtonImageRight;
        [_moreBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Little];
        [_moreBtn addTarget:self action:@selector(lookMore:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn setTitleColor:[UIColor ks_grayTextColor] forState:UIControlStateNormal];
        [self addSubview:_moreBtn];
    }
    return _moreBtn;
}

- (void)setBtnBlock:(BtnBlock)btnBlock {
    if (btnBlock) {
        _btnBlock = btnBlock;
    }
}

@end
