//
//  ProductsCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotGoods;

@interface ProductsCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) HotGoods *hotGood;

/**
 *  快速创建ProductsCell
 */
+ (instancetype)productsCellWithTableView:(UITableView *)tableView;

@end
