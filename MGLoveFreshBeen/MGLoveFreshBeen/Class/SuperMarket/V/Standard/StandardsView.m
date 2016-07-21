//
//  StandardsView.m
//  LanDouS
//
//  Created by Wangjc on 16/2/23.
//  Copyright © 2016年 Mao-MacPro. All rights reserved.
//

#import "StandardsView.h"
#import "ThrowLineTool.h"

#define GapToLeft   20
#define GoodDetailScaleValue    0.9
#define ItemsBaseColor  [UIColor whiteColor]

@interface StandardsView ()<ThrowLineToolDelegate>
{
//    UILabel *tipLab;
//    UILabel *titleLab;
//    UILabel *contentLab;
    
    CGFloat _cellHeight;
    NSInteger _cellNum;
    
    UIButton *cancelBtn;
    UIButton *sureBtn;
    UIView *lineView;
    
    UIView *coverView;
    UIView *showView;
    
//    UIImageView *tempImgView;
    UIView *buyNumBackView;
    
    NSInteger tempImgViewtag;
    
}
@property (nonatomic) NSMutableArray *tempImgViewArr;
@property (nonatomic) NSMutableDictionary *standardBtnClickDict;//记录被按下的btn
@property (nonatomic) UITableView *mainTableView;
@property (nonatomic) NSMutableArray *standardBtnArr;
@property (nonatomic) UITextField *numberTextFied;
//@property(nonatomic)UITextView *contentTextView;
//@property(nonatomic)UILabel *holderLab;

@end


@implementation StandardsView


@synthesize buyNum = _buyNum;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init{
    self = [super init];
    if (self) {
        tempImgViewtag = 0;
        [self buildViews];
        
    }
    return self;
}


-(void)buildViews
{

    self.frame = [self screenBounds];
    coverView =  [[UIView alloc]initWithFrame:[self topView].bounds];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0;
    coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [[self topView] addSubview:coverView];
    
    showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, StandardViewWidth, StandardViewHeight)];
    showView.center = CGPointMake(self.frame.size.width/2, (SCREEN_HEIGHT - StandardViewHeight)+StandardViewHeight/2);
    showView.layer.masksToBounds = YES;
    showView.layer.cornerRadius = 5;
    showView.backgroundColor = [UIColor whiteColor];
    [self addSubview:showView];
    
    
    self.mainImgView = [[UIImageView alloc] initWithFrame:CGRectMake(GapToLeft,
                                                                     0,
                                                                     100, 100)];
    self.mainImgView.layer.cornerRadius = 5;
    self.mainImgView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.mainImgView.layer.borderWidth = 3;
    
//    self.mainImgView.image = self.mainImg;
    self.mainImgView.center = CGPointMake(80, showView.frame.origin.y+self.mainImgView.frame.size.height/3);
    self.mainImgView.image = [UIImage imageNamed:@"landou_square_default.png"];
    
    self.mainImgView.contentMode = UIViewContentModeScaleAspectFit;
//    self.mainImgView.alpha = 0;
    [self addSubview:self.mainImgView];
        /*默认按键*/
    cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, StandardViewHeight-44, StandardViewWidth/2, 44)];
    cancelBtn.tag = 1000 + 1;
    cancelBtn.backgroundColor = ItemsBaseColor;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:cancelBtn];
    
