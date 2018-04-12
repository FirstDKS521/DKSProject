//
//  KSChatRTextCell.m
//  DKSProject
//
//  Created by aDu on 2018/4/10.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSChatRTextCell.h"
#import "KSImageRadius.h"

@interface KSChatRTextCell ()

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UIImageView *bubbleImg;
@property (nonatomic, strong) YYLabel *msgLabel;

@end

@implementation KSChatRTextCell

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
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.bubbleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.headImg.mas_left).offset(-3);
        }];
        
        self.msgLabel.preferredMaxLayoutWidth = Screen_Width - 150;
        [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bubbleImg).insets(UIEdgeInsetsMake(10, 14, 18, 13));
        }];
    }
    return self;
}

- (void)setModel:(KSChatRTextModel *)model {
    if (model) {
        _model = model;
        self.msgLabel.text = model.msg;
        [self setLabelLineSpacing:3 label:(UILabel *)self.msgLabel textStr:model.msg];
    }
}

- (CGFloat)cellHeight:(KSChatRTextModel *)model {
    [self setModel:model];
    [self layoutIfNeeded];
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height + 1;
    return cellHeight;
}

#pragma mark ====== init ======
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [UIImageView new];
        _headImg.image = [UIImage imageNamed:@"msg_dudage"];
        [self.contentView addSubview:_headImg];
    }
    return _headImg;
}

- (UIImageView *)bubbleImg {
    if (!_bubbleImg) {
        _bubbleImg = [UIImageView new];
        //保证图片不被拉伸的区域：左边的宽度、上边的高度
        _bubbleImg.image = [[UIImage imageNamed:@"chat_rtext"] stretchableImageWithLeftCapWidth:10 topCapHeight:30];
        [self.contentView addSubview:_bubbleImg];
    }
    return _bubbleImg;
}

- (YYLabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [YYLabel new];
        _msgLabel.numberOfLines = 0;
        _msgLabel.textColor = [UIColor ks_titleColor];
        _msgLabel.font = [UIFont systemFontOfSize:Font_Middle];
        [self.bubbleImg addSubview:_msgLabel];
    }
    return _msgLabel;
}

@end
