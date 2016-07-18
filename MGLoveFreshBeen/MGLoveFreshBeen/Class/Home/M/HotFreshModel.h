//
//  HotFreshModel.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - HotGoods
@interface HotGoods : NSObject
//*************************商品模型默认属性**********************************
/** 商品ID */
@property (nonatomic,copy) NSString *id;
/** 商品姓名 */
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *brand_id;
/** 超市价格 */
@property (nonatomic,copy) NSString *market_price;
@property (nonatomic,copy) NSString *cid;
@property (nonatomic,copy) NSString *category_id;
/** 当前价格 */
@property (nonatomic,copy) NSString *partner_price;
@property (nonatomic,copy) NSString *brand_name;
@property (nonatomic,copy) NSString *pre_img;

@property (nonatomic,copy) NSString *pre_imgs;
/** 参数 */
@property (nonatomic,copy) NSString *specifics;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *dealer_id;
/** 当前价格 */
@property (nonatomic,copy) NSString *price;
/** 库存 */
@property (nonatomic, assign) int number;
/** 买一赠一 */
@property (nonatomic,copy) NSString *pm_desc;
@property (nonatomic, assign) int had_pm;
/** urlStr */
@property (nonatomic,copy) NSString *img;
/** 是不是精选 0 : 不是, 1 : 是 */
@property (nonatomic, assign) int is_xf;

//*************************商品模型辅助属性**********************************
// 记录用户对商品添加次数
@property (nonatomic, assign) int userBuyNumber;
@end


#pragma mark - HotFreshModel
@interface HotFreshModel : NSObject
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int code;
@property (nonatomic,copy) NSString *msg;
/** 存放HotGoods商品的数组 */
@property (nonatomic,strong) NSArray *data;
@end

