//
//  OrderCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface OrderCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) Order * orderModel;

@end
