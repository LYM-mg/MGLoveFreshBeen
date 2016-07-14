//
//  TabBarVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "TabBarVC.h"
#import "NavigationVC.h"
#import "HomeVC.h"
#import "SuperMarketVC.h"
#import "ShopCarVC.h"
#import "MineVC.h"

@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 1.用自己的TabBar代替系统的TabBar
//    [self setValue:[[LYMTabBar alloc] init] forKey:@"tabBar"];
    
    // 2.初始化所有的自控制器
    [self setUpAllChildController];
    
}

#pragma mark ========= initialize ===========
+ (void)initialize{
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor grayColor]
                           };
    [[UITabBarItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
}

#pragma mark ========= 初始化所有的子控制器 =========
/**
 *  初始化所有的子控制器
 */
- (void)setUpAllChildController{
    NSArray *imageArr = @[@"v2_home", @"v2_order", @"shopCart", @"v2_my"];
    NSArray *selImageArr = @[@"v2_home_r", @"v2_order_r", @"shopCart_r", @"v2_my_r"];
    
    // 4.我
    MineVC *meVC = [[MineVC alloc] init];
    meVC.view.backgroundColor = [UIColor purpleColor];
    [self setNavOneChildViewController:meVC title:@"我" image:imageArr[3] selImage:
     selImageArr[3]];
    
    // 1.首页
    HomeVC *essenceCV = [[HomeVC alloc] init];
    [self setNavOneChildViewController:essenceCV title:@"首页" image:imageArr[0] selImage:selImageArr[0]];
    
    // 2.闪电超市
    SuperMarketVC *newVC = [[SuperMarketVC alloc] init];
    newVC.view.backgroundColor = [UIColor redColor];
    [self setNavOneChildViewController:newVC title:@"闪电超市" image:imageArr[1]
                              selImage:selImageArr[1]];
    
    // 3.购物车
    ShopCarVC *friendVC = [[ShopCarVC alloc] init];
    [self setNavOneChildViewController:friendVC title:@"购物车" image:imageArr[2] selImage:selImageArr[2]];
    
    
}

/**
 *  初始化一个子控制器的方法
 */
- (void)setNavOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    vc.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    
    [self addChildViewController:[[NavigationVC alloc] initWithRootViewController:vc]];
}


@end
