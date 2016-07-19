//
//  AdvertiseVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#define MGKCode @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#import "AdvertiseVC.h"
#import "Aditem.h"
#import "TabBarVC.h"

@interface AdvertiseVC ()
/** 广告模型 */
@property (nonatomic,strong) Aditem *adItem;
/** 背景 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

/** 广告 */
@property (strong, nonatomic) UIImageView *adImageVeiw;

/** 定时器 */
@property (weak, nonatomic) NSTimer *timer;
/** 会话管理者 */
@property (weak, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation AdvertiseVC

#pragma mark - 设置图片
// 懒加载
- (UIImageView *)adImageVeiw{
    if (!_adImageVeiw) {
        // 0.创建_adImageVeiw
        _adImageVeiw = [[UIImageView alloc] init];
        
        // 1.让图片可以交互
        self.adImageVeiw.userInteractionEnabled = YES;
        self.adImageVeiw.alpha = 0.99;
        
        // 2.添加到父控件
        [self.view addSubview:_adImageVeiw];
        
        // 3.添加点按手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(jump)];
        [_adImageVeiw addGestureRecognizer:pan];
    }
    return _adImageVeiw;
}


// 监听点按手势
- (void)jump{
    NSURL *url = [NSURL URLWithString:_adItem.ori_curl];
    // 是否能打开URL
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - 开启定时器
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)timeChange{
    static int t = 2; // 必须用static修饰
    if (t ==-1) {
        [self skipToHomeVC];
    }
    t--;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.屏幕适配
    [self setupScreenHeight];
    
    // 2.加载广告数据
    [self loadData];
    
    // 3.开启定时器
    [self timer];
}

#pragma mark - 屏幕适配
// 1.屏幕适配
- (void)setupScreenHeight{
    if (iPone6s) {
        self.bgImageView.image = [UIImage imageNamed:@"iPone6s"];
    }else if (iPone6){
        self.bgImageView.image = [UIImage imageNamed:@"iphone6"];
    }else if (iPone5){
        self.bgImageView.image = [UIImage imageNamed:@"iphone5"];
    }else if (iPone4){
        self.bgImageView.image = [UIImage imageNamed:@"iphone4"];
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"iPone6"];
    }
}

#pragma mark - 加载广告数据
// 2.加载广告数据
- (void)loadData{
    // 创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.manager = manager;
    
    // 请求超时时间（超过这个时间就会来到fail那个Block里面）
    manager.requestSerializer.timeoutInterval = 5.0;
    
    // 第一种方法解决
    // 增加系列化的解析方式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    // 请求传递的参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = MGKCode;
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (responseObject == nil) return;
        // 字典转模型 （模型数组）
        NSMutableArray *adArray = [Aditem objectArrayWithKeyValuesArray:responseObject[@"ad"]];
        // 取得模型数组的最后一个模型
        Aditem *adItem = [adArray firstObject];
        self.adItem = adItem;
        
        // 判断一下广告模型是否为空
        if (self.adItem) {  // 有广告
            // 设置广告的尺寸 MGSCREEN_width*adItem.h/adItem.w
            CGFloat w = MGSCREEN_width;
            CGFloat h = MGSCREEN_height;
   
            self.adImageVeiw.frame = CGRectMake(0, 0, w, h);
            [self.adImageVeiw sd_setImageWithURL:[NSURL URLWithString:adItem.w_picurl]];
        }else{ // 没有广告
            [SVProgressHUD showErrorWithStatus:@"当前没有广告页面"];
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        MGPE(error);
    }];
    
}


#pragma mark - Navigation
#pragma mark - 进入主界面
/**
 *  跳过广告按钮的点击
 */
- (void)skipToHomeVC {
    // 1.移除定时器
    [self.timer invalidate];
    
    // 2.取消所有任务
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 3.移除会话管理者 invalidateSessionCancelingTasks:是否需要任务完成后再取消，这里填NO
    [_manager invalidateSessionCancelingTasks:NO];
    
//     UIViewAnimationOptionCurveEaseOut
    [UIView animateKeyframesWithDuration:2.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        self.adImageVeiw.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        self.adImageVeiw.alpha = 0.0;
        
        /// 自己增加：转场动画的使用
        CATransition *transAnimation = [[CATransition alloc] init];
        transAnimation.type = @"rippleEffect"; // 水花
        transAnimation.duration = 0.5; // 动画时间
        [MGKeyWindow.layer addAnimation:transAnimation forKey:nil];
        
        // 4.创建TabBar控制器
        TabBarVC *tabBarVC = [[TabBarVC alloc] init];
        tabBarVC.view.backgroundColor = [UIColor whiteColor];
        // 5.TabBar控制器成为主窗口
        MGKeyWindow.rootViewController = tabBarVC;
    } completion:^(BOOL finished) {
        
    }];

    
   
}


@end
