//
//  ProductDetailVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ProductDetailVC.h"
#import "SuperMarketModel.h"
#import "HotFreshModel.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"

#import "AppDelegate.h"

#import "StandardsView.h"

typedef  enum {
    ProductTypeAdd,
    ProductTypeBuy
}ProductType;


@interface ProductDetailVC ()<UMSocialUIDelegate,StandardsViewDelegate>
{
    UIScrollView *scrollView;
    UIImageView *productImageView;
    
    UIView *nameView;
    UILabel *titleNameLabel;
    
    UIView *presentView;
    UIButton *presentButton;
    UILabel *presentLabel;

    UIView *detailView;
    UIImageView *detailImageView;
    
    UILabel *brandLabel;
    UILabel *brandTitleLabel;
    UILabel *detailLabel;
    UILabel *detailTitleLabel;
    UILabel *textImageLabel;
    
    UIView *promptView;
    UILabel *promptLabel;
    UILabel *promptDetailLabel;
    
    UILabel *marketPriceLabel;
    UILabel *priceLabel;
    
    // 底部View
    UIView *bottomView;
    UIButton *addProductBtn;
    UIButton *buyProductBtn;
}
/** HotGoods */
@property (nonatomic,strong) HotGoods *goods;
/** shopCar */
@property (nonatomic,strong) UIButton *shopCar;
@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    // 添加子控件
//    [self setupMainView];
//    
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 遍历构造方法
- (instancetype)initWithGoods:(HotGoods *)goods{
    if (self = [super init]) {
        
        // 添加子控件
        [self setupMainView];
        
        self.goods = goods;
        [productImageView sd_setImageWithURL:[NSURL URLWithString:[goods valueForKeyPath:@"img"]] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
        titleNameLabel.text = [goods valueForKeyPath:@"name"];
        UIView *discountPriceView = [self discountPriceView];
        discountPriceView.frame = CGRectMake(15, 40, MGSCREEN_width * 0.6, 40);
        [nameView addSubview:discountPriceView];
        
        priceLabel.text = [goods valueForKeyPath:@"partner_price"];
        marketPriceLabel.text = [goods valueForKeyPath:@"market_price"];
        
        if ([[goods valueForKeyPath:@"pm_desc"] isEqualToString:@"买一赠一"]) {
            presentView.height = 50;
            presentView.hidden = NO;
        } else {
            presentView.height = 0;
            presentView.hidden = YES;
            detailView.y -= 50;
            promptView.y -= 50;
        }
        
        brandTitleLabel.text = [goods valueForKeyPath:@"brand_name"];
        detailTitleLabel.text = [goods valueForKeyPath:@"specifics"];
        
        // 图片 (很长的图片)
        detailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aaaa"]];
        CGFloat scale = 320.0 / MGSCREEN_width;
        detailImageView.frame = CGRectMake(0, CGRectGetMaxY(promptView.frame), MGSCREEN_width, detailImageView.height / scale);
        [scrollView addSubview:detailImageView];
        scrollView.contentSize = CGSizeMake(MGSCREEN_width, CGRectGetMaxY(detailImageView.frame) + 50 + MGNavHeight);
        
        [self setUpNavigationItem:[goods valueForKeyPath:@"name"]];
    }
    return self;
}


/// 打折的View
- (UIView *)discountPriceView{
    UIView *discountPriceView = [[UIView alloc] init];
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, priceLabel.width, discountPriceView.height)];
    priceLabel.font = MGFont(14);
    priceLabel.textColor = [UIColor redColor];
    [discountPriceView addSubview:priceLabel];
    
    marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame) + 5, 0, marketPriceLabel.width, discountPriceView.height)];
    marketPriceLabel.textColor = MGRGBColor(80, 80, 80);
    marketPriceLabel.font = MGFont(14);
    [discountPriceView addSubview:marketPriceLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, marketPriceLabel.height * 0.5 - 0.5, marketPriceLabel.width, 1)];
    lineView.backgroundColor = MGRGBColor(80, 80, 80);
    [marketPriceLabel addSubview:lineView];
    return discountPriceView;
}



