//
//  KSChatEmojiView.m
//  DKSProject
//
//  Created by aDu on 2018/4/11.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSChatEmojiView.h"

@implementation KSChatEmojiView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [UILabel new];
        label.text = @"😁";
        label.frame = CGRectMake(30, 20, 30, 30);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end
