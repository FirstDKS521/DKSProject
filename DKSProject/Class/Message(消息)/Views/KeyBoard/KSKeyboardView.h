//
//  KSKeyboardView.h
//  DKSProject
//
//  Created by aDu on 2018/4/11.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KSKeyboardDelegate <NSObject>

@optional //非必实现的方法

/**
 点击发送时输入框内的文案
 @param textStr 文案
 */
- (void)textViewContentText:(NSString *)textStr;

/**
 键盘的frame改变
 */
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY;

@end

@interface KSKeyboardView : UIView<UITextViewDelegate>

@property (nonatomic, weak) id <KSKeyboardDelegate>delegate;

@end
