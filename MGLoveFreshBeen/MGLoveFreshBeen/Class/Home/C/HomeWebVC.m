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
    UIWebView *_webView; // webView
    UIView *_loadProgressAnimationView; //导航条  （动态加载View）
}


@end

@implementation HomeWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
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
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    // 加载数据
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (void)viewDidLayoutSubviews{
    _webView.frame = self.view.bounds;
}

#pragma mark -  右边导航条刷新按钮
- (void)setUpRightNavItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshClick)];
}

- (void)refreshClick{
    [_webView reload];
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
    [UIView animateWithDuration:0.6 animations:^{
        _loadProgressAnimationView.width = MGSCREEN_width * 0.58;
    } completion:^(BOOL finished) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.2*NSEC_PER_SEC);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                _loadProgressAnimationView.width = MGSCREEN_width * 0.85;
            }];
        });
    }];
}

#pragma mark - 隐藏加载条（加载完毕）
- (void)endLoadProgressAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        _loadProgressAnimationView.width =  MGSCREEN_width *0.99;
    } completion:^(BOOL finished) {
        _loadProgressAnimationView.hidden = YES;
    }];
}



@end
