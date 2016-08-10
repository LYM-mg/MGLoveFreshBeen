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
        self.zearIsShow = NO;
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
    self.buyNumber++;
    self.goods.userBuyNumber = self.buyNumber;
    self.buyCountLabel.text = [NSString stringWithFormat:@"%d",_buyNumber];
    self.buyCountLabel.hidden = NO;
    
    if (self.clickAddShopCar != nil) {
        self.clickAddShopCar();
    }
#warning 通知
    [[ShopCarRedDotView shareShopCarRedDotView] addProductToRedDotView:YES];
    [[UserShopCarTool shareUserShopCarTool] addSupermarkProductToShopCar:self.goods];
    [MGNotificationCenter postNotificationName:MGShopCarBuyPriceDidChangeNotification object:nil userInfo:nil];
}

/**
 *  删除商品的点击
 */
- (void)reduceGoodsButtonClick{
    if (self.buyNumber <= 0) {
        return;
    }
    
    _buyNumber--;
    self.goods.userBuyNumber = _buyNumber;
    if (self.buyNumber == 0) {
        _reduceGoodsButton.hidden = YES && !self.zearIsShow;
        _buyCountLabel.hidden = YES && !self.zearIsShow;
        _buyCountLabel.text = self.zearIsShow ? @"0" : @"";
        [[UserShopCarTool shareUserShopCarTool] removeSupermarketProduct:self.goods];
    } else {
        _buyCountLabel.text = [NSString stringWithFormat:@"%d",self.buyNumber];
    }
    
    [[ShopCarRedDotView shareShopCarRedDotView] addProductToRedDotView:YES];
    // 价格
    [MGNotificationCenter postNotificationName:MGShopCarBuyPriceDidChangeNotification object:nil userInfo:nil];
}

#pragma mark - 重写
/**
 *  重写商品模型方法
 *
 *  @param buyNumber 商品模型
 */
- (void)setGoods:(HotGoods *)goods{
    _goods = goods;
    self.buyNumber = goods.userBuyNumber;
    
    if (goods.number <= 0) { // 库存没有了
        [self showSupplementLabel];
    } else {
        [self hideSupplementLabel];
    }
    if (0 == self.buyNumber) {
        _reduceGoodsButton.hidden = YES && !self.zearIsShow;
        _buyCountLabel.hidden = YES && !self.zearIsShow;
    } else {
        _reduceGoodsButton.hidden = NO;
        _buyCountLabel.hidden = NO;
    }
}

/// 显示补货中
- (void)showSupplementLabel {
    _supplementLabel.hidden = NO;
    _addGoodsButton.hidden = YES;
    _reduceGoodsButton.hidden = YES;
    _buyCountLabel.hidden = YES;
}

/// 隐藏补货中,显示添加按钮
- (void)hideSupplementLabel {
    _supplementLabel.hidden = YES;
    _addGoodsButton.hidden = NO;
    _reduceGoodsButton.hidden = NO;
    _buyCountLabel.hidden = NO;
}


/**
 *  重写数量方法
 *
 *  @param buyNumber 购买数量
 */
- (void)setBuyNumber:(int)buyNumber{
    _buyNumber = buyNumber;
    
    if (buyNumber > 0) {
        _reduceGoodsButton.hidden = NO;
    } else {
        _reduceGoodsButton.hidden = YES;
        _buyCountLabel.hidden = NO;
    }

    _buyCountLabel.text = [NSString stringWithFormat:@"%d",buyNumber];
}

@end