#pragma mark - 私有方法
- (void)setupMainView {
    // 容器
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = false;
    [self.view addSubview:scrollView];
    
    // 商品图片
   productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, 300)];
    productImageView.contentMode = UIViewContentModeScaleAspectFill;
   [scrollView addSubview:productImageView];
    
    // 分割线
    [self buildLineView:CGRectMake(0, CGRectGetMaxY(productImageView.frame) - 1, MGSCREEN_width, 2) addLineToView:scrollView];
    
    
    // nameView
    nameView = [[UIView alloc] init];
    nameView.frame = CGRectMake(0, CGRectGetMaxY(productImageView.frame), MGSCREEN_width, 80);
    nameView.backgroundColor = MGProductBackGray;
    [scrollView addSubview:nameView];
    
    titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MGSmallMargin * 3, 0, MGSCREEN_width, 60)];
    titleNameLabel.textColor = [UIColor blackColor];
    titleNameLabel.font = MGFont(16);
    [nameView addSubview:titleNameLabel];
    
    [self buildLineView:CGRectMake(0, nameView.height - 1, MGSCREEN_width, 1) addLineToView:nameView];
    
    
    // presentView
    presentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameView.frame), MGSCREEN_width, 50)];
    presentView.backgroundColor = MGProductBackGray;
    [scrollView addSubview:presentView];
    
    presentButton = [[UIButton alloc] initWithFrame:CGRectMake(MGSmallMargin * 3, 13, 55, 24)];
    [presentButton setTitle:@"促销" forState:UIControlStateNormal];
    presentButton.backgroundColor = MGRGBColor(252, 85, 88);
    presentButton.layer.cornerRadius = 5;
    [presentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [presentView addSubview:presentButton];
    
    presentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, MGSCREEN_width * 0.7, 50)];
    presentLabel.textColor = [UIColor blackColor];
    presentLabel.font = MGFont(14);
    presentLabel.text = @"买一赠一 (赠品有限,赠完为止)";
    [presentView addSubview:presentLabel];
    
    [self buildLineView:CGRectMake(0, presentView.height - 1, MGSCREEN_width, 1) addLineToView:presentView];
    
   
    // detailView
    detailView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(presentView.frame), MGSCREEN_width, 150)];
    detailView.backgroundColor = MGProductBackGray;
    [scrollView addSubview:detailView];
    
    brandLabel = [UILabel new];
    brandLabel.frame = CGRectMake(MGSmallMargin * 3, 0, 80, 50);
    brandLabel.textColor = MGRGBColor(150, 150, 150);
    brandLabel.text = @"品       牌";
    brandLabel.font = MGFont(14);
    [detailView addSubview:brandLabel];
    
    brandTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, MGSCREEN_width * 0.6, 50)];
    brandTitleLabel.textColor = [UIColor blackColor];
    brandTitleLabel.font = MGFont(14);
    [detailView addSubview:brandTitleLabel];
    
    [self buildLineView:CGRectMake(0, detailView.height - 1, MGSCREEN_width, 1) addLineToView:detailView];
    
    detailLabel = [[UILabel alloc]initWithFrame: CGRectMake(MGSmallMargin * 3, 50, 80, 50)];
    detailLabel.text = @"产品规格";
    detailLabel.textColor = brandLabel.textColor;
    detailLabel.font = brandTitleLabel.font;
    [detailView addSubview:detailLabel];
    
    detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, MGSCREEN_width * 0.6, 50)];
    detailTitleLabel.textColor = brandTitleLabel.textColor;
    detailTitleLabel.font = brandTitleLabel.font;
    [detailView addSubview:detailTitleLabel];
    
    [self buildLineView:CGRectMake(0, 100 - 1, MGSCREEN_width, 1) addLineToView:detailView];

    
    textImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(MGSmallMargin * 3, 100, 80, 50)];
    textImageLabel.textColor = brandLabel.textColor;
    textImageLabel.font = brandLabel.font;
    textImageLabel.text = @"图文详情";
    [detailView addSubview:textImageLabel];
    
    
    // promptView
    promptView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detailView.frame), MGSCREEN_width, 80)];
    promptView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:promptView];
    
    promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(MGSmallMargin * 3, 5, MGSCREEN_width, 20)];
    promptLabel.text = @"温馨提示:";
    promptLabel.textColor = [UIColor blackColor];
    [promptView addSubview:promptLabel];
    
    promptDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(MGSmallMargin * 3, 20, MGSCREEN_width - 30, 60)];
    promptDetailLabel.textColor = presentButton.backgroundColor;
    promptDetailLabel.numberOfLines = 2;
    promptDetailLabel.text = @"商品签收后, 如有问题请您在24小时内联系4008484842,并将商品及包装保留好,拍照发给客服";
    promptDetailLabel.font = MGFont(14);
    [promptView addSubview:promptDetailLabel];
    
    
    // 底部的View
    [self buildLineView:CGRectMake(0, MGSCREEN_height - 51, MGSCREEN_width, 1) addLineToView:self.view];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - MGNavHeight - 50, MGSCREEN_width, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    addProductBtn = [[UIButton alloc] init];
    addProductBtn.tag = ProductTypeAdd;
    addProductBtn.backgroundColor = [UIColor redColor];
    [addProductBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addProductBtn setTitleColor:[UIColor grayColor]  forState:UIControlStateHighlighted];
    [addProductBtn addTarget:self action:@selector(addOrBuyProduct:) forControlEvents:UIControlEventTouchUpInside];
    
    buyProductBtn = [[UIButton alloc] init];
    buyProductBtn.tag = ProductTypeBuy;
    buyProductBtn.backgroundColor = [UIColor purpleColor];
    [buyProductBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyProductBtn setTitleColor:[UIColor grayColor]  forState:UIControlStateHighlighted];
    [buyProductBtn addTarget:self action:@selector(addOrBuyProduct:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat width = self.view.width/2;
    addProductBtn .frame = CGRectMake(0, 0, width, bottomView.height);
    buyProductBtn .frame = CGRectMake(width, 0, width, bottomView.height);
    
    [bottomView addSubview:addProductBtn];
    [bottomView addSubview:buyProductBtn];
}


#pragma mark - 快速创建分割线
- (void)buildLineView:(CGRect)frame addLineToView:(UIView *)view{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [view addSubview:lineView];
}



#pragma mark - 购物车
- (void)addOrBuyProduct:(UIButton *)sender{
    if (sender.tag == ProductTypeAdd) { // 添加商品
        StandardsView *mystandardsView = [self buildStandardView:productImageView.image andIndex:sender.tag];
//        mystandardsView.GoodDetailView = self.view;//设置该属性 对应的view 会缩小    }else{ // 立即购买商品 (跳转到 购买支付界面)
        
        mystandardsView.showAnimationType = StandsViewShowAnimationShowFromLeft;
        mystandardsView.dismissAnimationType = StandsViewDismissAnimationDisToRight;
//        mystandardsView.showAnimationType = StandsViewShowAnimationFlash;
//        mystandardsView.dismissAnimationType = StandsViewDismissAnimationFlash;
        [mystandardsView show];
    }
}

-(StandardsView *)buildStandardView:(UIImage *)img andIndex:(NSInteger)index
{
    StandardsView *standview = [[StandardsView alloc] init];
    standview.tag = index;
    standview.delegate = self;
    
    standview.mainImgView.image = img;
    standview.mainImgView.backgroundColor = [UIColor whiteColor];
    standview.priceLab.text = priceLabel.text;
    standview.tipLab.text = @"请选择规格";
    standview.goodNum.text = [NSString stringWithFormat:@"库存 %d 件",arc4random_uniform(100)];
    
    
    standview.customBtns = @[@"确定"];
    
    
    standardClassInfo *tempClassInfo1 = [standardClassInfo StandardClassInfoWith:@"100" andStandClassName:@"红色"];
    standardClassInfo *tempClassInfo2 = [standardClassInfo StandardClassInfoWith:@"101" andStandClassName:@"蓝色"];
    NSArray *tempClassInfoArr = @[tempClassInfo1,tempClassInfo2];
    StandardModel *tempModel = [StandardModel StandardModelWith:tempClassInfoArr andStandName:@"颜色"];
    
    
    
    standardClassInfo *tempClassInfo3 = [standardClassInfo StandardClassInfoWith:@"102" andStandClassName:@"XL"];
    standardClassInfo *tempClassInfo4 = [standardClassInfo StandardClassInfoWith:@"103" andStandClassName:@"XXL"];
    standardClassInfo *tempClassInfo5 = [standardClassInfo StandardClassInfoWith:@"104" andStandClassName:@"XXXXXXXXXXXXXL"];
    NSArray *tempClassInfoArr2 = @[tempClassInfo3,tempClassInfo4,tempClassInfo5];
    StandardModel *tempModel2 = [StandardModel StandardModelWith:tempClassInfoArr2 andStandName:@"尺寸"];
    standview.standardArr = @[tempModel,tempModel2];
    
    return standview;
}


#pragma mark - standardView  delegate
//点击自定义按键
-(void)StandardsView:(StandardsView *)standardView CustomBtnClickAction:(UIButton *)sender
{
    if (sender.tag == ProductTypeAdd) {
        //将商品图片抛到指定点
        [standardView ThrowGoodTo:CGPointMake(_shopCar.x, _shopCar.y-50) andDuration:1.6 andHeight:150 andScale:20];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [standardView dismiss];
        });
    }
    else
    {
        [standardView dismiss];
    }
}

