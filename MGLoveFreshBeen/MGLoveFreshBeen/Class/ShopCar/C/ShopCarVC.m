//
//  ShopCarVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarVC.h"
#import "UserShopCarTool.h"

#import "ShopCarHeaderView.h"
#import "ShopCarTableViewBottomView.h"

#import "ShopCarCell.h"
#import "OrderPayWayVC.h"
#import "MyAddressVC.h"

@interface ShopCarVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *shopImageView;
    UILabel *emptyLabel;
    UIButton *emptyButton;
}
/** tableView */
@property (nonatomic,weak) UITableView *shopCarTableView;
/** tableView顶部 */
@property (nonatomic,weak) ShopCarHeaderView *tableHearderView;
/** tableView底部 */
@property (nonatomic,weak) ShopCarTableViewBottomView *tableBottomView;
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
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.8*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
//            [self showProductView];
            [self hideshopCarEmptyUI];
            [self.shopCarTableView reloadData];
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.导航栏
    [self setUpNavigationItem];
   
    // 2.通知
    [self addNSNotification];
    
    // 3.设置购物车数据为nil时的UI
    [self setUpEmptyUI];
    
    // 4.有数据时的界面
    [self setUpshopCarTableView];
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
    [self setUpshopCarTableView];
}


- (void)setUpshopCarTableView{
    __weak typeof(self) weakSelf = self;
    
    UITableView *shopCarTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, MGSCREEN_height - MGNavHeight - MGShopCartRowHeight - MGTabBarHeight) style:UITableViewStylePlain];
    
    // 顶部
    ShopCarHeaderView *tableHearderView = [[ShopCarHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 250)];
    tableHearderView.backgroundColor = MGRGBColor(240, 240, 240);
    shopCarTableView.tableHeaderView = tableHearderView;
    
    shopCarTableView.delegate = self;
    shopCarTableView.dataSource = self;
    shopCarTableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
    shopCarTableView.rowHeight = MGShopCartRowHeight;
    shopCarTableView.backgroundColor = MGRGBColor(243, 243, 243);
    shopCarTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:shopCarTableView];
    _shopCarTableView = shopCarTableView;
    /**
     *  修改收货地址
     */
    tableHearderView.changeUserInfoClickCallBack = ^{
        MyAddressVC *addressVC = [[MyAddressVC alloc] initWithSelectedAdressCallback:^(AddressCellModel *address) {
             _tableHearderView.addressModel = address;
        }];
        [weakSelf.navigationController pushViewController:addressVC animated:YES];
    };
    
    
    
    // 底部
    ShopCarTableViewBottomView *tableBottomView = [[ShopCarTableViewBottomView alloc] initWithFrame:CGRectMake(0, MGSCREEN_height - MGNavHeight - MGShopCartRowHeight - MGTabBarHeight, MGSCREEN_width, MGShopCartRowHeight)];
    [self.view addSubview:tableBottomView];
    [self.view bringSubviewToFront:tableBottomView];
    _tableBottomView = tableBottomView;
    /**
     *  确定订单，跳转到支付界面
     */
    tableBottomView.sureProductsButtonClickWoothBlock = ^{
        OrderPayWayVC *orderPayVC = [[OrderPayWayVC alloc] init];
        [self.navigationController pushViewController:orderPayVC animated:YES];
    };
}

/**
 *  购物车为空的时候的UI
 */
- (void)showshopCarEmptyUI {
    shopImageView.hidden = NO;
    emptyButton.hidden = NO;
    emptyLabel.hidden = NO;
    self.shopCarTableView.hidden = YES;
    self.tableBottomView.hidden  = YES;
}
/**
 *  隐藏购物车为空的时候的UI
 */
- (void)hideshopCarEmptyUI {
    shopImageView.hidden = YES;
    emptyButton.hidden = YES;
    emptyLabel.hidden = YES;
    self.shopCarTableView.hidden = NO;
    self.tableBottomView.hidden  = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [UserShopCarTool shareUserShopCarTool].getShopCarProductsClassCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCarCell *cell = [ShopCarCell shopCarCellWithTableView:tableView];
    
    cell.goods = [[UserShopCarTool shareUserShopCarTool] getShopCarProducts][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - 通知
- (void)addNSNotification{
    /**
     *  价格改变
     */
    [MGNotificationCenter addObserverForName:MGShopCarBuyPriceDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        self.tableBottomView.priceLabel.text = [[UserShopCarTool shareUserShopCarTool]getAllProductsPrice];
    }];
    
    /**
     *  移除所有商品
     */
    [MGNotificationCenter addObserverForName:MGShopCarDidRemoveProductNSNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        if ([[UserShopCarTool shareUserShopCarTool] isEmpty]) {
            [self showshopCarEmptyUI]; // 没有商品时的UI界面
        }
        
        [self.shopCarTableView reloadData];
    }];
}
- (void)dealloc{
    MGLogFunc;
    [MGNotificationCenter removeObserver:self];
}

@end
