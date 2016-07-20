//
//  StandardsView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/20.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "StandardsView.h"

/** 商品距离左边的距离 */
#define KShopToLeft 20
#define GoodDetailScaleValue    0.9

@interface StandardsView ()
{
    UIView *coverView; // 蒙板
    UIView *showView;// 要展示的View
    
    UIView *topView; // 顶部View
//    UIImageView *shopImageView;
//    UILabel *priceLabel;
//    UILabel *countlabel;
//    UILabel *sizeLabel;
    UIView *colorView; // 颜色View
    UIView *sizeView; // 尺寸View
    UIView *buyCountView; // 尺寸View

}

/** 商品的数量 */
@property (nonatomic,strong)UITextField *numberTextFied;

/** 选择的颜色按钮 */
@property (nonatomic,weak) UIButton *selectColorBtn;
/** 选择的c\尺寸按钮 */
@property (nonatomic,weak) UIButton *selectSizeBtn;
@end

@implementation StandardsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.buyTotalCount = 0;
        
        self.backgroundColor = [UIColor clearColor];
//        tempImgViewtag = 0;
        [self setUpMainViews];
    }
    return self;
}


- (void)tap{
    [self dismiss];
}
-(void)setUpMainViews{
#pragma mark - ###############   蒙板的View  ###############
    coverView =  [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    coverView.backgroundColor = [UIColor grayColor];
    coverView.alpha = 0.2;
    coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:coverView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [coverView addGestureRecognizer:tap];
    
    // 要展示的View
    showView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height*0.3, self.width, self.height - self.height*0.3)];
    showView.layer.masksToBounds = YES;
    showView.layer.cornerRadius = 5;
    showView.backgroundColor = [UIColor whiteColor];
    [self addSubview:showView];
    
    
#pragma mark - ###############   顶部的View   ###############
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 100)];
    topView.backgroundColor = [UIColor whiteColor];
    [showView addSubview:topView];

    
    // 要展示的商品imageView
    self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KShopToLeft,0,100, 100)];
    self.shopImageView.layer.cornerRadius = 5;
    self.shopImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.shopImageView.layer.borderWidth = 3;
    self.shopImageView.image = [UIImage imageNamed:@"12.png"];
    [topView addSubview:self.shopImageView];
    
    for (int i = 0; i < 3; i++) {
        CGFloat lbHeight = 25;
        UILabel *lb = [[UILabel alloc] init];
        lb.textColor = [UIColor blackColor];
        lb.frame = CGRectMake(CGRectGetMaxX(self.shopImageView.frame),MGSmallMargin + i*(MGMargin + lbHeight), self.width - self.shopImageView.width - MGMargin, lbHeight);
        lb.tag = i + 8888;
        [topView addSubview:lb];
    }
    
    self.priceLabel = (UILabel *)[topView viewWithTag:8888];
    self.countlabel = (UILabel *)[topView viewWithTag:8889];
    self.sizeLabel = (UILabel *)[topView viewWithTag:8890];
    self.priceLabel.text = @"$400元";
    self.priceLabel.textColor = [UIColor redColor];
    self.countlabel.text = @"库存 20 件";
    self.sizeLabel.text = @"请选择规格";
    
    [self buildLineView:CGRectMake(0,CGRectGetMaxY(topView.frame)-1, MGSCREEN_width, 1) addLineToView:showView];
    
    
