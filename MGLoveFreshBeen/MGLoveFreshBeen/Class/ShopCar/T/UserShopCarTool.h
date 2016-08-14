//
//  UserShopCarTool.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"


@class HotGoods;

@interface UserShopCarTool : NSObject
interfaceSingle(UserShopCarTool);

/**
 *  添加商品到购物车
 *
 *  @param goods 商品模型
 */
- (void)addSupermarkProductToShopCar:(HotGoods *)goods;

/**
 *  从购物车移除商品
 *
 *  @param goods 商品模型
 */
- (void)removeSupermarketProduct:(HotGoods *)goods;

/**
 *  获取购物车中的数据
 *
 *  @return 购物车的数组
 */
- (NSMutableArray *)getShopCarProducts;

/**
 *  获取购物车中的商品类型个数
 *
 *  @return 购物车的数组个数
 */
- (NSInteger)getShopCarProductsClassCount;

/**
 *  商品总个数
 */
- (int)userShopCarProductsNumber;

/**
 *  获取购物车中的商品是否为空
 *
 *  @return BOOL类型
 */
- (BOOL)isEmpty;

/**
 *  获取购物车中的商品的总价格
 *
 *  @return 商品的总价格
 */
- (NSString *)getAllProductsPrice;

@end
