//
//  ShopCarRedDotView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarRedDotView.h"

@interface ShopCarRedDotView ()
//红色Label
//@property (nonatomic,weak) UILabel *numberLabel;
// 红色图片 
//@property (nonatomic,weak) UIImageView *redImageView;

/** 红色图片 */
@property (nonatomic,weak) UIButton *redDotBtn;

@end


@implementation ShopCarRedDotView

implementationSingle(ShopCarRedDotView)

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *redDotBtn = [[UIButton alloc] initWithFrame:self.bounds];
        [redDotBtn setBackgroundImage:[UIImage imageNamed:@"reddot"] forState:UIControlStateNormal];
        self.redDotBtn = redDotBtn;
        [self addSubview:redDotBtn];
    }
    return self;
}

/**
 *  重写数量的get方法
 *
 *  @param buyNumber 数量
 */
- (void)setBuyNumber:(int)buyNumber{
    _buyNumber = buyNumber;
    
    if (0 == buyNumber) {
        [self.redDotBtn setTitle:@"" forState:UIControlStateNormal];
        self.hidden = YES;
    } else
    {
        if (buyNumber > 99) {
            self.redDotBtn.titleLabel.font = MGFont(8);
        } else {
            self.redDotBtn.titleLabel.font = MGFont(10);
        }
        
        self.hidden = NO;
        NSString *str = [NSString stringWithFormat:@"%d",buyNumber];
        [self.redDotBtn setTitle:str forState:UIControlStateNormal];
        
    }
}

- (void)addProductToRedDotView:(BOOL)animation {
    self.buyNumber++;
    
    if (animation == YES) {
        [self reddotAnimation];
    }
}

- (void)reduceProductToRedDotView:(BOOL)animation {
    if (self.buyNumber > 0) {
        self.buyNumber--;
    }
    
    if (animation  == YES) {
        [self reddotAnimation];
    }
}

- (void)reddotAnimation {
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView  animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }];
}



@end
