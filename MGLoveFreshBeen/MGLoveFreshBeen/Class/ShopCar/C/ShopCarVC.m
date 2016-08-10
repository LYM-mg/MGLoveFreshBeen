//
//  ShopCarVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarVC.h"
#import "UserShopCarTool.h"


@interface ShopCarVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *shopImageView;
    UILabel *emptyLabel;
    UIButton *emptyButton;
}
/** tableView */
@property (nonatomic,weak) UITableView *shopCarTableView;
/** 是否是第一次加载数据 */
@property (nonatomic, assign,getter=isFristLoadData) BOOL fristLoadData;


@end

@implementation ShopCarVC
#pragma mark - 生命周期
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([[UserShopCarTool shareUserShopCarTool] isEmpty]) {
        [self showshopCarEmptyUI];
    } else {
        [SVProgressHUD showInfoWithStatus:@"正在加载商品信息"];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.5*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self showProductView];
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.导航栏
    [self setUpNavigationItem];
   
    // 2.通知
    [self addNSNotification];
    
    // 3.
    [self setUpEmptyUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavigationItem
- (void)setUpNavigationItem {
    self.navigationItem.title = @"购物车";
}

#pragma mark - 没有商品时的UI界面
- (void)setUpEmptyUI {
    shopImageView = [[UIImageView alloc] init];
    shopImageView.image = [UIImage imageNamed:@ "v2_shop_empty"];
    shopImageView.contentMode = UIViewContentModeCenter;
    shopImageView.frame = CGRectMake((self.view.width - shopImageView.width) * 0.5, self.view.height * 0.25, shopImageView.width, shopImageView.height);
    shopImageView.hidden = YES;
    [self.view addSubview:shopImageView];
    
    emptyLabel = [UILabel new];
    emptyLabel.text = @"亲,购物车空空的耶~赶紧挑好吃的吧";
    emptyLabel.textColor = MGRGBColor(100, 100, 100);
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.frame = CGRectMake(0, CGRectGetMaxY(shopImageView.frame) + 55, self.view.width, 50);
    emptyLabel.font = MGFont(16);
    emptyLabel.hidden = YES;
   [self.view addSubview:emptyLabel];
    
    emptyButton = [[UIButton alloc] init];
    emptyButton.frame = CGRectMake((self.view.width - 150) * 0.5, CGRectGetMaxY(emptyLabel.frame) + 15, 150, 30);
    [emptyButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [emptyButton setTitle:@"去首页逛逛" forState:UIControlStateNormal];
    [emptyButton setTitleColor:MGRGBColor(100, 100, 100)  forState: UIControlStateNormal];
    [emptyButton addTarget:self action:@selector(goToHomeLookLook) forControlEvents:UIControlEventTouchUpInside];
    emptyButton.hidden = YES;
    [self.view addSubview:emptyButton];
}
// 去首页瞧瞧
- (void)goToHomeLookLook{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
         self.tabBarController.selectedIndex = 0;
    } completion:nil];
   
}

- (void)showProductView {
    if (!self.isFristLoadData) {
        
        [self setUpTableHeadView];
        
        [self setUpshopCarTableView];
        
        self.fristLoadData = YES;
    }
}


- (void)setUpshopCarTableView{
    UITableView *shopCarTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, MGSCREEN_height - 64 - 50) style:UITableViewStylePlain];
    
//    shopCarTableView.tableHeaderView = tableHeadView;
//    tableFooterView.frame = CGRectMake(0, ScreenHeight - 64 - 50, ScreenWidth, 50)
//    view.addSubview(tableFooterView)
//    tableFooterView.delegate = self
    shopCarTableView.delegate = self;
    shopCarTableView.dataSource = self;
    shopCarTableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
    shopCarTableView.rowHeight = 50;
    shopCarTableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:shopCarTableView];
}



/**
 *  tableView头部
 */
- (void)setUpTableHeadView {
    
}

/**
 *  购物车空的时候的UI
 */
- (void)showshopCarEmptyUI {
    shopImageView.hidden = NO;
    emptyButton.hidden = NO;
    emptyLabel.hidden = NO;
    self.shopCarTableView.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [UserShopCarTool shareUserShopCarTool].getShopCarProductsClassCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - 通知
- (void)addNSNotification{
    /**
     *  移除所有商品
     */
    [MGNotificationCenter addObserverForName:MGShopCarDidRemoveProductNSNotification object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        tableFooterView.priceLabel.text = [[UserShopCarTool shareUserShopCarTool]getAllProductsPrice];
    }];
    
    /**
     *  价格改变
     */
    [MGNotificationCenter addObserverForName:MGShopCarBuyPriceDidChangeNotification object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        if ([[UserShopCarTool shareUserShopCarTool] isEmpty]) {
//            [self showshopCarEmptyUI]; // 没有商品时的UI界面
        }
        
        [self.shopCarTableView reloadData];
    }];
}
- (void)dealloc{
    [MGNotificationCenter removeObserver:self];
}

@end
