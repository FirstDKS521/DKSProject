//
//  KSHomeDetailController.m
//  DKSProject
//
//  Created by aDu on 2018/3/28.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSHomeDetailController.h"
#import "UIScrollView+HintView.h"
#import "KSHomeDetailCell.h"
#import "KSHomeDetailModel.h"
#import "KSHomeUrl.h"

#define K_Cell @"cell"
@interface KSHomeDetailController ()

@end

@implementation KSHomeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCollection];
    [self loadNewData];
}

- (void)loadNewData {
    [self loadData];
}

- (void)loadData {
    NSString *urlStr = [NSString stringWithFormat:@"http://apiv4.yangkeduo.com/v4/operation/%@/groups", @(self.opt_id)];
    __weak __typeof(self) ws = self;
    [PPNetworkHelper GET:urlStr parameters:nil success:^(id responseObject) {
        [ws.dataAry removeAllObjects];
        for (NSDictionary *dic in responseObject[@"goods_list"]) {
            KSHomeDetailModel *model = [KSHomeDetailModel modelWithJSON:dic];
            [ws.dataAry addObject:model];
        }
        [ws.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSHomeDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:K_Cell forIndexPath:indexPath];
    KSHomeDetailModel *model = self.dataAry[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark ====== init ======
- (void)setCollection {
    CGFloat width = (Screen_Width - 3) / 2;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 3;
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.itemSize = CGSizeMake(width, width + 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height - StatusNav_Height);
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[KSHomeDetailCell class] forCellWithReuseIdentifier:K_Cell];
    self.collectionView.backgroundColor = [UIColor ks_backgroundColor];
    self.collectionView.mj_footer.hidden = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.hintView.autoShowHintView = YES;
    [self.view addSubview:self.collectionView];
}

@end
