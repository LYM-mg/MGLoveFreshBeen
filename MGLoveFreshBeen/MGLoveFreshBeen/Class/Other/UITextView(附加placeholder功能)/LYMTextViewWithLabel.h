//
//  LYMTextViewWithLabel.h
//  04-百思不得姐-发布
//
//  Created by ming on 13/12/9.
//  Copyright © 2013年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYMTextViewWithLabel : UITextView

/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 文字颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;

@end