//
    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(StandardViewWidth/2, StandardViewHeight-44, StandardViewWidth/2, 44)];
    sureBtn.tag = 1000 + 2;
    sureBtn.backgroundColor = ItemsBaseColor;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:sureBtn];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(cancelBtn.frame.size.width, cancelBtn.frame.origin.y, 1, cancelBtn.frame.size.height)];
    lineView.backgroundColor = [UIColor whiteColor];
    [showView addSubview:lineView];
    
    /*键盘退出手势*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShowViewAction:) ];
    [showView addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelfViewAction:) ];
    [self addGestureRecognizer:tapGesture2];
    
    self.goodNum = [[UILabel alloc] init];
    self.priceLab = [[UILabel alloc] init];
    self.tipLab = [[UILabel alloc] init];
    
    /*购买或加入购物车数量*/
    self.numberTextFied = [[UITextField alloc] init];
    self.numberTextFied.text = [NSString stringWithFormat:@"%ld",self.buyNum];
    self.numberTextFied.font = [UIFont systemFontOfSize:14];
    self.numberTextFied.textColor = [UIColor blackColor];
    self.numberTextFied.textAlignment = NSTextAlignmentCenter;
    self.numberTextFied.keyboardType = UIKeyboardTypeNumberPad;
    
    if(self.buyNum == 0)
    {
        self.buyNum = 1;
    }

    [self initTableView];
    
}


-(void) initTableView
{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    //最上面显示的信息 数据
    self.priceLab.frame = CGRectMake(self.mainImgView.frame.size.width+self.mainImgView.frame.origin.x+10,
                                     0,
                                     (SCREEN_WIDTH - (self.mainImgView.frame.size.width+self.mainImgView.frame.origin.x) - 10),
                                     30);
    
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.font = [UIFont systemFontOfSize:14];
    self.priceLab.text =@"价格";// [NSString stringWithFormat:@"¥%@-%@",dicGoodsDetail[@"goods_price"],self.dictStandard[@"goods_marketprice"]];
    
    [tempView addSubview:self.priceLab];
    
    
    self.goodNum.frame =CGRectMake(self.priceLab.frame.origin.x,
                                   self.priceLab.frame.origin.y+self.priceLab.frame.size.height,
                                   self.priceLab.frame.size.width, 30);
    self.goodNum.textColor = [UIColor blackColor];
    self.goodNum.font = [UIFont systemFontOfSize:14];
    self.goodNum.text =@"库存";// [NSString stringWithFormat:@"库存%@件",dicGoodsDetail[@"goods_storage"]];
    [tempView addSubview:self.goodNum];
    
    
    self.tipLab.frame = CGRectMake(self.goodNum.frame.origin.x,
                                   self.goodNum.frame.origin.y+self.goodNum.frame.size.height,
                                   self.goodNum.frame.size.width, 30);
    self.tipLab.textColor = [UIColor blackColor];
    self.tipLab.font = [UIFont systemFontOfSize:14];
    
    NSString *str = @"请选择 ";

    
    self.tipLab.text = str;
    [tempView addSubview:self.tipLab];
    
    UIView *HlineView = [[UIView alloc] initWithFrame:CGRectMake(10, tempView.frame.size.height-1, SCREEN_WIDTH - 20, 0.5)];
    HlineView.backgroundColor = [UIColor grayColor];
    [tempView addSubview:HlineView];
    
    [showView addSubview:tempView];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tempView.frame.size.height, StandardViewWidth,StandardViewHeight - sureBtn.frame.size.height - tempView.frame.size.height )];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorColor =  [UIColor grayColor];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _mainTableView.tableFooterView = [[UIView alloc] init];
    
    _cellHeight = 100;
    [showView addSubview:_mainTableView];
}

#pragma mark - self property

-(void)setBuyNum:(NSInteger)buyNum
{
    _buyNum = buyNum;
    self.numberTextFied.text = [NSString stringWithFormat:@"%ld",buyNum];
}

-(NSInteger)buyNum
{
    _buyNum = [self.numberTextFied.text integerValue];
    return _buyNum;
}


