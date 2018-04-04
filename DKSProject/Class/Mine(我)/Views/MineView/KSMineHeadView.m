//
//  KSMineHeadView.m
//  DKSProject
//
//  Created by aDu on 2018/4/2.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMineHeadView.h"

@implementation KSMineHeadView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"mine_head"];
        //按比例填充，很关键
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

@end
