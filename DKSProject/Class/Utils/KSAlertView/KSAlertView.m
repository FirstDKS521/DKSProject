//
//  KSAlertView.m
//  DKSProject
//
//  Created by aDu on 2018/4/3.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSAlertView.h"

static AlertIndexBlock indexBlock;
@implementation KSAlertView

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)cancleButtonTitle otherButtonTitle:(NSString *)otherButtonTitle clickAtIndex:(AlertIndexBlock)clickAtIndex {
    dispatch_async(dispatch_get_main_queue(), ^{
        indexBlock = [clickAtIndex copy];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancleButtonTitle otherButtonTitles:otherButtonTitle, nil];
        [alertView show];
    });
}

#pragma mark ====== UIAlertViewDelegate ======
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (indexBlock) {
        indexBlock(buttonIndex);
    }
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    indexBlock = nil;
}

@end
