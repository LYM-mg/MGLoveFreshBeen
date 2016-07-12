//
//  SettingVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "SettingVC.h"
#import "AboutMeVC.h"


@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于作者";
    
    self.view.backgroundColor = MGRGBColor(160, 160, 160);
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


#pragma mark - 私有方法
#pragma mark - setUpUI
- (void)setUpUI{
    CGFloat subHeight = 50;
    
    CGFloat y = self.navigationController ? MGNavHeight + 10 : 10;
    
    // 关于我
    UIView *aboutMeView = [[UIView alloc] initWithFrame:CGRectMake(0, y, MGSCREEN_width, subHeight)];
    aboutMeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aboutMeView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutMeViewClick)];
    [aboutMeView addGestureRecognizer:tap];
    
    UILabel *aboutLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, subHeight)];
    aboutLabel.text = @"关于明哥";
    aboutLabel.font = MGFont(16);
    [aboutMeView addSubview:aboutLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"icon_go"]];
    arrowImageView.frame = CGRectMake(MGSCREEN_width - 20, (aboutMeView.height - arrowImageView.height)*0.5, 10, 15);
    [aboutMeView addSubview:arrowImageView];
    [self addline:aboutMeView];
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(10, CGRectGetMaxY(aboutMeView.frame) - 0.5, MGSCREEN_width - 10, 0.5);
    lineLayer.backgroundColor = [UIColor blackColor].CGColor;
    [aboutMeView.layer addSublayer:lineLayer];
    
    // 清理缓存
    UIView *cleanCacheView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(aboutMeView.frame) + 1, MGSCREEN_width, subHeight)];
    cleanCacheView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cleanCacheView];
    
    UILabel *cleanCacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, subHeight)];
    cleanCacheLabel.text = @"清理缓存";
    cleanCacheLabel.font = MGFont(16);
    [cleanCacheView addSubview:cleanCacheLabel];
    
    UILabel *cacheNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, MGSCREEN_width - 165, subHeight)];
    cacheNumberLabel.textAlignment = NSTextAlignmentRight;
    cacheNumberLabel.textColor = MGRGBColor(190, 190, 190);
    cacheNumberLabel.text = [NSString stringWithFormat:@""];
    [cleanCacheView addSubview:cacheNumberLabel];
    [self addline:cleanCacheView];
    
    // 退出当前账号
    UIView *logoutView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cleanCacheView.frame) + 20, MGSCREEN_width, subHeight)];
    logoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logoutView];
    
    UILabel *logoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, MGSCREEN_width - 165, subHeight)];
    logoutLabel.text = @"退出当前账号";
    logoutLabel.textColor = MGRGBColor(90, 90, 90);
    logoutLabel.font = MGFont(16);
    logoutLabel.textAlignment = NSTextAlignmentCenter;
    [logoutView addSubview:logoutLabel];
    [self addline:logoutView];
}

- (void)addline:(UIView *)superView{
//    CALayer *lineLayer = [CALayer layer];
//    lineLayer.frame = CGRectMake(10, CGRectGetMaxY(superView.frame) - 0.5, MGSCREEN_width - 10, 0.5);
//    lineLayer.backgroundColor = [UIColor blackColor].CGColor;
//    [superView.layer addSublayer:lineLayer];
}

- (void)aboutMeViewClick{
    AboutMeVC *aboutVC = [[AboutMeVC alloc] initWithNibName:NSStringFromClass([AboutMeVC class]) bundle:nil];
    
    [self.navigationController pushViewController:aboutVC animated:YES];
}

@end
