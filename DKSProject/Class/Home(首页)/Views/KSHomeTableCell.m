//
//  KSHomeTableCell.m
//  DKSProject
//
//  Created by aDu on 2018/3/27.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeTableCell.h"

@interface KSHomeTableCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KSHomeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.lineView.hidden = NO;
        self.titleLabel.textColor = [UIColor ks_mainColor];
        self.lineView.backgroundColor = [UIColor ks_mainColor];
    } else {
        self.lineView.hidden = YES;
        self.titleLabel.textColor = [UIColor ks_titleColor];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor ks_backgroundColor];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(self.height / 2);
            make.width.equalTo(@2);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
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

#pragma mark ====== init ======
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor ks_mainColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor ks_titleColor];
        _titleLabel.font = [UIFont systemFontOfSize:Font_Middle];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
