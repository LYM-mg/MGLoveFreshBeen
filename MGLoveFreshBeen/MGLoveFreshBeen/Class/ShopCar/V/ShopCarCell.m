//
//  ShopCarCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarCell.h"
#import "BuyView.h"
#import "HotFreshModel.h"

@interface ShopCarCell ()
{
    UILabel *titleLabel;
    UILabel *priceLabel;
    BuyView *buyView;
}
@end

@implementation ShopCarCell

/**
 *  快速创建cell
 */
static NSString *const KShopCarCellIdentifier = @"KShopCarCellIdentifier";
+ (instancetype)shopCarCellWithTableView:(UITableView *)tableView{
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:KShopCarCellIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KShopCarCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setUpUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 0, MGSCREEN_width * 0.5, MGShopCartRowHeight);
    titleLabel.font = MGFont(15);
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    
    buyView = [[BuyView alloc] initWithFrame:CGRectMake(MGSCREEN_width - 85, (MGShopCartRowHeight - 25) * 0.55, 80, 25)];
    [self.contentView addSubview:buyView];
    
    priceLabel = [[UILabel alloc] init];
    priceLabel.frame = CGRectMake(CGRectGetMinX(buyView.frame) - 100 - 5, 0, 100, MGShopCartRowHeight);
    priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:priceLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, MGShopCartRowHeight - 0.5, MGSCREEN_width - 10, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [self.contentView addSubview:lineView];
}

#pragma mark - 重写模型
- (void)setGoods:(HotGoods *)goods{
    _goods = goods;
    if (goods.is_xf == 1) {
        titleLabel.text = [NSString stringWithFormat:@"[精选]%@",goods.name];
    } else {
        titleLabel.text = goods.name;
    }
    
    priceLabel.text = [NSString stringWithFormat:@"$%@",goods.price];
    
    buyView.goods = goods;
}


- (void)awakeFromNib {
    [self setUpUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
