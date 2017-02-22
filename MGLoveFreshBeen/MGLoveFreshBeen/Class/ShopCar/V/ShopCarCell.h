//
//  ShopCarCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotGoods;
@interface ShopCarCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic,strong) HotGoods *goods;

+ (instancetype)shopCarCellWithTableView:(UITableView *)tableView;

@end
