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

/** 我的订单按钮的点击回调 */
@property (nonatomic,strong) void (^orderBtnClickBlock)();
/** 优惠券按钮的点击回调 */
@property (nonatomic,strong) void (^couponBtnClickBlock)();
/** 我的消息按钮的点击回调 */
@property (nonatomic,strong) void (^messageBtnClickBlock)();

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
- (void)tableHeadViewOrderBtnClickBlock:(void (^)())orderBtnClickBlock{
    _orderBtnClickBlock = orderBtnClickBlock;
}

// 我的优惠券的点击
- (IBAction)CouponBtnClick:(MGButton *)sender {
    if (_couponBtnClickBlock) {
         self.couponBtnClickBlock();
    }
}
- (void)tableHeadViewCouponBtnClickBlock:(void (^)())couponBtnClickBlock{
    _couponBtnClickBlock = couponBtnClickBlock;
}

// 我的消息按钮的点击
- (IBAction)messageBtnClick:(MGButton *)sender {
    if (_messageBtnClickBlock) {
        self.messageBtnClickBlock();
    }
}
- (void)tableHeadViewMessageBtnClickBlock:(void (^)())messageBtnClickBlock{
    _messageBtnClickBlock = messageBtnClickBlock;
}


@end
