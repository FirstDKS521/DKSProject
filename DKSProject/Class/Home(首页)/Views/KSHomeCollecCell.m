//
//  KSHomeCollecCell.m
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeCollecCell.h"
#import <UIImageView+WebCache.h>

@interface KSHomeCollecCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KSHomeCollecCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.equalTo(self.imgView.mas_width);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.imgView.mas_bottom).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)setChilerenModel:(KSHomeChildrenModel *)chilerenModel {
    if (chilerenModel) {
        _chilerenModel = chilerenModel;
        self.titleLabel.text = chilerenModel.opt_name;
        [self.imgView sd_setImageWithURL:chilerenModel.image_url];
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
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
