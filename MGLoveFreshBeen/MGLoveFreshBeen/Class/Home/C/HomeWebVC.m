//
//  HomeWebVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeWebVC.h"
#import "HeadReosurce.h"


@interface HomeWebVC ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIView *_loadProgressAnimationView;
}


@end

@implementation HomeWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    [self bulidWebView];
    [self buildProgressAnimationView];
}

#pragma mark - 便利构造方法
- (instancetype)initWithNavigationTitle:(NSString *)navTitle withUrlStr:(NSString *)urlStr{
    if (self = [super init]) {
        self.navTitle = navTitle;
        self.urlStr = urlStr;
    }
    return self;
}

- (void)buildProgressAnimationView{
    _loadProgressAnimationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, 3)];
    _loadProgressAnimationView.backgroundColor = [UIColor orangeColor];
    _loadProgressAnimationView.width = 0;
    [self.view addSubview:_loadProgressAnimationView];
}

- (void)bulidWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    // 加载数据
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self startLoadProgressAnimation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self endLoadProgressAnimation];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    MGPS(@"没有网络，加载数据失败");
}

#pragma mark - 显示加载条
- (void)startLoadProgressAnimation {
    _loadProgressAnimationView.width = 0;
    _loadProgressAnimationView.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
        _loadProgressAnimationView.width = MGSCREEN_width * 0.58;
    } completion:^(BOOL finished) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.4*NSEC_PER_SEC);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                _loadProgressAnimationView.width = MGSCREEN_width * 0.85;
            }];
        });
    }];
}

#pragma mark - 隐藏加载条（加载完毕）
- (void)endLoadProgressAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        _loadProgressAnimationView.width =  MGSCREEN_width *0.99;
    } completion:^(BOOL finished) {
        _loadProgressAnimationView.hidden = YES;
    }];
}


//@interface HomeWebVC ()<UIWebViewDelegate>
//{
//    /** webView */
//    UIWebView *webView;
//}
//
///** urlStr */
//@property (nonatomic,copy) NSString *urlStr;
//
///** webView */
////@property (nonatomic,weak) UIWebView *webView;
//@end
//
//@implementation HomeWebVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    [self setupWebView];
//    
//    [self setUpRightNavItem];
//}
//
//- (void)setUpRightNavItem{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshClick)];
//}
//
//- (void)refreshClick{
//    [webView reload];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - 便利构造方法
//- (instancetype)initWithNavigationTitle:(NSString *)navTitle withUrlStr:(NSString *)urlStr{
//    if (self = [super init]) {
//        self.navigationItem.title = navTitle;
//        self.urlStr = urlStr;
//    }
//    return self;
//}
//
//// 设置微博View并加载数据网络请求
//- (void)setupWebView{
//    webView = [[UIWebView alloc] init];
//    [self.view addSubview:webView];
//    webView.delegate = self;
//    
////    self.webView = webView;
//    [self loadData];
//}
//
//- (void)viewDidLayoutSubviews{
//    webView.frame = self.view.bounds;
//}
//
//- (void)loadData{
//    NSURL *url = [NSURL URLWithString:self.urlStr];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [webView loadRequest:request];
//}
//
//#pragma mark - UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    MGPS(@"开始加载");
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    MGPS(@"加载完毕");
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    MGPE(@"加载失败，请重新加载");
//}


@end
