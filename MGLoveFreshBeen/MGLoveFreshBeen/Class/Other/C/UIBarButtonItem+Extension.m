//
//  UIBarButtonItem+Extension.m
//  03-百思不得姐-我的
//
//  Created by ming on 13/12/5.
//  Copyright © 2015年 ming. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

// UIBarButtonItem的封装
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage norColor:(UIColor *)norColor selColor:(UIColor *)selColor title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    /// 1.设置照片
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn setImage:highImage forState:UIControlStateHighlighted];
    /// 2.设置文字以及颜色
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setTitleColor:norColor forState:UIControlStateNormal];
    [backBtn setTitleColor:selColor forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:backBtn];
}

+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage  target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    btn.size = btn.currentBackgroundImage.size;
    return [[self alloc] initWithCustomView:btn];
}

+ (UIButton *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage selectImage:(NSString *)selImage
    selHighImage:(NSString *)selHighImage target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
    if (btn.selected) {
        [btn setBackgroundImage:[UIImage imageNamed:selHighImage] forState:UIControlStateHighlighted];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    btn.size = btn.currentBackgroundImage.size;
    return btn;
}



@end
