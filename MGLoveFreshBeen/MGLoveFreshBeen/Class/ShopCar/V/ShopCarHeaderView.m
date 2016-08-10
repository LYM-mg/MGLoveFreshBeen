//
//  ShopCarHeaderView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarHeaderView.h"
#import "ReceiveAddressView.h"
#import "ShopCartMarkerView.h"
#import "ShopCarSignTimeView.h"
#import "ShopCarCommentsView.h"


@interface ShopCarHeaderView ()

@end

@implementation ShopCarHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self buildReceiptAddress];
    
    [self buildMarketView];
    
    [self buildSignTimeView];
    
    [self buildSignComments];
}

/**
 *  收获地址
 */
- (void)buildReceiptAddress{
    ReceiveAddressView *receiptAdressView = [ReceiveAddressView receiveAddressView];
    receiptAdressView.frame = CGRectMake(0, 10, self.width, 75);
    receiptAdressView.changeUserInfoClickCallBack = ^{
         MGPS(@"收获地址");
    };
//    ReceiveAddressView *receiptAdressView = [[ReceiveAddressView alloc] initWithFrame:CGRectMake(0, 10, self.width, 75) changeUserInfoClickCallBack:^{
//        MGPS(@"收获地址");
//    }];
    [self addSubview:receiptAdressView];
}

/**
 *  markerView
 */
- (void)buildMarketView{
    ShopCartMarkerView *markerView = [[ShopCartMarkerView alloc] initWithFrame:CGRectMake(0, 90, MGSCREEN_width, 60)];
    [self addSubview:markerView];
}

/**
 *  收货时间
 */
- (void)buildSignTimeView{
    ShopCarSignTimeView *signTimeView = [[ShopCarSignTimeView alloc] initWithFrame:CGRectMake(0, 150, MGSCREEN_width, MGShopCartRowHeight)];
    [self addSubview:signTimeView];
}

/**
 *  收货备注
 */
- (void)buildSignComments{
    ShopCarCommentsView *commentsView = [[ShopCarCommentsView alloc] initWithFrame:CGRectMake(0, 200, self.width, MGShopCartRowHeight)];
    [self addSubview:commentsView];
}


@end
