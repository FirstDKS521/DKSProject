//
//  UIView+KSBrdge.m
//  DKSProject
//
//  Created by aDu on 2018/4/8.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "UIView+KSBrdge.h"
#import <objc/runtime.h>

static char badgeViewKey;
static NSInteger const pointWidth = 6; //小红点的宽高
static CGFloat const badgeFont = 9; //字体的大小
@implementation UIView (KSBrdge)

- (void)showBadge {
    if (self.badge == nil) {
        CGRect frame = CGRectMake(self.width - pointWidth / 2, -pointWidth / 2, pointWidth, pointWidth);
        self.badge = [[UILabel alloc] initWithFrame:frame];
        self.badge.backgroundColor = [UIColor ks_redColor];
        //圆角为宽度的一半
        self.badge.layer.cornerRadius = pointWidth / 2;
        //确保可以有圆角
        self.badge.layer.masksToBounds = YES;
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
    }
}

- (void)showBadgeWithCount:(NSInteger)redCount {
    if (redCount <= 0) {
        [self showBadge];
        return;
    }
    [self showBadge];
    self.badge.textColor = [UIColor whiteColor];
    self.badge.font = [UIFont boldSystemFontOfSize:badgeFont];
    self.badge.textAlignment = NSTextAlignmentCenter;
    self.badge.text = (redCount > 99 ? [NSString stringWithFormat:@"99+"] : [NSString stringWithFormat:@"%@", @(redCount)]);
    [self adjustLabelWidth:self.badge];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    frame.origin.x = self.frame.size.width - frame.size.width / 2;
    frame.origin.y = -frame.size.height / 2;
    if (CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}

- (void)hideBadge {
    //从父视图上面移除
    [self.badge removeFromSuperview];
    self.badge = nil;
}

- (void)adjustLabelWidth:(UILabel *)label {
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    if (![s respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    } else {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        labelsize = [s boundingRectWithSize:size
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                    context:nil].size;
    }
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    [label setFrame:frame];
}

#pragma mark - GetterAndSetter
- (UILabel *)badge {
    //通过runtime创建一个UILabel的属性
    return objc_getAssociatedObject(self, &badgeViewKey);
}

- (void)setBadge:(UILabel *)badge {
    objc_setAssociatedObject(self, &badgeViewKey, badge, OBJC_ASSOCIATION_RETAIN);
}

@end