#pragma mark - ###############   颜色的View  ###############
    colorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), self.width, 80)];
    colorView.backgroundColor = MGRGBColor(250, 250, 250);
    [showView addSubview:colorView];

    
    UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(KShopToLeft, MGMargin, 50, 25)];
    colorLabel.text = @"颜色";
    [colorView addSubview:colorLabel];
    
    NSArray *colorArrText = @[@"红色",@"蓝色"];
    for (int i = 0; i < 2; i++) {
        CGFloat btnWidth = 45;
        UIButton *btn = [[UIButton alloc] init];
        btn.layer.shadowRadius = 5.0;
        btn.layer.cornerRadius = MGSmallMargin;
        [btn setTitle:colorArrText[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setTitleShadowColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(KShopToLeft + i*(MGMargin + btnWidth) ,CGRectGetMaxY(colorLabel.frame) + MGMargin , btnWidth, 23);
        btn.tag = i +7777;
        [btn addTarget:self action:@selector(colorSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        [colorView addSubview:btn];
    }
    [self buildLineView:CGRectMake(0,CGRectGetMaxY(colorView.frame)-1, MGSCREEN_width, 1) addLineToView:showView];
    
    
#pragma mark - ###############   尺寸的View  ###############
    sizeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(colorView.frame), self.width, 80)];
    sizeView.backgroundColor = MGRGBColor(250, 250, 250);
    [showView addSubview:sizeView];
    
    UILabel *selectSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KShopToLeft, MGMargin, 50, 25)];
    selectSizeLabel.text = @"尺寸";
    [sizeView addSubview:selectSizeLabel];
    
    NSArray *sizeArrText = @[@"X",@"XL",@"XXL"];
    for (int i = 0; i < 3; i++) {
        CGFloat btnWidth = 45;
        UIButton *btn = [[UIButton alloc] init];
        btn.layer.shadowRadius = 5.0;
        btn.layer.cornerRadius = MGSmallMargin;
        [btn setTitle:sizeArrText[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setTitleShadowColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(KShopToLeft + i*(MGMargin + btnWidth) ,CGRectGetMaxY(selectSizeLabel.frame) + MGMargin , btnWidth, 23);
        btn.tag = i + 6666;
        [btn addTarget:self action:@selector(sizeSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        [sizeView addSubview:btn];
    }
    [self buildLineView:CGRectMake(0,CGRectGetMaxY(sizeView.frame)-1, MGSCREEN_width, 1) addLineToView:showView];

    
#pragma mark - ###############   买的的View  ###############
    buyCountView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sizeView.frame), self.width, 60)];
    buyCountView.backgroundColor = MGRGBColor(250, 250, 250);
    [showView addSubview:buyCountView];
    
    UILabel *buyCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(MGMargin, 1.5*MGMargin, 90, 30)];
    buyCountLabel.text = @"购买数量";
    [buyCountView addSubview:buyCountLabel];
    
    CGFloat btnWidth = 30;
    UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(MGSCREEN_width - MGMargin - btnWidth, 0, btnWidth, 30)];
    plusBtn.centerY = buyCountView.height/2;
    [plusBtn addTarget:self action:@selector(buyNumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    plusBtn.tag = 50;
    [plusBtn setImage:[UIImage imageNamed:@"StandarsAdd"] forState:UIControlStateNormal];
    [buyCountView addSubview:plusBtn];
    
    self.numberTextFied = [[UITextField alloc] init];
    self.numberTextFied.enabled = NO;
    self.numberTextFied.text = @"0";
    self.numberTextFied.frame = CGRectMake(plusBtn.orgin.x - 40, plusBtn.center.y-MGMargin, 40, 20);
    self.numberTextFied.textAlignment = NSTextAlignmentCenter;
    self.numberTextFied.backgroundColor = [UIColor grayColor];
    [buyCountView addSubview:self.numberTextFied];
    
    UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.numberTextFied.frame.origin.x - btnWidth,plusBtn.center.y - plusBtn.frame.size.height/2 , plusBtn.frame.size.width, plusBtn.frame.size.height)];
    [reduceBtn addTarget:self action:@selector(buyNumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [reduceBtn setImage:[UIImage imageNamed:@"StandarsDel"] forState:UIControlStateNormal];
    reduceBtn.tag = 51;
    [buyCountView addSubview:reduceBtn];
    [self buildLineView:CGRectMake(0,CGRectGetMaxY(buyCountView.frame)-1, MGSCREEN_width, 1) addLineToView:showView];
   
    
#pragma mark - ###############   // 底部确定按钮  ###############
    // 底部确定按钮
    UIButton *conformBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    conformBtn.frame = CGRectMake(0, showView.height- 50, MGSCREEN_width, 50);
    conformBtn.backgroundColor = MGNavBarTiniColor;
    [conformBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [conformBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    conformBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [conformBtn addTarget:self action:@selector(confirmProduct:) forControlEvents:(UIControlEventTouchUpInside)];
    [showView addSubview:conformBtn];
}

#pragma mark - action
// ➕➖按钮点击的监听
-(void)buyNumBtnClick:(UIButton *)sender
{
    if (sender.tag == 50) {
        self.buyTotalCount ++;
        self.numberTextFied.text = [NSString stringWithFormat:@"%d",self.buyTotalCount];
        return;
    }
    
    // ➖
    if(self.buyTotalCount <= 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"客官，你还买不买啊，都减没了！" delegate:self cancelButtonTitle:@"我看看再说～" otherButtonTitles: nil];
        [alertView show];
    }
    if (self.buyTotalCount == 0)
        return ;
    self.buyTotalCount --;
    self.numberTextFied.text = [NSString stringWithFormat:@"%d",self.buyTotalCount];
}

/// 选择颜色
- (void)colorSelectClick:(UIButton *)sender{
    // 1.让当前选中的按钮取消选中
    self.selectColorBtn.selected = NO;
    
    // 2.让新点击的按钮选中
    sender.selected = YES;
    
    // 3.新点击的按钮就成为了"当前选中的按钮"
    self.selectColorBtn = sender;
}

/// 选择尺寸
- (void)sizeSelectClick:(UIButton *)sender{
    // 1.让当前选中的按钮取消选中
    self.selectSizeBtn.selected = NO;

    // 2.让新点击的按钮选中
    sender.selected = YES;
    
    // 3.新点击的按钮就成为了"当前选中的按钮"
    self.selectSizeBtn = sender;
}

/// 确定提交商品
- (void)confirmProduct:(UIButton *)sender{
    if (self.buyTotalCount > 0) {
        if([self.delegate respondsToSelector:@selector(Standards:SelectBtnClick:)])
        {
            [self.delegate Standards:self SelectBtnClick:sender];
        }
    }else{
        MGPE(@"请购买商品");
    }
}


#pragma mark - 快速创建分割线
- (void)buildLineView:(CGRect)frame addLineToView:(UIView *)view{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [view addSubview:lineView];
}



#pragma mark -
- (void)show {
    [UIView animateWithDuration:0.5 animations:^{
        coverView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self showAnimation];
}

- (void)dismiss {
    //清除抛物创建的views
    [self hideAnimation];
    [self endEditing:YES];
}

#pragma mark - Animations

-(void)showAnimationFromLeft:(UIView *)view
{
    CGRect tempRect = view.frame;
    view.layer.anchorPoint = CGPointMake(0.5, 2.0);
    view.frame = tempRect;//重设frame，重新计算center  因为anchorpoint的设置会导致center的改变
    
    
    view.transform = CGAffineTransformMakeRotation(-M_PI_4);
    [UIView animateWithDuration:1.0 animations:^{
        view.transform = CGAffineTransformIdentity;
    }];
    
}

-(void)selfDismissAnimationToRight
{
    CGRect tempRect = showView.frame;
    showView.layer.anchorPoint = CGPointMake(0.5, 2.0);
    showView.frame = tempRect;//重设frame，重新计算center  因为anchorpoint的设置会导致center的改变
    
    CGPoint tempPoint = self.shopImageView.center;
    [UIView animateWithDuration:0.5 animations:^{
        self.shopImageView.center = CGPointMake(tempPoint.x, MGSCREEN_height);
        showView.transform = CGAffineTransformMakeRotation(M_PI_4);
        coverView.alpha = 0.0;
        
        CGAffineTransform t ;
        if (self.GoodDetailView != nil) {
            t = self.GoodDetailView.transform;
        }
        if (self.GoodDetailView != nil) {
            CGAffineTransform tempTransform = CGAffineTransformScale(t, 1/GoodDetailScaleValue, 1/GoodDetailScaleValue);
            self.GoodDetailView.transform = tempTransform;
        }
        
    } completion:^(BOOL finished) {
        showView.alpha = 0.0;
        [self removeFromSuperview];
    }];
}

-(void)selfShowAnimationFromLeft
{
    
    CGRect tempRect = showView.frame;
    showView.layer.anchorPoint = CGPointMake(0.5, 2.0);
    showView.frame = tempRect;//重设frame，重新计算center  因为anchorpoint的设置会导致center的改变
    showView.transform = CGAffineTransformMakeRotation(-M_PI_4);
    
    CGPoint tempPoint = self.shopImageView.center;
    self.shopImageView.center =CGPointMake(tempPoint.x, 0);
    CGAffineTransform t;
    if (self.GoodDetailView !=nil) {
        t = self.GoodDetailView.transform;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.shopImageView.center = tempPoint;
        showView.transform = CGAffineTransformIdentity;//回到原始位置
        
        if (self.GoodDetailView !=nil) {
            CGAffineTransform tempTransform = CGAffineTransformScale(t, GoodDetailScaleValue, GoodDetailScaleValue);
            self.GoodDetailView.transform = tempTransform;
        }
        
    }];
    
    
    
    
}


//设置指定view大小
-(void)setBackViewAnimationScale:(UIView *)backView andDuration:(NSTimeInterval)duration toValueX:(CGFloat)valueX andValueY:(CGFloat)valueY
{
    CGAffineTransform t = backView.transform;
    
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform tempTrans = CGAffineTransformScale(t, valueX, valueY);
        backView.transform = tempTrans;
    }];
    
}

