//
//  UIViewController+KSToast.m
//  DKSProject
//
//  Created by aDu on 2018/3/16.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "UIViewController+KSToast.h"
#import <MBProgressHUD.h>
#import "UIColor+KSColor.h"

static const double delay = K_Animation_Time;
@implementation UIViewController (KSToast)

- (void)ks_toastString:(NSString *)content {
    [self ks_toastHiden];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = content;
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)ks_toastNotHideString:(NSString *)content {
    [self ks_toastHiden];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = content;
}

- (void)ks_toastString:(NSString *)content completBlock:(void (^)(void))block {
    [self ks_toastHiden];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.text = content;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.hidden = YES;
        if (block) {
            block();
        }
    });
}

- (void)ks_toastProgressHiden:(NSString *)content {
    [self ks_toastHiden];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = content;
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)ks_toastProgressString:(NSString *)content {
    [self ks_toastHiden];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = content;
}

- (void)ks_toastProgress:(NSString *)content completBlock:(void (^)(void))block {
    [self ks_toastHiden];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = content;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.hidden = YES;
        if (block) {
            block();
        }
    });
}

- (void)ks_toastHiden {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
