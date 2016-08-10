//
//  ShopCartMarkerView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCartMarkerView.h"

@implementation ShopCartMarkerView

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
    CGFloat marketHeight = 60;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:[self lineView:CGRectMake(0, 0, MGSCREEN_width, 0.5)]];
    
    UIImageView *rocketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lighting"]];
    rocketImageView.frame = CGRectMake(15, 5, 20, 20);
    [self addSubview:rocketImageView];
    
    UIImageView *redDotImaegView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reddot"]];
    redDotImaegView.frame = CGRectMake(15, (marketHeight - CGRectGetMaxY(rocketImageView.frame) - 4) * 0.5 + CGRectGetMaxY(rocketImageView.frame), 4, 4);
    [self addSubview:redDotImaegView];
    
    UILabel *marketTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rocketImageView.frame) + 10, 5, MGSCREEN_width * 0.6, 20)];
    marketTitleLabel.text = @"闪电超市";
    marketTitleLabel.font = MGFont(14);
    marketTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:marketTitleLabel];
    
    UILabel *marketLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(redDotImaegView.frame) + 5, CGRectGetMaxY(rocketImageView.frame), MGSCREEN_width * 0.7, 60 - CGRectGetMaxY(rocketImageView.frame))];
    marketLabel.text = @"   22:00前满$30免运费,22:00后满$50面运费";
    marketLabel.textColor = [UIColor lightGrayColor];
    marketLabel.font = MGFont(12);
    [self addSubview:marketLabel];
    
    [self addSubview:[self lineView:CGRectMake(0, marketHeight - 0.5, MGSCREEN_width, 0.5)]];
}

- (UIView *)lineView:(CGRect)frame {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}


@end
