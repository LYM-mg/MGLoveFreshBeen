//
//  LYMTextViewWithLabel.m
//  04-百思不得姐-发布
//
//  Created by ming on 13/12/9.
//  Copyright © 2013年 ming. All rights reserved.
//

#import "LYMTextViewWithLabel.h"

@interface LYMTextViewWithLabel ()
/** 占位Label */
@property (nonatomic,weak)  UILabel *placeholderLabel;
@end

@implementation LYMTextViewWithLabel

#pragma mark ========== 通知 =============
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        // 创建一个UILabel
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        // 设置占位文字的默认字体颜色和字体大小
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:15];
        
        // 发布通知（当空间的内容发生改变时）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.placeholderLabel.x = 4;
    self.placeholderLabel.y = 8;
    self.placeholderLabel.width = self.width - 2*self.placeholderLabel.x;
    // 自适应
    [self.placeholderLabel sizeToFit];
}

- (void)textDidChange:(NSNotification *)note{
    // 是否隐藏
    self.placeholderLabel.hidden = self.hasText;
}

// 移除监听者
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.placeholderLabel.textColor = placeholderColor;
}

#pragma mark ========== 重新计算placeholderLabel的尺寸 =============
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = self.font;
    // 重新布局
    [self setNeedsLayout];
}

- (void)setPlaceholder:(NSString *)placeholder{
    self.placeholderLabel.text = [placeholder copy];
    // 重新布局
    [self setNeedsLayout];
}

#pragma mark ========== 隐藏placeholderLabel =============
- (void)setText:(NSString *)text{
    [super setText:text];
    // 隐藏
    self.placeholderLabel.hidden = self.hasText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    // 隐藏
    self.placeholderLabel.hidden = self.hasText;
}

@end
