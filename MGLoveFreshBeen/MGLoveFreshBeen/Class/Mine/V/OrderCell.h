//
//  OrderCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

static NSString * const KOrderCellIdentifier = @"KOrderCellIdentifier";

@interface OrderCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) Order * orderModel;

+ (instancetype)OrderCellWithTableView:(UITableView *)tableView withImages:(NSArray *)images;

@end
