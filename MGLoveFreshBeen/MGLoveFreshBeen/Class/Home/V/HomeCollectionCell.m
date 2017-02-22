//
//  HomeCollectionCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeCollectionCell.h"
#import "HeadReosurce.h"
#import "HotFreshModel.h"
#import "BuyView.h"

typedef enum{
    HomeCellTypeHorizontal, // 一行显示1个item
    HomeCellTypeVertical // 一行显示2个item
} HomeCellType; // cell显示类型

@interface HomeCollectionCell ()
{
    UIImageView *backImageView; // 背景图
    UIImageView *goodsImageView; // 商品图片
    UIImageView *fineImageView; // 精选
    UIImageView *giveImageView; //  买一送一
    UILabel *specificsLabel; // 特价
    UILabel *nameLabel; // 商品名称
    
    UIView *discountPriceView;  // 打折的view
    UILabel *marketPriceLabel; // 超市价格
    UILabel *priceLabel; // 商品价格
    BuyView *buyView;
}

/** // cell类型type */
@property (nonatomic, assign) HomeCellType type;
@end


@implementation HomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
/**
 *  设置UI界面
 */
- (void)setupUI{
    backImageView = [[UIImageView alloc] init];
    [self addSubview:backImageView];
    
    goodsImageView = [[UIImageView alloc] init];
    goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:goodsImageView];
    
    fineImageView = [[UIImageView alloc] init];
    fineImageView.image = [UIImage imageNamed:@"jingxuan.png"];
    [self addSubview:fineImageView];
    
    
    giveImageView = [[UIImageView alloc] init];
    giveImageView.image = [UIImage imageNamed:@"buyOne.png"];
    [self addSubview:giveImageView];
    
    specificsLabel = [[UILabel alloc] init];
    specificsLabel.textColor = MGRGBColor(100, 100, 100);
    specificsLabel.font = MGFont(12);
    specificsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:specificsLabel];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = MGRGBColor(1, 1, 1);
    nameLabel.font = MGFont(14);
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:nameLabel];
    
    __weak typeof(self) weakSelf = self;
    buyView = [[BuyView alloc] initWithFrame:CGRectZero withBlock:^{
        if (weakSelf.addButtonClick != nil) {
            weakSelf.addButtonClick(goodsImageView);
        }
    }];
    [self addSubview:buyView];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    backImageView.frame = self.bounds;
    goodsImageView.frame = CGRectMake(0, 0, self.width, self.width);
    nameLabel.frame = CGRectMake(5, CGRectGetMaxY(goodsImageView.frame), self.width - 15, 20);
    fineImageView.frame = CGRectMake(5, CGRectGetMaxY(nameLabel.frame), 30, 15);
    giveImageView.frame = CGRectMake(CGRectGetMaxX(fineImageView.frame) + MGSmallMargin, fineImageView.y, 35, 15);
    specificsLabel.frame = CGRectMake(nameLabel.x, CGRectGetMaxY(fineImageView.frame), self.contentView.width, 20);
    
    discountPriceView.frame = CGRectMake(nameLabel.x, CGRectGetMaxY(specificsLabel.frame), 80, self.contentView.height - CGRectGetMaxY(specificsLabel.frame));
    buyView.frame = CGRectMake(self.width - 85, self.height - 30, 80, 20);
}


#pragma mark - 重写
/** 
 *  这边cell有两种类型 ，第一组是一行只有一个cell的，第二组是一行有两个cell的 根据不同类型决定控件是否需要隐藏
 */
- (void)setType:(HomeCellType)type{
    _type = type;
    backImageView.hidden = (type == HomeCellTypeVertical);
    goodsImageView.hidden = (type == HomeCellTypeHorizontal);
    nameLabel.hidden = (type == HomeCellTypeHorizontal);
    fineImageView.hidden = (type == HomeCellTypeHorizontal);
    giveImageView.hidden = (type == HomeCellTypeHorizontal);
    specificsLabel.hidden = (type == HomeCellTypeHorizontal);
    discountPriceView.hidden = (type == HomeCellTypeHorizontal);
    buyView.hidden = (type == HomeCellTypeHorizontal);
}

/**
 *  重写商品模型的setter方法
 */
- (void)setGoodModel:(HotGoods *)goodModel{
    _goodModel = goodModel;
    self.type = HomeCellTypeVertical;
    
    nameLabel.text = goodModel.name;
    
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodModel.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    
    if ([goodModel.pm_desc isEqualToString:@"买一赠一"]) {
        giveImageView.hidden = NO;
    } else {
        giveImageView.hidden = YES;
    }
    
    // 打折
    if (discountPriceView != nil) {
        [discountPriceView removeFromSuperview];
    }
    discountPriceView = [self discountPriceView];
     discountPriceView.frame = CGRectMake(nameLabel.x, CGRectGetMaxY(specificsLabel.frame), 60, self.contentView.height - CGRectGetMaxY(specificsLabel.frame));
    [self.contentView addSubview:discountPriceView];
    priceLabel.text = [NSString stringWithFormat:@"$%@",goodModel.partner_price];
    marketPriceLabel.text = [NSString stringWithFormat:@"$%@",goodModel.market_price];
    marketPriceLabel.hidden = [priceLabel.text isEqualToString:marketPriceLabel.text];
    
    specificsLabel.text = goodModel.specifics;
    buyView.goods = goodModel;
}

/**
 *  重写模型的setter方法  一行的话只显示背景图解图片，其他控件隐藏
 */
- (void)setActivity:(Activities *)Activity{
    _Activity = Activity;
    self.type = HomeCellTypeHorizontal;
    [backImageView sd_setImageWithURL:[NSURL URLWithString:Activity.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_full_size"]];
}

/**
 *  快速创建打折的View
 */
- (UIView *)discountPriceView{
    UIView *discountPriceView2 = [[UIView alloc] init];
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 15)];
    priceLabel.font = MGFont(13);
    priceLabel.textColor = [UIColor redColor];
    [discountPriceView2 addSubview:priceLabel];
    
    marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame) + 1, 0, priceLabel.width,  priceLabel.height)];
    marketPriceLabel.textColor = MGRGBColor(80, 80, 80);
    marketPriceLabel.font = MGFont(13);
    [discountPriceView2 addSubview:marketPriceLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, marketPriceLabel.height * 0.5 - 0.5, marketPriceLabel.width, 1)];
    lineView.backgroundColor = MGRGBColor(80, 80, 80);
    [marketPriceLabel addSubview:lineView];
    return discountPriceView2;
}



@end
