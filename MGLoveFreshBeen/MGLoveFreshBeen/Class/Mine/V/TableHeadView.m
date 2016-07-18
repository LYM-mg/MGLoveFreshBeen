//
//  TableHeadView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "TableHeadView.h"
#import "MGButton.h"

@interface TableHeadView ()


@end

@implementation TableHeadView

+ (instancetype)tableHeadView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableHeadView class]) owner:nil options:nil].lastObject;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)awakeFromNib{
}

// 我的订单的点击
- (IBAction)orderBtnClick:(MGButton *)sender {
    if (_orderBtnClickBlock) {
        self.orderBtnClickBlock();
    }
}

// 我的优惠券的点击
- (IBAction)CouponBtnClick:(MGButton *)sender {
    if (_CouponBtnClickBlock) {
         self.CouponBtnClickBlock();
    }
}

// 我的消息按钮的点击
- (IBAction)messageBtnClick:(MGButton *)sender {
    if (_messageBtnClickBlock) {
        self.messageBtnClickBlock();
    }
}


@end
