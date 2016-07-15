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
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;

/** 图片数组 */
@property (nonatomic,strong) NSArray *goodsses;
/** 商品数组 */
@property (nonatomic,strong) NSMutableArray *goodsseses;
/** 商品数组 */
@property (nonatomic,strong) NSMutableArray *goods;
/** 图片数组 */
@property (nonatomic,strong) NSMutableArray *pictures;
@end

@implementation OrderCell
- (NSArray *)goodsses{
    if (_goodsses == nil) {
        _goodsses = [NSArray array];
    }
    return _goodsses;
}

- (NSMutableArray *)goodsseses{
    if (_goodsseses == nil) {
        _goodsseses = [NSMutableArray array];
    }
    return _goodsseses;
}

- (NSMutableArray *)pictures{
    if (_pictures == nil) {
        _pictures = [NSMutableArray array];
    }
    return _pictures;
}

+ (instancetype)OrderCellWithTableView:(UITableView *)tableView withImages:(NSArray *)images{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:KOrderCellIdentifier];
    cell.goodsses = images;
    cell.orderModel.order_goods = images;
    [cell setUpOrderPictureView];
    if (cell == nil) {
         cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OrderCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)setUpOrderPictureView{
    CGFloat indexMargin = 0;
    if (IS_IPHONE4) {
        indexMargin = 60;
    }else{
        indexMargin = 70;
    }
    
    NSInteger goodssesCount = self.goodsses.count;
    for (int i = 0; i<goodssesCount; i++){
        
        self.goodsseses = self.goodsses[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(i *(indexMargin)+MGMargin, 7, 50, 50)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.orderPictureView addSubview:imageView];
    
        [self.pictures addObject:imageView];
        
        if (4 == i) {
            imageView.image = [UIImage imageNamed:@"v2_goodmore"];
        }
        if (i>5) {
            imageView.hidden = YES;
        }else {
            imageView.hidden = NO;
        }
        NSInteger JCount = self.goodsseses.count;
        for (int j = 0; j<JCount; j++) {
            OrderGoods *good = self.goodsseses[j];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[good valueForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"12.jpg"]];
        }

        
        
        // 获取指定的目录
        // NSUserDomainMask,默认手机开发的话，就填该参数
        // YES是表示详细目录，如果填NO的话，那么前面的目录默认会用~表示，这个~在电脑可以识别，在手机里面是不能识别的，所以默认也用YES
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        // 拼接路径名称
        //NSString *filePath = [path stringByAppendingString:@"array.plist"];
//        NSString *filePath = [path stringByAppendingPathComponent:@"array.plist"];
        
        //把数组写入到文件
//        [self.goodsses writeToFile:filePath atomically:YES];

    }
    
//    for (int i = 0; i<count; i++){
//        UIImageView *subImageView = self.pictures[i];
//        if (i < 5) {
//            subImageView.hidden = NO;
//            if (i == 4) {
//                [subImageView setImage:[UIImage imageNamed:@"author"]];
//            }else{
//                 OrderGoods *good = self.goods[i];
//                [subImageView sd_setImageWithURL:[NSURL URLWithString:good.img] placeholderImage:[UIImage imageNamed:@"author"]];
//            }
//        }else if (i>5){
//            subImageView.hidden = YES;
//        }
//    }
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
    self.orderCountLabel.text = [NSString stringWithFormat:@"共%d件商品",orderModel.buy_num];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"$%@元",orderModel.user_pay_amount];
//    goodsImageViews?.order_goods = orderModel.order_goods;
//    buttons?.buttons = orderModel?.buttons;
}

// 发福利
- (IBAction)shareFuli:(id)sender {
    
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor orangeColor];
    }else{
         self.backgroundColor = [UIColor whiteColor];
    }
}

@end
