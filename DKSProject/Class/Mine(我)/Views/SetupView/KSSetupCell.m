//
//  KSSetupCell.m
//  DKSProject
//
//  Created by aDu on 2018/4/4.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSSetupCell.h"
#import "KSClearCache.h"

@interface KSSetupCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UISwitch *aSwitch;

@end

@implementation KSSetupCell

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
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(16);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.aSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}

- (void)setValue:(NSArray *)dataAry forIndexPath:(NSIndexPath *)indexPath {
    NSString *title = dataAry[indexPath.section][indexPath.row];
    self.titleLabel.text = title;
    if ([title isEqualToString:@"缓存"]) {
        self.contentLabel.hidden = NO;
        self.contentLabel.text = [NSString stringWithFormat:@"%.2fM", [KSClearCache folderSizeAtPath]];
    } else {
        self.contentLabel.hidden = YES;
    }
    if ([title isEqualToString:@"消息通知"]) {
        self.aSwitch.hidden = NO;
    } else {
        self.aSwitch.hidden = YES;
    }
}

#pragma mark ====== init ======
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor ks_titleColor];
        _titleLabel.font = [UIFont systemFontOfSize:Font_Middle];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor ks_grayTextColor];
        _contentLabel.hidden = YES;
        _contentLabel.font = [UIFont systemFontOfSize:Font_Little];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UISwitch *)aSwitch {
    if (!_aSwitch) {
        _aSwitch = [UISwitch new];
        _aSwitch.hidden = YES;
        _aSwitch.on = YES;
        _aSwitch.onTintColor = [UIColor ks_mainColor];
        [self.contentView addSubview:_aSwitch];
    }
    return _aSwitch;
}

@end
