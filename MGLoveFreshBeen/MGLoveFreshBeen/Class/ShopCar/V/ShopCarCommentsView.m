//
//  ShopCarCommentsView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarCommentsView.h"

@implementation ShopCarCommentsView
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
    
    UILabel *signCommentsLabel = [[UILabel alloc] init];
    signCommentsLabel.text = @"收货备注";
    signCommentsLabel.textColor = [UIColor blackColor];
    signCommentsLabel.font = MGFont(15);
    [signCommentsLabel sizeToFit];
    signCommentsLabel.frame = CGRectMake(15, 0, signCommentsLabel.width, MGShopCartRowHeight);
    [self addSubview:signCommentsLabel];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"可输入100字以内特殊要求内容";
    textField.frame = CGRectMake(CGRectGetMaxX(signCommentsLabel.frame) + 10, 10, MGSCREEN_width - CGRectGetMaxX(signCommentsLabel.frame) - 10 - 20, MGShopCartRowHeight - 20);
    textField.font = MGFont(15);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self addSubview:textField];
    
    [self addSubview:[self lineView:CGRectMake(0, MGShopCartRowHeight - 0.5, MGSCREEN_width, 0.5)]];
}

- (UIView *)lineView:(CGRect)frame {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}

@end
