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

#import "UserShopCarTool.h"
#import <objc/runtime.h>

@interface TabBarVC () <UITabBarControllerDelegate>

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 1.用自己的TabBar代替系统的TabBar
//    [self setValue:[[LYMTabBar alloc] init] forKey:@"tabBar"];
    self.delegate = self;
    
    // 2.初始化所有的自控制器
    [self setUpAllChildController];
    
    // 3.监听通知
    [self addNotication];
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
    
    // 1.首页
    HomeVC *essenceCV = [[HomeVC alloc] init];
    essenceCV.view.tag = 0;
    [self setNavOneChildViewController:essenceCV title:@"首页" image:imageArr[0] selImage:selImageArr[0]];

    // 2.闪电超市
    SuperMarketVC *newVC = [[SuperMarketVC alloc] initWithNibName:NSStringFromClass([SuperMarketVC class]) bundle:nil];
    newVC.view.tag = 1;
    newVC.view.backgroundColor = [UIColor redColor];
    [self setNavOneChildViewController:newVC title:@"闪电超市" image:imageArr[1]
                              selImage:selImageArr[1]];
    
    // 3.购物车
    ShopCarVC *shopCarVC = [[ShopCarVC alloc] init];
    shopCarVC.view.tag = 3;
    [self setNavOneChildViewController:shopCarVC title:@"购物车" image:imageArr[2] selImage:selImageArr[2]];
    
    // 4.我
    MineVC *meVC = [[MineVC alloc] init];
    meVC.view.tag = 3;
    meVC.view.backgroundColor = [UIColor purpleColor];
    [self setNavOneChildViewController:meVC title:@"我" image:imageArr[3] selImage:
     selImageArr[3]];

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


#pragma markr - 购物车商品购买数量改变的通知
- (void)addNotication{
    [MGNotificationCenter addObserver:self selector:@selector(shopCarBuyNumberChanged) name:MGShopCarBuyNumberDidChangeNotification object:nil];
}

- (void)shopCarBuyNumberChanged {
    UIViewController *controller = self.childViewControllers[2];
    UITabBarItem *item = controller.tabBarItem;
    NSInteger goodsNumer = [[UserShopCarTool shareUserShopCarTool] userShopCarProductsNumber];
    if (goodsNumer == 0) {
        item.badgeValue = nil;
        return;
    }
    item.badgeValue = [NSString stringWithFormat:@"%ld",(long)goodsNumer];
    
    
    // 成员变量名：_view 成员变量类型：@"UITabBarButton"
    UIView *tabBarButton = [item valueForKey:@"_view"];
    if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        // 成员变量名：_badge 成员变量类型：@"_UIBadgeView"
        // 成员变量名：_selectedIndicator 成员变量类型：@"UIImageView"
        // 成员变量名：_info 成员变量类型：@"UITabBarSwappableImageView"
        // 购物车抖动 // transform.translation
        CABasicAnimation *cartAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        cartAnimation.duration = 0.25;
        cartAnimation.fromValue = @(0.1);
        cartAnimation.toValue = @(1.5);
        cartAnimation.autoreverses = YES;
        UIImageView *img2 = [tabBarButton valueForKey:@"_info"];
        [img2.layer addAnimation:cartAnimation forKey:nil];
        
        CABasicAnimation *bageAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
        bageAnimation.duration = 0.25;
        bageAnimation.fromValue = @(-5);
        bageAnimation.toValue = @(5);
        bageAnimation.autoreverses = YES;
        UIView *bage = [tabBarButton valueForKey:@"_badge"];
        [bage.layer addAnimation:bageAnimation forKey:nil];
        
//        unsigned int outCount = 0;
//        Ivar *ivars = class_copyIvarList(NSClassFromString(@"UITabBarButton"), &outCount);
//        // 遍历所有成员变量
//        for (int i = 0; i < outCount; i++) {
//            // 取出i位置对应的成员变量
//            Ivar ivar = ivars[i];
//            const char *name = ivar_getName(ivar);
//            const char *type = ivar_getTypeEncoding(ivar);
//            NSLog(@"成员变量名：%s 成员变量类型：%s",name,type);
//        }
//        // 注意释放内存！
//        free(ivars);
    }
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // 成员变量名：_view 成员变量类型：@"UITabBarButton"
    UIView *tabBarButton = [item valueForKey:@"_view"];
    if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        CABasicAnimation *imgAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        imgAnimation.duration = 0.25;
        imgAnimation.fromValue = @(0.2);
        imgAnimation.toValue = @(1.3);
        imgAnimation.autoreverses = YES;
        UIImageView *img = [tabBarButton valueForKey:@"_info"];
        [img.layer addAnimation:imgAnimation forKey:nil];
    }
}

- (void)dealloc{
    [MGNotificationCenter removeObserver:self];
}

@end