//将某个view抛到某个地点
-(void)ThrowGoodTo:(CGPoint)destPoint andDuration:(NSTimeInterval)duration andHeight:(CGFloat)height andScale:(CGFloat)Scale
{
    
    //    if (height == 0) {
    //        height = 100;
    //    }
    
    if(duration == 0)
    {
        duration = 1.6;
    }
    
    if(Scale == 0)
    {
        Scale = 20.0;
    }
}


////抛物线结束
- (void)animationDidFinish:(UIView *)view
{
    //    [self.tempImgViewArr removeObject:view];
}


//显示view
- (void)showAnimation {
    
    switch (self.showAnimationType) {
        case StandsViewShowAnimationFlash:
        {
            CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            popAnimation.duration = 0.4;
            popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
            popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [showView.layer addAnimation:popAnimation forKey:nil];
            [self.shopImageView.layer addAnimation:popAnimation forKey:nil];
            
            
            if (self.GoodDetailView !=nil) {
                CGAffineTransform t = self.GoodDetailView.transform;
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    CGAffineTransform tempTransform = CGAffineTransformScale(t, GoodDetailScaleValue, GoodDetailScaleValue);
                    self.GoodDetailView.transform = tempTransform;
                }];
            }
        }
            break;
        case StandsViewShowAnimationShowFrombelow:
        {
            CGAffineTransform t;
            if (self.GoodDetailView !=nil) {
                t = self.GoodDetailView.transform;
            }
            CGPoint mainImgCenter = self.shopImageView.center;
            self.shopImageView.center  = CGPointMake(mainImgCenter.x, mainImgCenter.y+MGSCREEN_height);
            
            
            CGPoint tempPoint = showView.center;
            showView.center = CGPointMake(MGSCREEN_height/2, tempPoint.y+MGSCREEN_height);
            [UIView animateWithDuration:0.5 animations:^{
                showView.center = tempPoint;
                self.shopImageView.center = mainImgCenter;
                if (self.GoodDetailView !=nil) {
                    
                    CGAffineTransform tempTransform = CGAffineTransformScale(t, GoodDetailScaleValue, GoodDetailScaleValue);
                    self.GoodDetailView.transform = tempTransform;
                }
                
            }];
        }
            break;
        case StandsViewShowAnimationShowFromLeft:
        {
            [self selfShowAnimationFromLeft];
        }
            break;
        case StandsViewShowAnimationCustom:
        {
            if([self.delegate respondsToSelector:@selector(CustomShowAnimation)])
            {
                [self.delegate CustomShowAnimation];
            }
        }
            break;
            
        default:
            break;
    }
    
}

