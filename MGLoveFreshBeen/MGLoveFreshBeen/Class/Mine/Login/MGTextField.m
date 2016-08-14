//
//  MGTextField.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGTextField.h"

@implementation MGTextField

- (void)awakeFromNib{
    // 设置左边图片的显示模式
    self.leftViewMode = UITextFieldViewModeAlways;
}


/**
 *  设置左边的边距
 */
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 5;
    return iconRect;
}


- (void)setLeftIcon:(NSString *)leftIcon{
    _leftIcon = leftIcon;
    // 设置输入框左边的view
    self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftIcon]];
}



@end
