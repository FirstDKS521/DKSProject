//
//  KSMessageCell.m
//  DKSProject
//
//  Created by aDu on 2018/4/9.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMessageCell.h"
#import "KSImageRadius.h"

@interface KSMessageCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation KSMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.width.equalTo(self.imgView.mas_height);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(5);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(-3);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(5);
            make.top.equalTo(self.contentView.mas_centerY).offset(3);
            make.right.equalTo(self.contentView.mas_right).offset(-30);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
    }
    return self;
}

- (void)setModel:(KSMessageModel *)model {
    if (model) {
        self.imgView.image = [UIImage imageNamed:model.headImg];
        self.titleLabel.text = model.title;
        self.contentLabel.text = model.msg;
        int a = [self getRandomNumber:10 to:24];
        int b = [self getRandomNumber:10 to:59];
        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@", @(a), @(b)];
    }
}

- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

#pragma mark ====== init ======
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.cornerRadius = 4;
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor ks_titleColor];
        _titleLabel.font = [UIFont systemFontOfSize:Font_Large];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor ks_grayTextColor];
        _contentLabel.font = [UIFont systemFontOfSize:Font_Middle];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = [UIColor ks_grayTextColor];
        _timeLabel.font = [UIFont systemFontOfSize:Font_Little];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

@end
