//
//  AboutMeVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "AboutMeVC.h"

@interface AboutMeVC ()

@end

@implementation AboutMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.title = @"关于作者";
}

#pragma mark - 操作
- (IBAction)turnToGithub:(UIButton *)btn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:btn.titleLabel.text]];
}

- (IBAction)turnToJianshu:(UIButton *)btn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:btn.titleLabel.text]];
}

@end
