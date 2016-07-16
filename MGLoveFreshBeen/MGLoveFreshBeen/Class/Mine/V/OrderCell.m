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
@property (nonatomic,strong) NSArray *goods;
/** 商品数组 */
@property (nonatomic,strong) NSMutableArray *goodses;
/** 商品数组 */
@property (nonatomic,strong) NSMutableArray *pictures;

@end

@implementation OrderCell
#pragma mark - lazy
- (NSArray *)goods{
    if (_goods == nil) {
        _goods = [NSArray array];
    }
    return _goods;
}

- (NSMutableArray *)goodses{
    if (_goodses == nil) {
        _goodses = [NSMutableArray array];
    }
    return _goodses;
}

- (NSMutableArray *)pictures{
    if (_pictures == nil) {
        _pictures = [NSMutableArray array];
    }
    return _pictures;
}

#pragma mark - 快速创建cell
+ (instancetype)OrderCellWithTableView:(UITableView *)tableView withImages:(NSArray *)images{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:KOrderCellIdentifier];
    cell.goods = images;
    cell.orderModel.order_goods = images;
    [cell setUpOrderPictureView];
    if (cell == nil) {
         cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OrderCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}


// 重新setFrame方法，添加底部分割线
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 15;
    //    frame.origin.x += 10;
    //    frame.size.width -= 20;
    [super setFrame:frame];
}

#pragma mark - 添加图片数组
- (void)setUpOrderPictureView{
    CGFloat indexMargin = 0;
    if (IS_IPHONE4) {
        indexMargin = 60;
    }else{
        indexMargin = 70;
    }
    
    NSInteger goodssesCount = self.goods.count;
    for (int i = 0; i<goodssesCount; i++){
        
        self.goodses = self.goods[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(i *(indexMargin)+ MGMargin, 7, 50, 50)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.pictures addObject:imageView];
        [self.orderPictureView addSubview:imageView];
    }
}

#pragma mark - 重新复制模型
- (void)setOrderModel:(Order *)orderModel{
    _orderModel = orderModel;
    self.timeLabel.text = orderModel.create_time;
    self.statusLabel.text = orderModel.textStatus;
    self.orderCountLabel.text = [NSString stringWithFormat:@"共%d件商品",orderModel.buy_num];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"$%@元",orderModel.user_pay_amount];
    
    NSInteger goodssesCount = self.goods.count;
    for (int i = 0; i<goodssesCount; i++){
        
        self.goodses = self.goods[i];
        
        UIImageView *imageView = self.pictures[i];
        
        NSInteger JCount = self.goodses.count;
        for (int j = 0; j<JCount; j++) {
            OrderGoods *good = self.goodses[j];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[good valueForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"12.jpg"]];
        }
        
        
        if (i< 5) {
            if (4 == i) {
                imageView.image = [UIImage imageNamed:@"v2_goodmore"];
                imageView.hidden = NO;
            }
            
        }else {
            imageView.hidden = YES;
        }
    }

}

#pragma mark - 发福利
- (IBAction)shareFuli:(id)sender {
    
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

@end
