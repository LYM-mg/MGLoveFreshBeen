//
//  ProductsCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Goods;

@interface ProductsCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) Goods *goods;

+ (instancetype)productsCellWithTableView:(UITableView *)tableView;

@end
