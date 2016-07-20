//
//  StandardsView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/20.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

//出场动画
typedef enum _StandsViewShowAnimationType
{
    StandsViewShowAnimationShowFrombelow ,//从下面
    StandsViewShowAnimationFlash,//闪出
    StandsViewShowAnimationShowFromLeft,//从左边
    StandsViewShowAnimationCustom = 0xFFFF // 自定义
    
} StandsViewShowAnimationType;

//退场动画
typedef enum _StandsViewAnimationType
{
    StandsViewDismissAnimationDisFrombelow,//从下面退出
    StandsViewDismissAnimationFlash,//逐渐消失
    StandsViewDismissAnimationDisToRight,
    StandsViewDismissAnimationCustom = 0xFFFF // 自定义
    
} StandsViewDismissAnimationType;


#pragma mark - StandardsViewDelegate
@class StandardsView;
@protocol StandardsViewDelegate <NSObject>


/**
 * 点击规格分类按键回调
 * @param sender 点击的按键
 * @param selectID 选中规格id
 * @param standName 规格名称
 * @param index  规格所在cell的row
 */
-(void)Standards:(StandardsView *)standardView SelectBtnClick:(UIButton *)sender;

/**
 * 自定义出场动画 StandsBackViewAnimationType 需设置成StandsViewAnimationCustom
 */
-(void)CustomShowAnimation;
/**
 * 自定义消失动画 StandsBackViewAnimationType 需设置成StandsViewAnimationCustom
 */
-(void)CustomDismissAnimation;
@end



@interface StandardsView : UIView

#pragma mark - 必要条件
//商品简介view
/** 商品的图片 */
@property (nonatomic,strong) UIImageView *shopImageView;
/** 商品的价格 */
@property (nonatomic,strong) UILabel *priceLabel;
/** 商品的库存数量 */
@property (nonatomic,strong) UILabel *countlabel;
/** 商品的尺寸 */
@property (nonatomic,strong) UILabel *sizeLabel;
/** 要购买的商品数 read － write(初始值) 默认1可不设置 */
@property (nonatomic,assign) int buyTotalCount;

#pragma mark - 非必需 效果相关
/*商品详情页 设置该属性调用show会自带商品详情页后移动画,在ios7中 如果页面不是navgation过来的自身也会缩小*/
@property (nonatomic) UIView *GoodDetailView;
@property (nonatomic) StandsViewShowAnimationType showAnimationType;
@property (nonatomic) StandsViewDismissAnimationType dismissAnimationType;
@property(nonatomic)id<StandardsViewDelegate>delegate;


/**
 * 显示规格
 */
- (void)show;
/**
 * 关闭显示
 */
- (void)dismiss;

#pragma mark - animation
/**
 * 将商品图片抛到指定点
 * @param destPoint  扔到的点
 * @param height  高度，抛物线最高点比起点/终点y坐标最低(即高度最高)所超出的高度
 * @param duration  动画时间 传0  默认1.6s
 * @param Scale  view 变小的比例 传0  默认20
 */
-(void)ThrowGoodTo:(CGPoint)destPoint andDuration:(NSTimeInterval)duration andHeight:(CGFloat)height andScale:(CGFloat)Scale;
/**
 * 按比例改变view的大小
 * @param backView  要改变的view
 * @param duration  动画时间
 * @param valuex  x缩小的比例
 * @param valueY  y缩小的比例
 */
-(void)setBackViewAnimationScale:(UIView *)backView andDuration:(NSTimeInterval)duration toValueX:(CGFloat)valueX andValueY:(CGFloat)valueY;

@end
