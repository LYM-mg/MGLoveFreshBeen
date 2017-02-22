//
//  BuyView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotGoods;

@interface BuyView : UIView

/** 购买数量 */
@property (nonatomic, assign) int buyNumber;

/** 辅助属性,购买数为0时 */
@property (nonatomic, assign,getter=isBuyViewShowWhenBuyCountLabelZero) BOOL buyViewShowWhenBuyCountLabelZero;

/** 商品模型 */
@property (nonatomic,strong) HotGoods *goods;

- (instancetype)initWithFrame:(CGRect)frame withBlock:(void (^)())clickAddShopCar;
@end
