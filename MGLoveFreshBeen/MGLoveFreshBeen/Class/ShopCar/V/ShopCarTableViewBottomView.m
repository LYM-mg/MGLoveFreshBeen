//
//  ShopCarTableViewBottomView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarTableViewBottomView.h"
#import "UserShopCarTool.h"

@interface ShopCarTableViewBottomView ()
/** titleLabel */
@property (nonatomic,weak) UILabel *titleLabel;
/** priceLabel */
@property (nonatomic,weak) UILabel *priceLabel;
/** sureButton */
@property (nonatomic,weak) UIButton *sureButton;
/** 背景View */
//@property (nonatomic,weak) UIView *backView;
@end

@implementation ShopCarTableViewBottomView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法
/**
 *  创建UI
 */
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:[self lineView:CGRectMake(0, 0, MGSCREEN_width, 0.5)]];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"共$ ";
    titleLabel.font = MGFont(14);
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.frame = CGRectMake(15, 0, titleLabel.width, MGShopCartRowHeight);
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = MGFont(14);
    priceLabel.textColor = [UIColor redColor];
    priceLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, MGSCREEN_width * 0.5, MGShopCartRowHeight);
    priceLabel.text = [UserShopCarTool shareUserShopCarTool].getAllProductsPrice;
    [self addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    UIButton *sureButton = [[UIButton alloc] init];
    sureButton.frame = CGRectMake(MGSCREEN_width - 90, 0, 90, MGShopCartRowHeight);
    sureButton.backgroundColor = [UIColor yellowColor];
    [sureButton setTitle:@"选好了" forState: UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    sureButton.titleLabel.font = MGFont(14);
    [sureButton addTarget:self action:@selector(sureButtonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureButton];
    _sureButton = sureButton;
    
    [self addSubview:[self lineView:CGRectMake(0, MGShopCartRowHeight - 0.5, MGSCREEN_width, 0.5)]];
}

/**
 *  确认订单
 */
- (void)sureButtonButtonClick{
    if (self.sureProductsButtonClickWoothBlock) {
        self.sureProductsButtonClickWoothBlock();
    }
}

/**
 *  分割线
 *
 *  @param frame 尺寸
 *
 *  @return 分割线
 */
- (UIView *)lineView:(CGRect)frame {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}
                                   
#pragma mark - 重写 价格
- (void)setPriceLabelText:(double)price{
    self.priceLabel.text = [self cleanDecimalPointZear:[NSString stringWithFormat:@"%f",price]];
}

/// 清除字符串小数点末尾的0
- (NSString *)cleanDecimalPointZear:(NSString *)newStr {
    
    NSString *s = [NSString string];
    
    long offset = newStr.length - 1;
    while (offset > 0) {
        s = [newStr substringWithRange:NSMakeRange(offset, 1)];
        if ([s isEqualToString:@"0"] || [s isEqualToString:@"."]) {
            offset--;
        } else {
            break;
        }
    }
    
    return [newStr substringToIndex:(offset + 1)];
}

                                   
@end