//点击规格代理
-(void)Standards:(StandardsView *)standardView SelectBtnClick:(UIButton *)sender andSelectID:(NSString *)selectID andStandName:(NSString *)standName andIndex:(NSInteger)index
{
    
    // MGLog(@"selectID = %@ standName = %@ index = %ld",selectID,standName,(long)index);
    
}
//设置自定义btn的属性
-(void)StandardsView:(StandardsView *)standardView SetBtn:(UIButton *)btn
{
    if (btn.tag == 0) {
        btn.backgroundColor = [UIColor yellowColor];
    }
    else if (btn.tag == 1)
    {
        btn.backgroundColor = [UIColor orangeColor];
    }
}





#pragma mark - 分享
- (void)setUpNavigationItem:(NSString *)titleText {
    self.navigationItem.title = titleText;
    
    // 分享
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    
    // 购物车
    UIButton *carBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [carBtn setImage:[UIImage imageNamed:@"v2_whiteShopSmall"] forState:UIControlStateNormal];
    [carBtn addTarget:self action:@selector(carBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *carItem = [[UIBarButtonItem alloc] initWithCustomView:carBtn];
    _shopCar = carBtn;
    self.navigationItem.rightBarButtonItems = @[shareItem,carItem];
}

// MARK: - 购物车Action
- (void)carBtnClick{
    [UIView animateWithDuration:1.0 animations:^{
        self.tabBarController.selectedIndex = 2;
    }];
}

// MARK: - 分享Action
- (void)shareItemClick {
    // 微信
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://github.com/LYM-mg/MGLoveFreshBeen";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"mingming";
    
    // 朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.jianshu.com/users/57b58a39b70e/latest_articles";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"赶快来关注我吧，支持我";
    
    NSString *shareText = @"小明OC全新开源作品,高仿爱鲜蜂,希望可以前来支持“。 https://github.com/LYM-mg/MGLoveFreshBeen";             //分享内嵌文字
    
    //分享内嵌图片
    UIImage *shareImage = productImageView.image;
    
    // 分享平台
    NSArray *arr = [NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, nil];
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:MGUmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:arr
                                       delegate:self];
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    // 其他平台 UMShareToTencent,UMShareToRenren,UMShareToDouban,
    NSArray *arr = [NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, nil];
    
    //这里你可以把分享平台UMShareToSina换成其他平台
    [[UMSocialDataService defaultDataService] postSNSWithTypes:arr content:@"ming" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        }
    }];
}


@end
