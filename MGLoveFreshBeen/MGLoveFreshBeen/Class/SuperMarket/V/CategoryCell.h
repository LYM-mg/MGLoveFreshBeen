//
//  CategoryCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoriesModel;

@interface CategoryCell : UITableViewCell

/** 分类模型 */
@property (nonatomic,strong) CategoriesModel *categoryModel;

+ (instancetype)categoryCellWithTableView:(UITableView *)tableView;

@end