/*设置自定义的button  原始btn功能有限建议自定义 或者说必需自定*/
-(void)setCustomBtns:(NSArray *)customBtns
{
    _customBtns = customBtns;
    
    [cancelBtn removeFromSuperview];
    [sureBtn removeFromSuperview];
    [lineView removeFromSuperview];
    
    CGFloat btnHeight = cancelBtn.frame.size.height;
    CGFloat btnWidth = SCREEN_WIDTH/_customBtns.count;
    
   
    for (int i = 0; i < _customBtns.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth*i, StandardViewHeight-44, btnWidth, btnHeight)];
        [btn setTitle:_customBtns[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(customBtnsClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        if(i != _customBtns.count - 1)
        {
            UIView *tempLineView = [[UIView alloc] initWithFrame:CGRectMake(btnWidth - 1, 0 , 1, btn.frame.size.height)];
            tempLineView.backgroundColor = [UIColor whiteColor];
            [btn addSubview:tempLineView];
            
        }
        if([self.delegate respondsToSelector:@selector(StandardsView:SetBtn:)])
        {
            [self.delegate StandardsView:self SetBtn:btn];
        }
        
        [showView addSubview:btn];
    }
}

-(void)setStandardArr:(NSArray<StandardModel *> *)standardArr
{
    _standardArr = standardArr;
    
    [_mainTableView reloadData];
}


-(NSMutableDictionary *)standardBtnClickDict
{
    if (_standardBtnClickDict == nil) {
        _standardBtnClickDict = [NSMutableDictionary dictionary];
    }
    
    return _standardBtnClickDict;
}
-(NSMutableArray *)tempImgViewArr
{
    if(_tempImgViewArr == nil)
    {
        _tempImgViewArr = [NSMutableArray array];
    }
    
    return _tempImgViewArr;
}

-(NSMutableArray *)standardBtnArr
{
    if(_standardBtnArr == nil)
    {
        _standardBtnArr = [NSMutableArray array];
    }
    
    return _standardBtnArr;
}



- (CGRect)screenBounds
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // On iOS7, screen width and height doesn't automatically follow orientation
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    
    return CGRectMake(0, 0, screenWidth, screenHeight);
}

#pragma mark - clicks


-(void)tapSelfViewAction:(id)sender
{
    [self dismiss];
}

-(void)tapShowViewAction:(id)sender
{
    [self endEditing:YES];
}

-(void)buyNumBtnClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        self.buyNum = self.buyNum+1;
    }
    if (sender.tag == 1) {
        
        if(self.buyNum <= 1)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"客官，你还买不买啊，都减没了！" delegate:self cancelButtonTitle:@"我看看再说～" otherButtonTitles: nil];
            
            [alertView show];
            return;
        }
        
        self.buyNum = self.buyNum -1 ;
    }
    
}
//自定义按键点击
-(void)customBtnsClickAction:(UIButton *)sender
{
    if([self.delegate respondsToSelector:@selector(StandardsView:CustomBtnClickAction:)])
    {
        [self.delegate StandardsView:self CustomBtnClickAction:sender];
    }
}
//规格键点击
-(void)standardBtnClick:(UIButton *)sender
{
    sender.backgroundColor = [UIColor orangeColor];
    sender.selected = YES;
    
    NSArray *tempArr = self.standardBtnArr[(sender.tag & 0x0000ffff)/100 ];
    
    for (UIButton *tempBtn in tempArr) {
        if(tempBtn.tag == sender.tag)
        {
            continue;
        }
        
        tempBtn.backgroundColor = [UIColor whiteColor];
        tempBtn.selected = NO;
    }
    NSString *tagStr = [NSString stringWithFormat:@"%ld",(unsigned long)(sender.tag & 0xffff0000)>>16];
    
    [self.standardBtnClickDict setObject:tagStr forKey:[NSString stringWithFormat:@"%ld",(sender.tag & 0x0000ffff)/100]];
    
    if([self.delegate respondsToSelector:@selector(Standards:SelectBtnClick:andSelectID:andStandName:andIndex:)])
    {
        [self.delegate Standards:self SelectBtnClick:sender andSelectID:tagStr andStandName:self.standardArr[(sender.tag & 0x0000ffff)/100].standardName andIndex:(sender.tag & 0x0000ffff)/100];
    }

}


