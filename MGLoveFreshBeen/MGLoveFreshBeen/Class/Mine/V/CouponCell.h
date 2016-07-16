//
//  CouponCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Coupon;

@interface CouponCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) Coupon *couponModel;

+ (instancetype)couponCellWithTableView:(UITableView *)tableView;

@end