//移除view

- (void)hideAnimation{
    switch (self.dismissAnimationType) {
        case StandsViewDismissAnimationFlash:
        {
            CGAffineTransform t ;
            if (self.GoodDetailView != nil) {
                t = self.GoodDetailView.transform;
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                coverView.alpha = 0.0;
                showView.alpha = 0.0;
                self.shopImageView.alpha = 0.0;
                
                
                if (self.GoodDetailView != nil) {
                    CGAffineTransform tempTransform = CGAffineTransformScale(t, 1/GoodDetailScaleValue, 1/GoodDetailScaleValue);
                    self.GoodDetailView.transform = tempTransform;
                }
                
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
            
        }
            break;
        case StandsViewDismissAnimationDisFrombelow:
        {
            CGAffineTransform t ;
            if (self.GoodDetailView != nil) {
                t = self.GoodDetailView.transform;
            }
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                
                CGPoint mainImgCenter = self.shopImageView.center;
                self.shopImageView.center  = CGPointMake(mainImgCenter.x, mainImgCenter.y+MGSCREEN_height);
                
                CGPoint tempPoint = showView.center;
                showView.center = CGPointMake(MGSCREEN_width/2, tempPoint.y+MGSCREEN_height);
                
                if (self.GoodDetailView != nil) {
                    CGAffineTransform tempTransform = CGAffineTransformScale(t, 1/GoodDetailScaleValue, 1/GoodDetailScaleValue);
                    self.GoodDetailView.transform = tempTransform;
                }
                
                coverView.alpha = 0.0;
                showView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
            }];
            
        }
            break;
        case StandsViewDismissAnimationDisToRight:
        {
            [self selfDismissAnimationToRight];
        }
            break;
        case StandsViewDismissAnimationCustom:
        {
            if([self.delegate respondsToSelector:@selector(CustomDismissAnimation)])
            {
                [self.delegate CustomDismissAnimation];
            }
        }
        default:
            break;
    }
}

@end
