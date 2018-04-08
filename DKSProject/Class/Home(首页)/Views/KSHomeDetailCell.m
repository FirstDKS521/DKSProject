//
//  KSHomeDetailCell.m
//  DKSProject
//
//  Created by aDu on 2018/3/28.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeDetailCell.h"
#import <UIImageView+WebCache.h>

@interface KSHomeDetailCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation KSHomeDetailCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.contentView);
        make.height.equalTo(self.imgView.mas_width);
    }];
    
    self.titleLabel.preferredMaxLayoutWidth = self.width - 16;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.top.equalTo(self.imgView.mas_bottom).offset(5);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

- (void)setModel:(KSHomeDetailModel *)model {
    if (model) {
        _model = model;
        [self.imgView sd_setImageWithURL:model.hd_thumb_url];
        self.titleLabel.text = model.goods_name;
        float money = model.price / 100.0;
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%1g", money];
        if (model.cnt < 10000) {
            self.stateLabel.text = [NSString stringWithFormat:@"已拼%@件", @(model.cnt)];
        } else {
            if (model.cnt / 10000 > 10) {
                self.stateLabel.text = [NSString stringWithFormat:@"已拼%@万件", @(model.cnt / 10000)];
            } else {
                double cnt = model.cnt / 10000.0;
                self.stateLabel.text = [NSString stringWithFormat:@"已拼%.1f万件", cnt];
            }
        }
    }
}

#pragma mark ====== init ======
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor ks_backColor];
        _titleLabel.font = [UIFont systemFontOfSize:Font_Little];
        //以字符为显示单位显示，后面部分省略不显示
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont systemFontOfSize:Font_Middle];
        [self.contentView addSubview:_moneyLabel];
    }
    return _moneyLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.textColor = [UIColor ks_grayTextColor];
        _stateLabel.font = [UIFont systemFontOfSize:Font_Little];
        [self.contentView addSubview:_stateLabel];
    }
    return _stateLabel;
}

@end
