//
//  DKSHintView.m
//  Demo
//
//  Created by aDu on 2017/12/26.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "DKSHintView.h"

//黑色
#define K_BlackColor [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.f]
//灰色
#define K_GrayColor [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.f]

static CGFloat labelFont = 14; //描述字体大小
static CGFloat labelHeight = 20; //描述文字高度
static CGFloat btnFont = 14; //按钮字体大小
static CGFloat btnWidth = 90; //按钮的宽度
static CGFloat btnHeight = 30; //按钮高度
static CGFloat margin = 8.0; //视图间距
static CGFloat imgWidth = 50.0; //图片宽高
@interface DKSHintView ()

@property (nonatomic, strong) UIImageView *hintImage;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIButton *hintBtn;
/** 自定义显示视图 */
@property (nonatomic, strong) UIView *customView;

@end

@implementation DKSHintView
{
    CGFloat contentWidth;  //self的宽度
    CGFloat contentHeight; //self的高度
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //无数据时，默认自动显示占位图
        self.autoShowHintView = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.centerX = self.superview.width * 0.5;
    self.centerY = self.superview.height * 0.5;
    CGFloat centerX = self.width * 0.5;
    self.hintImage.centerX = centerX;
    self.hintLabel.centerX = centerX;
    self.hintBtn.centerX = centerX;
}

#pragma mark ====== 显示占位图 ======
//只显示图片
+ (instancetype)showHintViewWithImageStr:(NSString *)imageStr {
    DKSHintView *hintView = [[self alloc] init];
    [hintView showHintViewWithImageStr:imageStr titleStr:nil btnTitleStr:nil target:nil action:nil];
    return hintView;
}

//只显示提示文案
+ (instancetype)showHintViewWithTitleStr:(NSString *)titleStr {
    DKSHintView *hintView = [[self alloc] init];
    [hintView showHintViewWithImageStr:nil titleStr:titleStr btnTitleStr:nil target:nil action:nil];
    return hintView;
}

//显示图片、提示文案
+ (instancetype)showHintViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr {
    DKSHintView *hintView = [[self alloc] init];
    [hintView showHintViewWithImageStr:imageStr titleStr:titleStr btnTitleStr:nil target:nil action:nil];
    return hintView;
}

//显示提示文案、按钮
+ (instancetype)showHintViewWithTitleStr:(NSString *)titleStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action {
    DKSHintView *hintView = [[self alloc] init];
    [hintView showHintViewWithImageStr:nil titleStr:titleStr btnTitleStr:btnTitleStr target:target action:action];
    return hintView;
}

#pragma mark ====== 总的方法 ======
+ (instancetype)showHintViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action {
    DKSHintView *hintView = [[self alloc] init];
    [hintView showHintViewWithImageStr:imageStr titleStr:titleStr btnTitleStr:btnTitleStr target:target action:action];
    return hintView;
}

#pragma mark ====== 自定义显示的视图 ======
+ (void)showHintViewWithCustomView:(UIView *)customView imageStr:(NSString *)imageStr titleStr:(NSString *)titleStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action {
    DKSHintView *hintView = [DKSHintView showHintViewWithImageStr:imageStr titleStr:titleStr btnTitleStr:btnTitleStr target:target action:action];
    hintView.customView = customView;
    [customView addSubview:hintView];
}

#pragma mark ====== 共同处理 ======
- (void)showHintViewWithImageStr:(NSString *)imgStr titleStr:(NSString *)titleStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action {
    //图片显示
    if (imgStr.length > 0) {
        UIImage *img = [UIImage imageNamed:imgStr];
        self.hintImage.image = img;
        CGFloat imgViewWidth = img.size.width;
        CGFloat imgViewHeight = img.size.height;
        if (imgViewWidth > imgViewHeight) {
            imgViewHeight = (imgViewHeight / imgViewWidth) * imgWidth;
            imgViewWidth = imgWidth;
        } else {
            imgViewWidth = (imgViewWidth / imgViewHeight) * imgWidth;
            imgViewHeight = imgWidth;
        }
        self.hintImage.frame = CGRectMake(0, 0, imgViewWidth, imgViewHeight);
        contentHeight = imgViewHeight;
        contentWidth = imgViewWidth;
    }
    //提示文字
    if (titleStr.length > 0) {
        self.hintLabel.text = titleStr;
        CGSize size = [self returnTextWidth:titleStr size:CGSizeMake(1000, labelHeight)];
        contentHeight = contentHeight ? contentHeight + margin : contentHeight;
        self.hintLabel.frame = CGRectMake(0, contentHeight, size.width, labelHeight);
        contentHeight = CGRectGetMaxY(self.hintLabel.frame);
        contentWidth = contentWidth > size.width ? contentWidth : size.width;
    }
    //按钮信息
    if (btnTitleStr.length > 0) {
        [self.hintBtn setTitle:btnTitleStr forState:UIControlStateNormal];
        contentHeight = contentHeight ? contentHeight + margin : contentHeight;
        self.hintBtn.frame = CGRectMake(0, contentHeight, btnWidth, btnHeight);
        contentHeight = CGRectGetMaxY(self.hintBtn.frame);
        contentWidth = contentWidth > btnWidth ? contentWidth : btnWidth;
        //给按钮添加方法
        if (target && action) {
            [self.hintBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
    CGRect viewFrame = self.frame;
    viewFrame.size = CGSizeMake(contentWidth, contentHeight);
    self.frame = viewFrame;
}

#pragma mark ====== init ======
- (UIImageView *)hintImage {
    if (!_hintImage) {
        _hintImage = [[UIImageView alloc] init];
        _hintImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_hintImage];
    }
    return _hintImage;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.font = [UIFont systemFontOfSize:labelFont];
        _hintLabel.textColor = K_GrayColor;
        [self addSubview:_hintLabel];
    }
    return _hintLabel;
}

- (UIButton *)hintBtn {
    if (!_hintBtn) {
        _hintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hintBtn.titleLabel.font = [UIFont systemFontOfSize:btnFont];
        [_hintBtn setTitleColor:K_BlackColor forState:UIControlStateNormal];
        _hintBtn.layer.masksToBounds = YES;
        _hintBtn.layer.cornerRadius = 4;
        _hintBtn.layer.borderWidth = 1;
        _hintBtn.layer.borderColor = K_GrayColor.CGColor;
        [self addSubview:_hintBtn];
    }
    return _hintBtn;
}

#pragma mark ====== 获取描述文案的长度 ======
- (CGSize)returnTextWidth:(NSString *)text size:(CGSize)size {
    CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:labelFont]} context:nil].size;
    return textSize;
}

@end
