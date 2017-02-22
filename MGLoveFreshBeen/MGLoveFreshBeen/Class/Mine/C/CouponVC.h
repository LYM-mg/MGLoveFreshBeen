//
//  CouponVC.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Coupon: NSObject
/**  */
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *card_pwd;
/** 开始时间 */
@property (nonatomic,copy) NSString *start_time;
/// 结束时间 */
@property (nonatomic,copy) NSString *end_time;
/** 金额 */
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *tid;
/** 是否被使用 0 使用 1 未使用 */
@property (nonatomic,copy) NSString *is_userd;
/** 0 可使用 1 不可使用 */
@property (nonatomic, assign) int status;
@property (nonatomic,copy) NSString *true_end_time;
/** 标题 */
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *point;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *order_limit_money;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *free_freight;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *ctime;

@end


@interface CouponVC : UIViewController

@end

