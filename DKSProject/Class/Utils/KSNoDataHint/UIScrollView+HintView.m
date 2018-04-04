//
//  UIScrollView+HintView.m
//  Demo
//
//  Created by aDu on 2017/12/28.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "UIScrollView+HintView.h"
#import <objc/runtime.h>

static char kHintViewKey;
@implementation UIScrollView (HintView)

- (void)setHintView:(DKSHintView *)hintView {
    if (self.hintView != hintView) {
        objc_setAssociatedObject(self, &kHintViewKey, hintView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[DKSHintView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.hintView];
    }
}

- (DKSHintView *)hintView {
    return objc_getAssociatedObject(self, &kHintViewKey);
}

#pragma mark ====== Private Method ======
//获取总的数据量
- (NSInteger)totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet {
    if ([self totalDataCount] == 0) {
        [self showHintView];
    } else {
        [self hideHintView];
    }
}

#pragma mark ====== Public Method ======
- (void)showHintView {
    /*当设置了autoShowHintView为NO时，内部自动调用显示占位图的方
     法也不是显示占位图，需要手动调用显示的方法*/
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.hintView = [DKSHintView showHintViewWithImageStr:@"no_data" titleStr:@"暂无数据"];
    if (!self.hintView.autoShowHintView) {
        self.hintView.hidden = YES;
        return;
    }
    [self.hintView.superview layoutSubviews];
    self.hintView.hidden = NO;
    //让占位图始终在最上层
    [self bringSubviewToFront:self.hintView];
}

- (void)hideHintView {
    if (!self.hintView.autoShowHintView) {
        self.hintView.hidden = YES;
        return;
    }
    self.hintView.hidden = YES;
}

//开始加载数据
- (void)startLoading {
    [self hideHintView];
}

//结束加载数据
- (void)endLoading {
    [self getDataAndSet];
}

@end

@implementation UITableView (Hint)

+ (void)load {
    //刷新交换方法
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method ks_reloadData = class_getInstanceMethod(self, @selector(ks_reloadData));
    method_exchangeImplementations(reloadData, ks_reloadData);
    
    //section
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:withRowAnimation:));
    Method ks_insertSections = class_getInstanceMethod(self, @selector(ks_insertSections:withRowAnimation:));
    method_exchangeImplementations(insertSections, ks_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:withRowAnimation:));
    Method ks_deleteSections = class_getInstanceMethod(self, @selector(ks_deleteSections:withRowAnimation:));
    method_exchangeImplementations(deleteSections, ks_deleteSections);
    
    //row
    Method insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(insertRowsAtIndexPaths:withRowAnimation:));
    Method ks_insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(ks_insertRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(insertRowsAtIndexPaths, ks_insertRowsAtIndexPaths);
    
    Method deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteRowsAtIndexPaths:withRowAnimation:));
    Method ks_deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(ks_deleteRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(deleteRowsAtIndexPaths, ks_deleteRowsAtIndexPaths);
}

#pragma mark ====== 刷新方法 ======
- (void)ks_reloadData {
    [self ks_reloadData];
    [self getDataAndSet];
}

#pragma mark ====== 改变section ======
- (void)ks_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self ks_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ks_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self ks_deleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

#pragma mark ====== 改变row ======
- (void)ks_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self ks_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)ks_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self ks_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

@end

@implementation UICollectionView (Hint)

+ (void)load {
    //刷新交换方法
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method ks_reloadData = class_getInstanceMethod(self, @selector(ks_reloadData));
    method_exchangeImplementations(reloadData, ks_reloadData);
    
    //section
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:));
    Method ks_insertSections = class_getInstanceMethod(self, @selector(ks_insertSections:));
    method_exchangeImplementations(insertSections, ks_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:));
    Method ks_deleteSections = class_getInstanceMethod(self, @selector(ks_deleteSections:));
    method_exchangeImplementations(deleteSections, ks_deleteSections);
    
    //row
    Method insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(insertItemsAtIndexPaths:));
    Method ks_insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(ks_insertItemsAtIndexPaths:));
    method_exchangeImplementations(insertRowsAtIndexPaths, ks_insertItemsAtIndexPaths);
    
    Method deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteItemsAtIndexPaths:));
    Method ks_deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(ks_deleteItemsAtIndexPaths:));
    method_exchangeImplementations(deleteItemsAtIndexPaths, ks_deleteItemsAtIndexPaths);
}

#pragma mark ====== 刷新方法 ======
- (void)ks_reloadData {
    [self ks_reloadData];
    [self getDataAndSet];
}

#pragma mark ====== 改变section ======
- (void)ks_insertSections:(NSIndexSet *)sections {
    [self ks_insertSections:sections];
    [self getDataAndSet];
}
- (void)ks_deleteSections:(NSIndexSet *)sections {
    [self ks_deleteSections:sections];
    [self getDataAndSet];
}

#pragma mark ====== 改变item ======
- (void)ks_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ks_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

- (void)ks_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

@end
