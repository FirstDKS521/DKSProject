//
//  KSMineCell.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMineCell.h"

@interface KSMineCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KSMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(8);
            make.left.equalTo(self.contentView.mas_left).offset(16);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
            make.width.equalTo(self.imgView.mas_height);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}

- (void)setModel:(KSMineOrderModel *)model {
    if (model) {
        _model = model;
        _imgView.image = [UIImage imageNamed:model.imgName];
        _titleLabel.text = model.title;
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
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
