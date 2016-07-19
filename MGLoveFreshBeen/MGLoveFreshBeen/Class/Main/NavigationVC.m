//
//  NavigationVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "NavigationVC.h"

@interface NavigationVC ()<UINavigationBarDelegate,UIGestureRecognizerDelegate>

@end

@implementation NavigationVC

+ (void)load{
    if (self == [NavigationVC class]) {
        UINavigationBar *navBar = [UINavigationBar appearance];
        UIBarButtonItem *barItem = [UIBarButtonItem appearance];
        
        if(ISIOS8)
            navBar.translucent = NO;
        else
            navBar.translucent  =NO;
        navBar.barTintColor = MGNavBarTiniColor;
        navBar.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.000];
        [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [navBar setTitleTextAttributes:@{
                                         NSForegroundColorAttributeName :[UIColor whiteColor] ,
                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
                                         }];
        
        
        if(barItem==[[UINavigationItem alloc] init].leftBarButtonItem){
            [barItem setTitleTextAttributes:@{
                                              NSForegroundColorAttributeName : [UIColor clearColor],
                                              NSFontAttributeName : [UIFont systemFontOfSize:14]
                                              } forState:UIControlStateNormal];
        }else{
            [barItem setTitleTextAttributes:@{
                                              NSForegroundColorAttributeName : [UIColor whiteColor],
                                              NSFontAttributeName : [UIFont systemFontOfSize:14]
                                              } forState:UIControlStateNormal];
            
        }
    }
}

#pragma mark ========= 添加全屏滑动手势 ==========
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setp1:需要获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // setp2:创建全屏滑动手势~调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // step3:设置手势代理~拦截手势触发
    pan.delegate = self;
    
    // step4:别忘了~给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // step5:将系统自带的滑动手势禁用
    self.interactivePopGestureRecognizer.enabled = NO;
}

// steo6:还记得刚刚设置的代理吗？下面方法什么时候调用？在每次触发手势之前都会询问下代理，是否触发。
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
}
/** 判断是否为根控制器 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 只要不等于1就返回YES，说明此时具有滑动功能
    return self.childViewControllers.count != 1;
}

#pragma mark ========= 拦截控制器的push操作 ==========
/**
 *   拦截控制器的push操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count != 0) {
        // 判断当前控制器是否为根控制器，如果不是，就执行下列代码 backBtn.setImage(UIImage(named: "v2_goback"), forState: .Normal)
        UIButton *leftBtn = [[UIButton alloc] init];
        [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
        [leftBtn sizeToFit];
        /** 想让 导航栏的左按钮向左偏一点的方法 */
        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        /** 想让按钮的内容水平居左 */
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;  /** 想让按钮的内容水平居左 */
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
        /**
         *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
         *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
         */
        leftItem.width = -5;
        [viewController.navigationItem setLeftBarButtonItem:leftItem animated:YES];
        
        // 隐藏下面的TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

// 监听按钮的点击
- (void)leftBtnClick{
    [self popViewControllerAnimated:YES];
}

- (void)setup{
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    if(ISIOS8)
        navBar.translucent = NO;
    else
        self.navigationBar.translucent  =NO;
    navBar.barTintColor = MGNavBarTiniColor;
    navBar.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.000];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName :[UIColor whiteColor] ,
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
                                     }];
    
    
    if(barItem==self.navigationItem.leftBarButtonItem){
        [barItem setTitleTextAttributes:@{
                                          NSForegroundColorAttributeName : [UIColor clearColor],
                                          NSFontAttributeName : [UIFont systemFontOfSize:0]
                                          } forState:UIControlStateNormal];
    }else{
        [barItem setTitleTextAttributes:@{
                                          NSForegroundColorAttributeName : [UIColor whiteColor],
                                          NSFontAttributeName : [UIFont systemFontOfSize:13]
                                          } forState:UIControlStateNormal];
        
    }
}

@end
