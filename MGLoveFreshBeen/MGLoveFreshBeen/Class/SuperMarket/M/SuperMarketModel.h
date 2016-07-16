//
//  SuperMarketModel.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - ProductstModel
@interface ProductstModel : NSObject

/** a82数组 */
@property (nonatomic,strong) NSArray *a82;
/** a96数组 */
@property (nonatomic,strong) NSArray *a96;
/** a99数组 */
@property (nonatomic,strong) NSArray *a99;
/** a106数组 */
@property (nonatomic,strong) NSArray *a106;
/** 产品数组 */
@property (nonatomic,strong) NSArray *a134;
/** a135数组 */
@property (nonatomic,strong) NSArray *a135;
/** a136数组 */
@property (nonatomic,strong) NSArray *a136;
/** a137数组 */
@property (nonatomic,strong) NSArray *a137;
/** a141数组 */
@property (nonatomic,strong) NSArray *a141;
/** a143数组 */
@property (nonatomic,strong) NSArray *a143;
/** a147数组 */
@property (nonatomic,strong) NSArray *a147;
/** a151数组 */
@property (nonatomic,strong) NSArray *a151;
/** a152数组 */
@property (nonatomic,strong) NSArray *a152;
/** a158数组 */
@property (nonatomic,strong) NSArray *a158;

@end

#pragma mark - ProductstModel
@interface CategoriesModel : NSObject
/** CategoriesID的ID */
@property (nonatomic,copy) NSString *id;
/** CategoriesID的ID */
//@property (nonatomic,copy) NSString *categoriesID;
/** CategoriesModel的名字 */
@property (nonatomic,copy) NSString *name;
/** CategoriesModel的分类 */
@property (nonatomic,copy) NSString *sort;

@end

#pragma mark - SuperMarketModel
@interface SuperMarketModel : NSObject

/** 名称 */
@property (nonatomic,copy) NSString *trackid;
/** 产品模型 */
@property (nonatomic,strong) ProductstModel *products;
/** 分类数组 */
@property (nonatomic,strong) NSArray *categories;

@end

#pragma mark - SuperMarket
@interface SuperMarket : NSObject
/** code */
@property (nonatomic, assign) int code;
/** msg */
@property (nonatomic,copy) NSString *msg;
/** reqid */
@property (nonatomic,strong) NSArray *reqid;
/** data */
@property (nonatomic,strong) SuperMarketModel *data;

@end

#pragma mark - Goods
@interface Goods: NSObject
//*************************商品模型默认属性**********************************
/// 商品ID
@property (nonatomic,copy) NSString *id;
/// 商品姓名
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *brand_id;
/// 超市价格
@property (nonatomic,copy) NSString *market_price;
@property (nonatomic,copy) NSString *cid;
@property (nonatomic,copy) NSString *category_id;
/// 当前价格
@property (nonatomic,copy) NSString *partner_price;
@property (nonatomic,copy) NSString *brand_name;
@property (nonatomic,copy) NSString *pre_img;

@property (nonatomic,copy) NSString *pre_imgs;
/// 参数
@property (nonatomic,copy) NSString *specifics;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *dealer_id;
/// 当前价格
@property (nonatomic,copy) NSString *price;
/// 库存
@property (nonatomic, assign) int number;
/// 买一赠一
@property (nonatomic,copy) NSString *pm_desc;
@property (nonatomic, assign) int had_pm;
/// urlStr
@property (nonatomic,copy) NSString *img;
/// 是不是精选 0 : 不是, 1 : 是
@property (nonatomic, assign) int is_xf;



//*************************商品模型辅助属性**********************************
// 记录用户对商品添加次数
@property (nonatomic, assign) int userBuyNumber;

@end



