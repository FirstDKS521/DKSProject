//
//  KSCheckWordTool.h
//  DKSProject
//
//  Created by aDu on 2018/3/16.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSCheckWordTool : NSObject

/**
 *  邮箱验证
 *
 *  @param email 邮箱
 *
 *  @return YES:正确  NO:失败
 */
+ (BOOL)checkForEmail:(NSString *)email;

/**
 *  手机号验证
 *
 *  @param mobilePhone 手机号
 *
 *  @return YES:正确  NO:失败
 */
+ (BOOL)checkForMobilePhoneNo:(NSString *)mobilePhone;

/**
 *  电话号验证
 *
 *  @param phone 电话号
 *
 *  @return 结果
 */
+ (BOOL)checkForPhoneNo:(NSString *)phone;

/**
 *  身份证号验证(15位 或 18位)
 *
 *  @param idCard 身份证号
 *
 *  @return YES:正确  NO:失败
 */
+ (BOOL)checkForIdCard:(NSString *)idCard;

/**
 *  由数字和26个英文字母组成的字符串
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL)checkForNumberAndCase:(NSString *)data;

/**
 *  校验只能输入26位小写字母
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL)checkForLowerCase:(NSString *)data;

/**
 *  校验只能输入26位大写字母
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL)checkForUpperCase:(NSString *)data;

/**
 *  校验只能输入由26个小写英文字母组成的字符串
 *
 *  @param data 字符串
 *
 *  @return 结果
 */
+ (BOOL)checkForLowerAndUpperCase:(NSString *)data;

/**
 *  是否含有特殊字符(%&’,;=?$\等)
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL)checkForSpecialChar:(NSString *)data;

/**
 *  校验只能输入数字
 *
 *  @param number 数字
 *
 *  @return 结果
 */
+ (BOOL)checkForNumber:(NSString *)number;

/**
 *  校验只能输入n位的数字
 *
 *  @param length n位
 *  @param number 数字
 *
 *  @return 结果
 */
+ (BOOL)checkForNumberWithLength:(NSString *)length number:(NSString *)number;

/**
 银行卡校验
 
 @param cardNo 银行卡号
 @return 结果
 */
+ (BOOL)checkBankCard:(NSString *)cardNo;

@end
