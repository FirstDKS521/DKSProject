//
//  KSChatRTextCell.h
//  DKSProject
//
//  Created by aDu on 2018/4/10.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSChatBaseCell.h"
#import "KSChatRTextModel.h"

@interface KSChatRTextCell : KSChatBaseCell

@property (nonatomic, strong) KSChatRTextModel *model;

/**
 计算行高
 */
- (CGFloat)cellHeight:(KSChatRTextModel *)model;

@end
