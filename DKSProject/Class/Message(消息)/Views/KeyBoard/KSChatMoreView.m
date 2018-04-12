//
//  KSChatMoreView.m
//  DKSProject
//
//  Created by aDu on 2018/4/11.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSChatMoreView.h"
#import "KSImageRadius.h"

@implementation KSChatMoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(16, 10, 50, 50);
        imageView.image = [UIImage imageNamed:@"photoImg"];
        imageView.cornerRadius = 6;
        [self addSubview:imageView];
        
        UILabel *label = [UILabel new];
        label.text = @"拍照";
        label.frame = CGRectMake(imageView.left, imageView.bottom + 5, imageView.width, 25);
        label.font = [UIFont systemFontOfSize:Font_Middle];
        label.textColor = [UIColor ks_backColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end
