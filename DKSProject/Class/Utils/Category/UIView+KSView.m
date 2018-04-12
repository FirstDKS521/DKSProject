//
//  UIView+KSView.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "UIView+KSView.h"
#import <objc/runtime.h>

NSString const *blockTapKey = @"tapKey";
@implementation UIView (KSView)

- (void)addTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled = YES;
    /**
     *  添加相同事件方法，先将原来的事件移除，避免重复调用
     */
    NSMutableArray *taps = [self allUIViewBlockTaps];
    [taps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)obj;
        [self removeGestureRecognizer:tap];
    }];
    [taps removeAllObjects];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    [taps addObject:tap];
}

- (NSMutableArray *)allUIViewBlockTaps
{
    NSMutableArray *taps = objc_getAssociatedObject(self, &blockTapKey);
    if (!taps) {
        taps = [NSMutableArray array];
        objc_setAssociatedObject(self, &blockTapKey, taps, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return taps;
}

- (UIViewController *)findParentController:(UIView *)currentView
{
    for (UIView *next = [currentView superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//添加完成按钮
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
    toolbar.tintColor = [UIColor ks_mainColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

- (void)textFieldDone
{
    [self endEditing:YES];
}

- (void)label:(UILabel *)label text:(NSString *)text color:(UIColor *)color startLocal:(NSInteger)local endLocal:(NSInteger)end
{
    NSRange range = NSMakeRange(local, text.length - local - end);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    label.attributedText = str;
}

- (void)label:(UILabel *)label text:(NSString *)text color:(UIColor *)color startLocal:(NSInteger)local length:(NSInteger)length
{
    NSRange range = NSMakeRange(local, length);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    label.attributedText = str;
}

//UITextField的左视图
- (void)textFieldLeftView:(UITextField *)leftField {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 40)];
    leftField.leftView = view;
    leftField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark ====== 设置行间距 ======
- (void)setLabelLineSpacing:(CGFloat)space label:(UILabel *)label textStr:(NSString *)str {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = space;
    NSDictionary *dic = @{NSParagraphStyleAttributeName:style,
                          NSFontAttributeName:label.font,
                          NSStrokeColorAttributeName:label.textColor};
    [attributedString setAttributes:dic range:NSMakeRange(0, str.length)];
    label.attributedText = attributedString;
}

@end
