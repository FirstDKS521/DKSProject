//
//  KSMineOtherCell.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSMineOtherCell.h"
#import "KSMineOrderCell.h"
#import "KSMineOrderModel.h"

@interface KSMineOtherCell ()<KSMineOrderDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat heightED;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation KSMineOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.heightED = 0;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dataSource = @[@{@"title":@"待付款", @"imgName":@"stay_pay",
                              @"newCount": @2},
                            @{@"title":@"待发货", @"imgName":@"stay_send",
                              @"newCount": @0},
                            @{@"title":@"待收货", @"imgName":@"stay_accept",
                              @"newCount": @5},
                            @{@"title":@"待评价", @"imgName":@"stay_comment",
                              @"newCount": @0}];
        [self.contentView addSubview:self.collectionView];
        self.collectionView.frame = CGRectMake(0, 0, Screen_Width, self.contentView.frame.size.height);
    }
    return self;
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSMineOrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegaet = self;
    KSMineOrderModel *model = [KSMineOrderModel modelWithJSON:self.dataSource[indexPath.row]];
    cell.model = model;
//    [self updateCollectionViewHeight:collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KSMineOrderCell *cell = (KSMineOrderCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [KSAlertView showAlertWithTitle:@"提示" message:cell.titleLabel.text cancleButtonTitle:@"取消" otherButtonTitle:@"确定" clickAtIndex:^(NSInteger buttonIndex) {
        //NSLog(@"点击了%@", @(buttonIndex));
    }];
}

- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.heightED != height) {
        self.heightED = height;
        self.collectionView.frame = CGRectMake(0, 0, self.collectionView.width, height);
        
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andHeight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andHeight:height andIndexPath:self.indexPath];
        }
    }
}

#pragma mark ====== init ======
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = (Screen_Width - 51) / 4;
        layout.estimatedItemSize = CGSizeMake(width, width + 200);
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[KSMineOrderCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
