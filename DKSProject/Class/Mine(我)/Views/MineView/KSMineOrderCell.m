//
//  KSMineOrderCell.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMineOrderCell.h"

@interface KSMineOrderCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation KSMineOrderCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.imgView.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect frame = layoutAttributes.frame;
    frame.size.height = size.height;
    layoutAttributes.frame = frame;
    //计算出item的宽高
    if (self.delegaet && [self.delegaet respondsToSelector:@selector(updateCollectionViewHeight:)]) {
        [self.delegaet updateCollectionViewHeight:size.height];
    }
    return layoutAttributes;
}

- (void)setModel:(KSMineOrderModel *)model {
    if (model) {
        _model = model;
        _imgView.image = [UIImage imageNamed:model.imgName];
        _titleLabel.text = model.title;
        [self layoutIfNeeded];
        if (model.newCount > 0) {
            [_imgView showBadgeWithCount:model.newCount];
        } else {
            [_imgView hideBadge];
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
        _titleLabel.textColor = [UIColor ks_titleColor];
        _titleLabel.font = [UIFont systemFontOfSize:Font_Middle];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
