//
//  ShopCarTableViewBottomView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarTableViewBottomView : UIView
/** priceLabel */
@property (nonatomic,weak) UILabel *priceLabel;

/** 确认订单Block */
@property (nonatomic,copy) void (^sureProductsButtonClickWoothBlock)();

/**
 *  刷新呢价格
 */
- (void)setPriceLabelText:(double)price;
@end
