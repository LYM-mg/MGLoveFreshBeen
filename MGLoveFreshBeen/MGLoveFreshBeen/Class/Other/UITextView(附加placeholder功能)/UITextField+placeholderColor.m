//
//  UITextField+placeholderColor.m
//  02-BaiSi
//
//  Created by ming on 13/12/19.
//  Copyright © 2013年 ming. All rights reserved.
/**
 *  设置占位文字的颜色,让外界直接使用
 */

#import "UITextField+placeholderColor.h"

static NSString *const placeholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (placeholderColor)
// 重写placeholderColor的setter方法
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    // bool属性，有文字就这设置为YES
    BOOL change = NO;
    // 如果当前placeholder文字为空，那么就随便赋值几个文字，让它不为空
    if (self.placeholder == nil) {
        self.placeholder = @"mingge";
        // 设置 change = YES
        change = YES;
    }
    [self setValue:placeholderColor forKey:placeholderColorKey];
    // 如果change = YES,那么要把placeholder文字再次设为空
    if (change) {
        self.placeholder = nil;
    }
}

// 重写placeholderColor的getter方法
- (UIColor *)placeholderColor{
    return [self valueForKeyPath:placeholderColorKey];
}

@end
