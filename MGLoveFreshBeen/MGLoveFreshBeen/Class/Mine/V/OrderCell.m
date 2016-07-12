//
//  OrderCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "OrderCell.h"
#import "OrderCellModel.h"

@interface OrderCell ()
/** 日期 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 中间存放imageView的容器 */
@property (weak, nonatomic) IBOutlet UIView *orderPictureView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    OrderCell *cell = nil;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OrderCell class]) owner:nil options:nil].firstObject;
        cell.width = MGSCREEN_width;
        cell.height = 160;
    }
    return cell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    
}

- (void)setOrderModel:(Order *)orderModel{
    _orderModel = orderModel;
    self.timeLabel.text = orderModel.create_time;
    self.statusLabel.text = orderModel.textStatus;
//    goodsImageViews?.order_goods = orderModel.order_goods;
    self.totalCountLabel.text = [NSString stringWithFormat:@"共%d件商品",orderModel.buy_num];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"$%@元",orderModel.user_pay_amount];
//    buttons?.buttons = orderModel?.buttons;
}

// 发福利
- (IBAction)shareFuli:(id)sender {
    
}

@end
