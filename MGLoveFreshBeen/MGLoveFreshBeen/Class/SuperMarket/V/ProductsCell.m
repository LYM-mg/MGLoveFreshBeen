//
//  ProductsCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ProductsCell.h"
#import "SuperMarketModel.h"
#import "HotFreshModel.h"

@interface ProductsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIImageView *fineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buyOneImageView;
@property (weak, nonatomic) IBOutlet UILabel *discountPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *discountPriceView;
@property (weak, nonatomic) IBOutlet UILabel *specialLabel;

@end

@implementation ProductsCell

- (void)awakeFromNib {
    // Initialization code
}

/**
 *  快速创建ProductsCell
 */
+ (instancetype)productsCellWithTableView:(UITableView *)tableView{
    static NSString *const KProductsCellIdentifier = @"KProductsCellIdentifier";
    ProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:KProductsCellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ProductsCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}

/**
 *  重写HotGoods模型
 */
- (void)setHotGood:(HotGoods *)hotGood{
    _hotGood = hotGood;
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[hotGood valueForKeyPath:@"img"]] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    
    _productName.text = [hotGood valueForKeyPath:@"name"];
    _buyOneImageView.hidden = [[hotGood valueForKeyPath:@"pm_desc"] isEqualToString:@"买一赠一"];
    
    _fineImageView.hidden = ((int)[hotGood valueForKeyPath:@"is_xf"] == 1);

    _specialLabel.text = [hotGood valueForKeyPath:@"specifics"];
    
    _originPriceLabel.text = [hotGood valueForKeyPath:@"market_price"];
    
    _discountPriceLabel.text = [hotGood valueForKeyPath:@"partner_price"];
    
    _discountPriceView.hidden = (_originPriceLabel.text == _discountPriceLabel.text);
    _discountPriceLabel.hidden = (_originPriceLabel.text == _discountPriceLabel.text);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/** 添加商品到购物车 */
- (IBAction)AddProductToShopCarClick:(UIButton *)sender {
    
}


@end
