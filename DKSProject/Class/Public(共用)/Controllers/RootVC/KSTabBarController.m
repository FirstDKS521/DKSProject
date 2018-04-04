//
//  KSTabBarController.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSTabBarController.h"
#import "KSHomeController.h"
#import "KSDemoController.h"
#import "KSMessageController.h"
#import "KSMineController.h"

@interface KSTabBarController ()

@property (nonatomic, strong) NSMutableArray *vcAry;

@end

@implementation KSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self changeTabBarLineColor];
    [self setTabBra];
}

- (void)setTabBra {
    KSHomeController *homeVC = [[KSHomeController alloc] init];
    [self setViewController:homeVC titleStr:@"首页" imageStr:@"bar_home"];
    
    KSDemoController *demoVC = [[KSDemoController alloc] init];
    [self setViewController:demoVC titleStr:@"汇总" imageStr:@"bar_demo"];
    
    KSMessageController *msgVC = [[KSMessageController alloc] init];
    [self setViewController:msgVC titleStr:@"消息" imageStr:@"bar_msg"];
    
    KSMineController *mineVC = [[KSMineController alloc] init];
    [self setViewController:mineVC titleStr:@"我" imageStr:@"bar_mine"];
    
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor ks_mainColor];
    self.viewControllers = self.vcAry.copy;
}

- (void)setViewController:(UIViewController *)viewController
                 titleStr:(NSString *)titleStr
                 imageStr:(NSString *)imageStr {
    viewController.title = titleStr;
    viewController.tabBarItem.image = [UIImage imageNamed:imageStr];
    
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor ks_backColor], NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor ks_mainColor], NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    KSNavigationController *nav = [[KSNavigationController alloc] initWithRootViewController:viewController];
    [self.vcAry addObject:nav];
}

#pragma mark - 改变TabBar分割线的颜色
- (void)changeTabBarLineColor {
    CGRect rect = CGRectMake(0, 0, Screen_Width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor ks_backgroundColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
}

#pragma mark ====== init ======
- (NSMutableArray *)vcAry {
    if (!_vcAry) {
        _vcAry = [NSMutableArray array];
    }
    return _vcAry;
}

@end
