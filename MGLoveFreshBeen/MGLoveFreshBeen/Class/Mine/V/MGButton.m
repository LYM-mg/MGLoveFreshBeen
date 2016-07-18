//
//  MGButton.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGButton.h"

@implementation MGButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    // 设置文字对齐方式
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 设置文字颜色
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    // 设置文字大小
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    // 设置按钮背景（做分割线用）
    //        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    
    // 设置图片的方式
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;


}

/** 重新布局按钮内部图片和文字的位置和大小 */
- (void)layoutSubviews{
    [super layoutSubviews];
    // 图片
    self.imageView.width = 45;
    self.imageView.height = 45;
    self.imageView.x = (self.width - self.imageView.width) * 0.5;
    self.imageView.y = self.height * 0.05;

    // 文字
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y - 5;
}

@end
