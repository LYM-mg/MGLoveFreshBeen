//
//  ProductDetailVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ProductDetailVC.h"
#import "SuperMarketModel.h"

@interface ProductDetailVC ()
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
    
    UIView *bottomView;
    UILabel *addProductLabel;
    
//    Goods *goods;
}
/** 数组 */
@property (nonatomic,strong) Goods *goods;
@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 添加子控件
    [self setupMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 遍历构造方法
- (instancetype)initWithGoods:(Goods *)goods{
    if (self = [super init]) {
        self.goods = goods;
        [productImageView sd_setImageWithURL:[NSURL URLWithString:[goods valueForKeyPath:@"img"]] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
        titleNameLabel.text = [goods valueForKeyPath:@"name"];
        //        priceView = DiscountPriceView(price: goods.price, marketPrice: goods.market_price)
        //        priceView.frame = CGRectMake(15, 40, ScreenWidth * 0.6, 40)
        //        nameView.addSubview(priceView)
        
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
        
        detailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aaaa"]];
        CGFloat scale = 320.0 / MGSCREEN_width;
        detailImageView.frame = CGRectMake(0, CGRectGetMaxY(promptView.frame), MGSCREEN_width, detailImageView.height / scale);
        [scrollView addSubview:detailImageView];
        scrollView.contentSize = CGSizeMake(MGSCREEN_width, CGRectGetMaxY(detailImageView.frame) + 50 + MGNavHeight);
        
        [self setUpNavigationItem:[goods valueForKeyPath:@"name"]];
    }
    return self;
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
    nameView.backgroundColor = [UIColor whiteColor];
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
    
    [self buildLineView:CGRectMake(0, MGSCREEN_height - 51 - MGNavHeight, MGSCREEN_width, 1) addLineToView:self.view];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, MGSCREEN_height - 50 - MGNavHeight, MGSCREEN_width, 50)];
    bottomView.backgroundColor = MGProductBackGray;
    [self.view addSubview:bottomView];
    
    addProductLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 50)];
    addProductLabel.text = @"添加商品:";
    addProductLabel.textColor = [UIColor blackColor];
    addProductLabel.font = MGFont(15);
    [bottomView addSubview:addProductLabel];
}


#pragma mark - 分割线
- (void)buildLineView:(CGRect)frame addLineToView:(UIView *)view{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [view addSubview:lineView];
}


#pragma mark - 分享
- (void)setUpNavigationItem:(NSString *)titleText {
    self.navigationItem.title = titleText;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

// MARK: - Action
- (void)rightItemClick {
    MGPS(@"暂时还没有集成分享");
}

//        buyView = BuyView(frame: CGRectMake(85, 12, 80, 25))
//        buyView.zearIsShow = true
//        buyView.goods = goods
//        bottomView.addSubview(buyView)
//
//        weak var tmpSelf = self
//        yellowShopCar = YellowShopCarView(frame: CGRectMake(ScreenWidth - 70, 50 - 61 - 10, 61, 61), shopViewClick: { () -> () in
//            let shopCarVC = ShopCartViewController()
//            let nav = BaseNavigationController(rootViewController: shopCarVC)
//            tmpSelf.presentViewController(nav, animated: true, completion: nil)
//        })
//
//        bottomView.addSubview(yellowShopCar)

@end
