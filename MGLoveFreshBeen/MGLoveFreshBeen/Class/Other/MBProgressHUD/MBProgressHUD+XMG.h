//
//  MBProgressHUD+XMG.h
//
//  Created by xiaomage on 15-6-6.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XMG)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
