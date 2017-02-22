//
//  ReSetPasswordVC.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReSetPasswordVC : UIViewController

/**
 *  便利构造方法
 *
 *  @param phoneText 手机号
 *  @param title     控制器标题
 *
 *  @return 返回self
 */
- (instancetype)initWithPhoneText:(NSString *)phoneText WithVCTitle:(NSString *)title;

@end
