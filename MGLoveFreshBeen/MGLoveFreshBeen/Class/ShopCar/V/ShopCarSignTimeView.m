//
//  ShopCarSignTimeView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarSignTimeView.h"

@implementation ShopCarSignTimeView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法
/**
 *  创建UI
 */
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    // 点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeselfClick)];
    [self addGestureRecognizer:tap];
    
    UILabel *signTimeTitleLabel = [UILabel new];
    signTimeTitleLabel.text = @"收货时间";
    signTimeTitleLabel.textColor = [UIColor blackColor];
    signTimeTitleLabel.font = MGFont(15);
    [signTimeTitleLabel sizeToFit];
    signTimeTitleLabel.frame = CGRectMake(15, 0, signTimeTitleLabel.width, MGShopCartRowHeight);
    [self addSubview:signTimeTitleLabel];
    
    UILabel *signTimeLabel = [UILabel new];
    signTimeLabel.frame = CGRectMake(CGRectGetMaxX(signTimeTitleLabel.frame) + 10, 0, MGSCREEN_width * 0.5, MGShopCartRowHeight);
    signTimeLabel.textColor = [UIColor redColor];
    signTimeLabel.font = MGFont(15);
    signTimeLabel.text = @"闪电送,及时达";
    [self addSubview:signTimeLabel];
    
    UILabel *reserveLabel = [UILabel new];
    reserveLabel.text = @"可预定";
    reserveLabel.backgroundColor = [UIColor whiteColor];
    reserveLabel.textColor =  [UIColor redColor];
    reserveLabel.font = MGFont(15);
    reserveLabel.frame = CGRectMake(self.width - 72, 0, 60, MGShopCartRowHeight);
    [self addSubview:reserveLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"icon_go"]];
    arrowImageView.frame = CGRectMake(self.width - 15, (MGShopCartRowHeight - arrowImageView.height) * 0.5, arrowImageView.width, arrowImageView.height);
    [self addSubview:arrowImageView];
}

/**
 *  手势点击
 */
- (void)changeselfClick{
    
}

@end
