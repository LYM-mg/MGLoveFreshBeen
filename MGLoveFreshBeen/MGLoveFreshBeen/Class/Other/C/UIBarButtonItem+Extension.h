//
//  UIBarButtonItem+Extension.h
//  03-百思不得姐-我的
//
//  Created by ming on 13/12/5.
//  Copyright © 2015年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/** 设置背景图片 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage norColor:(UIColor *)norColor selColor:(UIColor *)selColor title:(NSString *)title target:(id)target action:(SEL)action;

/** 设置图片和文字 */
+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/** 设置背景图片和选中图片 */
+ (UIButton *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage selectImage:(NSString *)selImage
                                selHighImage:(NSString *)selHighImage  target:(id)target action:(SEL)action;

@end
