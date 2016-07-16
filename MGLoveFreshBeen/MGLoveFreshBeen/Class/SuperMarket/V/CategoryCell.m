//
//  CategoryCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "CategoryCell.h"
#import "SuperMarketModel.h"

@interface CategoryCell()
/** 分类指示器 */
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
/** 分类名字 */
@property (weak, nonatomic) IBOutlet UILabel *categoryName;

@end

@implementation CategoryCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.indicatorView.hidden = YES;
    self.categoryName.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = MGRGBColor(222, 222, 222);
}

+ (instancetype)categoryCellWithTableView:(UITableView *)tableView{
    static NSString *const KCategoryCellIdentifier = @"KCategoryCellIdentifier";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:KCategoryCellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CategoryCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)setCategoryModel:(CategoriesModel *)categoryModel{
    _categoryModel = categoryModel;
//    self.categoryName.text = categoryModel.name;
    self.categoryName.text = [categoryModel valueForKey:@"name"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.categoryName.textColor = selected ? [UIColor orangeColor] : [UIColor grayColor];
    self.indicatorView.hidden = !selected;
}

@end