-(void)clickAction:(UIButton *)sender
{
    if(sender == sureBtn)
    {
        sureBtn.backgroundColor = [UIColor yellowColor];
        cancelBtn.backgroundColor = ItemsBaseColor;
        
        if([self.delegate respondsToSelector:@selector(Standards:SureBtnClick:)])
        {
            [self.delegate Standards:self SureBtnClick:@""];
        }
        
    }
    else if(sender == cancelBtn)
    {
        cancelBtn.backgroundColor = [UIColor yellowColor];
        sureBtn.backgroundColor = ItemsBaseColor;
    }
    
    [self dismiss];
}

-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    NSLog(@"window.subviews = %d",window.subviews.count);
    return  window.subviews[0];
}

- (void)show {
    [UIView animateWithDuration:0.5 animations:^{
        coverView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [[self topView] addSubview:self];
    [self showAnimation];
//    self.mainImgView.alpha = 1.0;
}

- (void)dismiss {
    //清除抛物创建的views
    if (self.tempImgViewArr.count>0) {
        for (UIImageView *tempView  in self.tempImgViewArr) {
            if (tempView!=nil&&tempView.superview!=nil) {
                tempView.alpha = 0;
                [tempView removeFromSuperview];
            }
        }
        
        
        [self.tempImgViewArr removeAllObjects];
    }
    
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

//    tempRect = self.mainImgView.frame;
//    self.mainImgView.layer.anchorPoint = CGPointMake(0.5, 2.0*(StandardViewHeight/100));
//    self.mainImgView.frame = tempRect;//跟随mainimgview旋转
    CGPoint tempPoint = self.mainImgView.center;
    [UIView animateWithDuration:0.5 animations:^{
        self.mainImgView.center = CGPointMake(tempPoint.x, SCREEN_HEIGHT);
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
    
    CGPoint tempPoint = self.mainImgView.center;
    self.mainImgView.center =CGPointMake(tempPoint.x, 0);
    CGAffineTransform t;
    if (self.GoodDetailView !=nil) {
        t = self.GoodDetailView.transform;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.mainImgView.center = tempPoint;
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
    
    
    ThrowLineTool *tool = [ThrowLineTool sharedTool];
    tool.delegate = self;
    
    UIImageView *tempImgView = [[UIImageView alloc] init];
    tempImgView.frame = self.mainImgView.frame;
    tempImgView.image = self.mainImgView.image;
    tempImgView.tag = tempImgViewtag;

    tempImgView.layer.cornerRadius = 5;
    tempImgView.layer.borderColor = [[UIColor whiteColor] CGColor];
    tempImgView.layer.borderWidth = 3;
    [self addSubview:tempImgView];
    
    [self.tempImgViewArr addObject:tempImgView];
    tempImgViewtag ++;
    [tool throwObject:tempImgView
                 from:tempImgView.center // tempImgView.center
                   to:destPoint
               height:height
   andViewBoundsScale:Scale
             duration:duration];
    

    [self performSelector:@selector(viewSetHidden:) withObject:[NSString stringWithFormat:@"%ld",tempImgView.tag] afterDelay:duration - 0.11111];

}

-(void)viewSetHidden:(NSString *)tag
{
//    tempImgView.hidden = YES;

    NSLog(@"tag = %@",tag);
    
//    tempImgView = self.tempImgViewArr[[tag intValue]];
    
    for (UIImageView *tempImgView in self.tempImgViewArr) {
//        UIImageView *tempImgView = self.tempImgViewArr[i];
        
        if (tempImgView.tag == [tag intValue]) {
            tempImgView.hidden = YES;
            [tempImgView removeFromSuperview];
            break;
        }
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
            [self.mainImgView.layer addAnimation:popAnimation forKey:nil];
            
            
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
            CGPoint mainImgCenter = self.mainImgView.center;
            self.mainImgView.center  = CGPointMake(mainImgCenter.x, mainImgCenter.y+SCREEN_HEIGHT);
            
            
            CGPoint tempPoint = showView.center;
            showView.center = CGPointMake(SCREEN_WIDTH/2, tempPoint.y+SCREEN_HEIGHT);
           [UIView animateWithDuration:0.5 animations:^{
               showView.center = tempPoint;
               self.mainImgView.center = mainImgCenter;
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
                self.mainImgView.alpha = 0.0;
                
                
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

                
                CGPoint mainImgCenter = self.mainImgView.center;
                self.mainImgView.center  = CGPointMake(mainImgCenter.x, mainImgCenter.y+SCREEN_HEIGHT);
                
                CGPoint tempPoint = showView.center;
                showView.center = CGPointMake(SCREEN_WIDTH/2, tempPoint.y+SCREEN_HEIGHT);
                
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



#pragma mark - self tools
//根据字符串计算宽度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}

#pragma mark - api for custom
-(void)standardsViewReload
{
    if(_mainTableView!=nil)
    {
        [_mainTableView reloadData];
    }
}


#pragma mark -  tableview  Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.standardArr.count + 1;
    
}

#pragma mark - setting for cell

#define ViewsGaptoLine 20
//设置每行调用的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _cellHeight)];
    
    if(self.standardArr == nil || self.standardArr.count == 0 )
        return cell;
    
    @try {
        
        if(indexPath.row < self.standardArr.count)
        {
            StandardModel *standardModel = self.standardArr[indexPath.row];
            
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 30)];
            titleLab.text = standardModel.standardName;//  dicGoodsDetail[@"spec_name"][indexPath.row ][@"name"];
            titleLab.textColor = [UIColor blackColor];
            titleLab.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:titleLab];
            
            CGFloat oneLineBtnWidtnLimit = 300;//每行btn占的最长长度，超出则换行
            CGFloat btnGap = 10;//btn的x间距
            CGFloat btnGapY = 10;
            NSInteger BtnlineNum = 0;
            CGFloat BtnHeight = 30;
            CGFloat minBtnLength =  50;//每个btn的最小长度
            CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
            CGFloat Btnx = 0;//每个btn的起始位置
            Btnx += btnGap;
            
    //        NSString *strID = [NSString stringWithFormat:@"%@",dicGoodsDetail[@"spec_name"][indexPath.row][@"id"]];
            NSArray<standardClassInfo *> *specArr = standardModel.standardClassInfo;
            
            NSMutableArray *tempArr = [NSMutableArray array];
            
            for (int i = 0; i < specArr.count; i++) {
                NSString *str = specArr[i].standardClassName ;
                CGFloat btnWidth = [self WidthWithString:str fontSize:14 height:BtnHeight];
                btnWidth += 20;//让文字两端留出间距
                
                if(btnWidth<minBtnLength)
                    btnWidth = minBtnLength;
                
                if(btnWidth>maxBtnLength)
                    btnWidth = maxBtnLength;
                
                
                if(Btnx + btnWidth > oneLineBtnWidtnLimit)
                {
                    BtnlineNum ++;//长度超出换到下一行
                    Btnx = btnGap;
                }
                
                
                UIButton *btn = [[UIButton alloc] init];
                
                CGFloat height = titleLab.frame.size.height+titleLab.frame.origin.x + (BtnlineNum*(BtnHeight+btnGapY));
                btn.frame = CGRectMake(Btnx, height,
                                       btnWidth,BtnHeight );
                [btn setTitle:str forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 5;
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = [[UIColor grayColor] CGColor];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                btn.tag = indexPath.row*100 + i/*低16位 cell行数*/ | ([specArr[i].standardClassId intValue] << 16) /*高16位  分类id*/;
                
                NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
                
                if ([specArr[i].standardClassId intValue] == [self.standardBtnClickDict[key] intValue]) {
                    btn.backgroundColor = [UIColor orangeColor];
                }
                
                
                
                [tempArr addObject:btn];
                
                Btnx = btn.frame.origin.x + btn.frame.size.width + btnGap;
                [cell.contentView addSubview:btn];
                
                
            }
            
            [self.standardBtnArr addObject:tempArr];
        }
        else
        {

            cell.textLabel.text = @"购买数量";
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            CGFloat btnWidth = 30;
            
            UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 -btnWidth, 0, btnWidth, 30)];
            CGPoint tempPoint = plusBtn.center;
            [plusBtn addTarget:self action:@selector(buyNumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            tempPoint.y = _cellHeight/2/2;
            plusBtn.center = tempPoint;
            plusBtn.tag = 0;
            [plusBtn setImage:[UIImage imageNamed:@"StandarsAdd"] forState:UIControlStateNormal];
            [cell addSubview:plusBtn];
            
            self.numberTextFied.frame = CGRectMake(plusBtn.frame.origin.x - 40, plusBtn.center.y -10, 40, 20);
            self.numberTextFied.textAlignment = NSTextAlignmentCenter;
            self.numberTextFied.backgroundColor = [UIColor grayColor];
            [cell addSubview:self.numberTextFied];
            
            UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.numberTextFied.frame.origin.x - btnWidth,plusBtn.center.y - plusBtn.frame.size.height/2 , plusBtn.frame.size.width, plusBtn.frame.size.height)];
            [reduceBtn addTarget:self action:@selector(buyNumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [reduceBtn setImage:[UIImage imageNamed:@"StandarsDel"] forState:UIControlStateNormal];
            reduceBtn.tag = 1;
            [cell addSubview:reduceBtn];
            
//            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
         return cell;
    }
    
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.standardArr.count)
        return _cellHeight/2/*购买数量*/;
    
    @try {
        CGFloat totalHeight = 0;
        
        CGFloat oneLineBtnWidtnLimit = 300;//每行btn占的最长长度，超出则换行
        CGFloat btnGap = 10;//btn的x间距
        CGFloat btnGapY = 10;
        NSInteger BtnlineNum = 0;
        CGFloat BtnHeight = 30;
        CGFloat minBtnLength =  50;//每个btn的最小长度
        CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
        CGFloat Btnx ;//每个btn的起始位置
        Btnx += btnGap;
        
//        NSString *strID = [NSString stringWithFormat:@"%@",dicGoodsDetail[@"spec_name"][indexPath.row][@"id"]];
//        NSArray *specArr = [dicGoodsDetail[@"spec_value"] objectForKey:strID];
        
        for (int i = 0; i < self.standardArr[indexPath.row].standardClassInfo.count; i++) {
            NSString *str = self.standardArr[indexPath.row].standardClassInfo[i].standardClassName;
            CGFloat btnWidth = [self WidthWithString:str fontSize:14 height:BtnHeight];
            btnWidth += 20;//让文字两端留出间距
            
            if(btnWidth<minBtnLength)
                btnWidth = minBtnLength;
            
            if(btnWidth>maxBtnLength)
                btnWidth = maxBtnLength;
            
            
            if(Btnx + btnWidth > oneLineBtnWidtnLimit)
            {
                BtnlineNum ++;//长度超出换到下一行
                Btnx = btnGap;
            }
            
            
            
            Btnx =Btnx + btnWidth + btnGap;
            
        }
        totalHeight = 30 + (1+BtnlineNum)*(BtnHeight+btnGapY) + btnGapY;
        
        return totalHeight;
    }
    @catch (NSException *exception) {
        return _cellHeight;
    }
    @finally {
        
    }

    return _cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    NSLog(@"click cell section : %ld row : %ld",(long)indexPath.section,(long)indexPath.row);
    
    
}


//设置划动cell是否出现del按钮，可供删除数据里进行处理

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (UITableViewCellEditingStyle)tableView: (UITableView *)tableView editingStyleForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

//设置选中的行所执行的动作

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return indexPath;
    
}

#pragma mark - setting for section
//设置section的header view

#define SectionHeight  0

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView = [[UIView alloc] init];
    
   
    
    return tempView;
}

//设置section header 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

//设置section footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
    
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com