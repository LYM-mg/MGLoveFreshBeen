//
//  OrderCellModel.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - OrderCellModel

@interface OrderCellModel : NSObject
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int code;
@property (nonatomic,strong) NSArray *data;

@end

@interface Order : NSObject
@property (nonatomic, assign) int star;
@property (nonatomic,copy) NSString *comment;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *accept_name;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *pay_code;
@property (nonatomic,copy) NSString *pay_type;
@property (nonatomic,copy) NSString *distribution;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *pay_status;
@property (nonatomic,copy) NSString *distribution_status;
@property (nonatomic,copy) NSString *postcode;
@property (nonatomic,copy) NSString *telphone;
@property (nonatomic,copy) NSString *country;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *payable_amount;
@property (nonatomic,copy) NSString *real_amount;
@property (nonatomic,copy) NSString *pay_time;
@property (nonatomic,copy) NSString *send_time;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *completion_time;
@property (nonatomic,copy) NSString *order_amount;
@property (nonatomic,copy) NSString *accept_time;
@property (nonatomic,copy) NSString *lastUpdateTime;
@property (nonatomic,copy) NSString *preg_dealer_type;
@property (nonatomic,copy) NSString *user_pay_amount;
@property (nonatomic,copy) NSString *order_goods;
@property (nonatomic, assign) int enableComment;
@property (nonatomic, assign) int isCommented;
@property (nonatomic, assign) int newStatus;
@property (nonatomic,copy) NSString *status_timeline;
@property (nonatomic,copy) NSString *fee_list;
@property (nonatomic, assign) int buy_num;
@property (nonatomic, assign) int showSendCouponBtn;
@property (nonatomic,copy) NSString *dealer_name;
@property (nonatomic,copy) NSString *dealer_address;
@property (nonatomic,copy) NSString *dealer_lng;
@property (nonatomic,copy) NSString *dealer_lat;
@property (nonatomic,copy) NSString *buttons;
@property (nonatomic,copy) NSString *detail_buttons;
@property (nonatomic,copy) NSString *textStatus;
@property (nonatomic, assign) int in_refund;
@property (nonatomic,copy) NSString *checknum;
@property (nonatomic,copy) NSString *postscript;

@end


#pragma mark - OrderGoods
@interface OrderGoods: NSObject
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *goods_price;
@property (nonatomic,copy) NSString *real_price;
@property (nonatomic, assign) int intisgift;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *specifics;
@property (nonatomic,copy) NSString *brand_name;
@property (nonatomic,copy) NSString *img;
@property (nonatomic, assign) int is_gift;
@property (nonatomic,copy) NSString *goods_nums;
@end


#pragma mark - OrderStatus
@interface OrderStatus: NSObject
@property (nonatomic,copy) NSString *status_title;
@property (nonatomic,copy) NSString *status_desc;
@property (nonatomic,copy) NSString *status_time;
@end

#pragma mark - OrderFeeList
@interface OrderFeeList: NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *value;
@end

#pragma mark - OrderButton
@interface OrderButton: NSObject
@property (nonatomic, assign) int type;
@property (nonatomic,copy) NSString *text;
@end

