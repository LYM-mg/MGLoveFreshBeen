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

#import "MyAddressCell.h"

@interface ShopCarHeaderView ()
/** <#注释#> */
@property (nonatomic,weak) ReceiveAddressView *receiveAdressView;
/** <#注释#> */
@property (nonatomic,weak) ShopCartMarkerView *markerView;
/** <#注释#> */
@property (nonatomic,weak) ShopCarSignTimeView *signTimeView;
/** <#注释#> */
@property (nonatomic,weak) ShopCarCommentsView *commentsView;
@end

@implementation ShopCarHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma maark - 私有方法
- (void)setUpUI{
    [self buildReceiveAddress];
    
    [self buildMarketView];
    
    [self buildSignTimeView];
    
    [self buildSignComments];
}

/**
 *  收获地址
 */
- (void)buildReceiveAddress{
    ReceiveAddressView *receiveAdressView = [ReceiveAddressView receiveAddressView];
    receiveAdressView.frame = CGRectMake(0, 10, self.width, 75);
    receiveAdressView.addressModel = self.addressModel;
    receiveAdressView.changeUserInfoClickCallBack = ^{
        if (self.changeUserInfoClickCallBack) {            
            self.changeUserInfoClickCallBack();
        }
    };
    [self addSubview:receiveAdressView];
    _receiveAdressView = receiveAdressView;
}

/**
 *  markerView
 */
- (void)buildMarketView{
    ShopCartMarkerView *markerView = [[ShopCartMarkerView alloc] initWithFrame:CGRectMake(0, 90, MGSCREEN_width, 60)];
    [self addSubview:markerView];
    _markerView = markerView;
}

/**
 *  收货时间
 */
- (void)buildSignTimeView{
    ShopCarSignTimeView *signTimeView = [[ShopCarSignTimeView alloc] initWithFrame:CGRectMake(0, 150, MGSCREEN_width, MGShopCartRowHeight)];
    [self addSubview:signTimeView];
    _signTimeView = signTimeView;
}

/**
 *  收货备注
 */
- (void)buildSignComments{
    ShopCarCommentsView *commentsView = [[ShopCarCommentsView alloc] initWithFrame:CGRectMake(0, 200, self.width, MGShopCartRowHeight)];
    [self addSubview:commentsView];
    _commentsView = commentsView;
}

#pragma mark - 重写地址模型
- (void)setAddressModel:(AddressCellModel *)addressModel{
    _addressModel = addressModel;
    self.receiveAdressView.addressModel = addressModel;
}


@end
