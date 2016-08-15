//
//  BuyView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "BuyView.h"
#import "HotFreshModel.h"
#import "ShopCarRedDotView.h"
#import "UserShopCarTool.h"

@interface BuyView ()
/** 添加按钮 */
@property (nonatomic,weak) UIButton *addGoodsButton;
/** 删除按钮 */
@property (nonatomic,weak) UIButton *reduceGoodsButton;
/** 购买数量 */
@property (nonatomic,weak) UILabel *buyCountLabel;
/** 补货中 */
@property (nonatomic,weak) UILabel *supplementLabel;

/** 添加商品到购物车 */
@property (nonatomic,copy) void (^clickAddShopCar)();

@end

@implementation BuyView

- (instancetype)initWithFrame:(CGRect)frame withBlock:(void (^)())clickAddShopCar{
    if (self = [super init]) {
        self.clickAddShopCar = clickAddShopCar;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.buyViewShowWhenBuyCountLabelZero = NO;
        self.buyNumber = 0;
        
        [self setUpUI];
    }
    return self;
}


#pragma mark - 私有方法
- (void)setUpUI{
    /// 1.添加按钮
    UIButton *addGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addGoodsButton setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
    [addGoodsButton addTarget:self action:@selector(addGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.addGoodsButton = addGoodsButton;
    [self addSubview:addGoodsButton];
    
    /// 2.删除按钮
    UIButton *reduceGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceGoodsButton setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
    [reduceGoodsButton addTarget:self action:@selector(reduceGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    reduceGoodsButton.hidden = NO;
    self.reduceGoodsButton = reduceGoodsButton;
    [self addSubview:reduceGoodsButton];
    
    /// 3.购买数量
    UILabel *buyCountLabel = [[UILabel alloc] init];
    buyCountLabel.hidden = NO;
    buyCountLabel.text = @"0";
    buyCountLabel.textColor = [UIColor blackColor];
    buyCountLabel.textAlignment = NSTextAlignmentCenter;
    buyCountLabel.font = MGFont(14);
    self.buyCountLabel = buyCountLabel;
    [self addSubview:buyCountLabel];
    
    /// 4.补货中
    UILabel *supplementLabel = [[UILabel alloc] init];
    supplementLabel.hidden = YES;
    supplementLabel.text = @"补货中";
    supplementLabel.textColor = [UIColor redColor];
    supplementLabel.textAlignment = NSTextAlignmentRight;
    supplementLabel.font = MGFont(14);
    self.supplementLabel = supplementLabel;
    [self addSubview:supplementLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat buyCountWidth = 25;
    self.addGoodsButton.frame = CGRectMake(self.width - self.height - 2, 0, self.height, self.height);
    self.buyCountLabel.frame = CGRectMake(CGRectGetMinX(_addGoodsButton.frame) - buyCountWidth, 0, buyCountWidth, self.height);
    self.reduceGoodsButton.frame = CGRectMake(CGRectGetMinX(_buyCountLabel.frame) - self.height, 0, self.height, self.height);
    self.supplementLabel.frame = CGRectMake(CGRectGetMinX(_reduceGoodsButton.frame), 0, self.height + buyCountWidth + self.height, self.height);
}


#pragma mark - Action
/**
 *  添加商品的点击
 */
- (void)addGoodsButtonClick{
    if (self.buyNumber >= [self.goods number]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MGHomeGoodsInventoryProblem object:self.goods.name];
        return;
    }
    
    _reduceGoodsButton.hidden = NO;
    self.buyCountLabel.hidden = NO;
    self.buyNumber++;
    self.goods.userBuyNumber = self.buyNumber;
    self.buyCountLabel.text = [NSString stringWithFormat:@"%d",_buyNumber];
    
    if (self.clickAddShopCar != nil) {
        self.clickAddShopCar();
    }
#warning 通知
    [[ShopCarRedDotView shareShopCarRedDotView] addProductToRedDotView:YES];
    [[UserShopCarTool shareUserShopCarTool] addSupermarkProductToShopCar:self.goods];
    [MGNotificationCenter postNotificationName:MGShopCarBuyPriceDidChangeNotification object:nil userInfo:nil];
    [MGNotificationCenter postNotificationName:MGShopCarBuyNumberDidChangeNotification object:nil];
}

/**
 *  删除商品的点击
 */
- (void)reduceGoodsButtonClick{
    if (self.buyNumber <= 0) {
        return;
    }
    
    _buyNumber--;
    self.goods.userBuyNumber = self.buyNumber;
    
    if (self.buyNumber == 0) {
        _reduceGoodsButton.hidden = YES && !self.buyViewShowWhenBuyCountLabelZero;
        _buyCountLabel.hidden = YES && !self.buyViewShowWhenBuyCountLabelZero;
        _buyCountLabel.text = self.isBuyViewShowWhenBuyCountLabelZero ? @"0" : @"";
        [[UserShopCarTool shareUserShopCarTool] removeSupermarketProduct:self.goods];
    } else {
        _buyCountLabel.text = [NSString stringWithFormat:@"%d",self.buyNumber];
    }
    
    [[ShopCarRedDotView shareShopCarRedDotView] reduceProductToRedDotView:YES];
    // 价格
    [MGNotificationCenter postNotificationName:MGShopCarBuyPriceDidChangeNotification object:nil userInfo:nil];
    [MGNotificationCenter postNotificationName:MGShopCarBuyNumberDidChangeNotification object:nil];
}

#pragma mark - 重写
/**
 *  重写商品模型方法
 *
 *  @param buyNumber 商品模型
 */
- (void)setGoods:(HotGoods *)goods{
    _goods = goods;
    if (goods.number <= 0) { // 库存没有了
        [self showSupplementLabel:YES];
    } else {
        [self showSupplementLabel:NO];
    }
    
    
    self.buyNumber = goods.userBuyNumber;
}

/// 显示补货中
- (void)showSupplementLabel:(BOOL)hidden {
    if (hidden) { /// 显示补货中
        _supplementLabel.hidden = NO;
        _addGoodsButton.hidden = YES;
        _reduceGoodsButton.hidden = YES;
        _buyCountLabel.hidden = YES;
    }else{
        /// 隐藏补货中,显示添加按钮
        _supplementLabel.hidden = YES;
        _addGoodsButton.hidden = NO;
        _reduceGoodsButton.hidden = NO;
        _buyCountLabel.hidden = NO;
    }
}


/**
 *  重写数量方法
 *
 *  @param buyNumber 购买数量
 */
- (void)setBuyNumber:(int)buyNumber{
    _buyNumber = buyNumber;
    
    if (self.buyViewShowWhenBuyCountLabelZero) {
        self.reduceGoodsButton.hidden = YES;
        self.buyCountLabel.hidden = YES;
    }else {
        if (buyNumber > 0) {
            _reduceGoodsButton.hidden = NO;
            _buyCountLabel.hidden = NO;
        } else {
            _reduceGoodsButton.hidden = YES && !self.buyViewShowWhenBuyCountLabelZero;
            _buyCountLabel.hidden = YES && !self.buyViewShowWhenBuyCountLabelZero;
        }
    }

    _buyCountLabel.text = [NSString stringWithFormat:@"%d",buyNumber];
}

@end
