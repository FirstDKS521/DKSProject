//
//  KSSearchBar.m
//  DKSProject
//
//  Created by aDu on 2018/4/9.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSSearchBar.h"

@interface KSSearchBar ()

@property (nonatomic, strong) UIButton *voiceButton;
// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end
//icon宽度
static CGFloat const searchIconW = 20.0;
@implementation KSSearchBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @" 搜索";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置背景图片
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    //设置右边背景图片
    self.showsBookmarkButton = YES;
    UIImage *searchIcon = [UIImage imageNamed:@"search_voice"];
    [self setImage:searchIcon forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    for (UIView *view in [self.subviews lastObject].subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            field.placeholder = @"搜索";
            field.frame = CGRectMake(0, 5, self.width, self.height - 10);
            [field setBackgroundColor:[UIColor whiteColor]];
            field.textColor = [UIColor ks_backColor];
            field.tintColor = [UIColor ks_mainColor];
            
            field.borderStyle = UITextBorderStyleNone;
            field.layer.cornerRadius = 4.0f;
            field.layer.masksToBounds = YES;
            
            // 设置占位文字字体颜色
            [field setValue:[UIColor ks_grayTextColor] forKeyPath:@"_placeholderLabel.textColor"];
            [field setValue:[UIFont systemFontOfSize:Font_Middle] forKeyPath:@"_placeholderLabel.font"];
            //placeholder居中的方法
            if (@available(iOS 11.0, *)) {
                [[self.heightAnchor constraintEqualToConstant:Nav_Height] setActive:YES];
            } else {
                [self setLeftPlaceholder];
            }
        }
    }
}

// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Font_Middle]} context:nil].size;
        _placeholderWidth = size.width + searchIconW;
    }
    return _placeholderWidth;
}

#pragma mark ====== UISearchBarDelegate ======
//开始编辑的时候重置为靠左
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    return YES;
}

//结束编辑的时候设置为居中
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    //如果搜索框里面没有内容，编辑结束居中显示
    if (textField.text.length == 0) {
        [self setPositionAdjustment:UIOffsetMake((textField.width-self.placeholderWidth) / 2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}

//使placeholder居中
- (void)setLeftPlaceholder {
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

#pragma mark ====== 回收键盘 ======
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
