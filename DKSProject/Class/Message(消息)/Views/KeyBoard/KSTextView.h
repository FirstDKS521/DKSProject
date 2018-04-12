//
//  KSTextView.h
//  DKSProject
//
//  Created by aDu on 2018/4/11.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <YYKit/YYKit.h>

typedef void(^TextHeightChangedBlock)(CGFloat textHeight);
@interface KSTextView : UITextView

/**
 *  textView最大行数
 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/**
 文字大小
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, strong) TextHeightChangedBlock textChangedBlock;

- (void)textValueDidChanged:(TextHeightChangedBlock)block;

@end
