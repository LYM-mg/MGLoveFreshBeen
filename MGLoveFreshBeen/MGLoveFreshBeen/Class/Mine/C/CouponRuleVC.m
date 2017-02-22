//
//  CouponRuleVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "CouponRuleVC.h"

@interface CouponRuleVC ()<UIWebViewDelegate>
{
   UIWebView *_webView;
    UIView *_loadProgressAnimationView;
}
@end

@implementation CouponRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bulidWebView];
    [self buildProgressAnimationView];
    
    [self startLoadProgressAnimation];
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
    [UIView animateWithDuration:0.5 animations:^{
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
        _loadProgressAnimationView.width = MGSCREEN_width;
    } completion:^(BOOL finished) {
        _loadProgressAnimationView.hidden = YES;
    }];
}


@end
