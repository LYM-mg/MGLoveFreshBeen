//
//  UserShopCarTool.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "UserShopCarTool.h"
#import "ShopCarRedDotView.h"
#import "HotFreshModel.h"

@interface UserShopCarTool ()
/** 购物车模型数据数组 */
@property (nonatomic,strong) NSMutableArray *supermarketProducts;

@end

@implementation UserShopCarTool

implementationSingle(UserShopCarTool);

- (NSMutableArray *)supermarketProducts{
    if (!_supermarketProducts) {
        _supermarketProducts = [NSMutableArray array];
    }
    return _supermarketProducts;
}

/**
 *  添加商品到购物车
 *
 *  @param goods 商品模型
 */
- (void)addSupermarkProductToShopCar:(HotGoods *)goods{
    for (HotGoods *everyGoods in self.supermarketProducts) {
        if (everyGoods.goodsID == goods.goodsID) {
            return;
        }
    }
    
    [self.supermarketProducts addObject:goods];
}

/**
 *  从购物车移除商品
 *
 *  @param goods 商品模型
 */
- (void)removeSupermarketProduct:(HotGoods *)goods{
    for (int i = 0; i < self.supermarketProducts.count;i++) {
        HotGoods *everyGoods = self.supermarketProducts[i];
        if (everyGoods.goodsID == goods.goodsID) {
            [self.supermarketProducts removeObjectAtIndex:i];
            [MGNotificationCenter postNotificationName:MGShopCarDidRemoveProductNSNotification object:nil userInfo: nil];
            return;
        }
    }
}

/**
 *  商品个数
 */
- (int)userShopCarProductsNumber {
    return [ShopCarRedDotView shareShopCarRedDotView].buyNumber;
}



#pragma mark - 外界接口
/**
 *  获取购物车中的数据
 *
 *  @return 购物车的数组
 */
- (NSMutableArray *)getShopCarProducts{
    return self.supermarketProducts;
}

/**
 *  获取购物车中的商品类型个数
 *
 *  @return 购物车的数组个数
 */
- (NSInteger)getShopCarProductsClassCount{
    return self.supermarketProducts.count;
}

/**
 *  获取购物车中的商品是否为空
 *
 *  @return BOOL类型
 */
- (BOOL)isEmpty{
    return self.supermarketProducts.count == 0;
}

/**
 *  获取购物车中的商品的总价格
 *
 *  @return 商品的总价格
 */
- (NSString *)getAllProductsPrice{
    double allPrice = 0;
    for (HotGoods *everyGoods in self.supermarketProducts) {
        allPrice = allPrice + everyGoods.partner_price.doubleValue * everyGoods.userBuyNumber;
    }
    NSString *prictStr = [NSString stringWithFormat:@"%f",allPrice];
    
    return [self cleanDecimalPointZear:prictStr];
//
}

/// 清除字符串小数点末尾的0
- (NSString *)cleanDecimalPointZear:(NSString *)newStr {
    
    NSString *s = [NSString string];
    
    long offset = newStr.length - 1;
    while (offset > 0) {
        s = [newStr substringWithRange:NSMakeRange(offset, 1)];
        if ([s isEqualToString:@"0"] || [s isEqualToString:@"."]) {
            offset--;
        } else {
            break;
        }
    }
    
    return [newStr substringToIndex:(offset + 1)];
}


@end
