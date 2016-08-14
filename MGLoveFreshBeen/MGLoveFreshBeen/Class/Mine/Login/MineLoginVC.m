//
//  MineLoginVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.

#import "MineLoginVC.h"
#import "MGTextField.h"

#import "RegistVC.h"

@interface MineLoginVC ()
@property (weak, nonatomic) IBOutlet MGTextField *loginTextField;
@property (weak, nonatomic) IBOutlet MGTextField *pwdTextField;
// 主面板
@property (weak, nonatomic) IBOutlet UIView *mainPanel;
// 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewTopLayout;

@end

@implementation MineLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainViewTopLayout.constant = IS_IPHONE4 ? 74 : 174;
    
    // 设置输入框左边的图片
    self.loginTextField.leftIcon = @"icon_people";
    self.pwdTextField.leftIcon = @"icon_password";
    
    // 设置主面板的圆角
    self.mainPanel.layer.cornerRadius = 5;
    self.mainPanel.clipsToBounds = YES;
    // 设置登录按钮的圆角
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  点击是否自动登录
 *
 *  @param button 按钮
 */
- (IBAction)autoLoginClick:(UIButton *)button {
    button.selected = !button.isSelected;
}

/**
 *  登录
 */
- (IBAction)loginClick:(id)sender {
    if (_loginTextField.text == nil || _loginTextField.text.length == 0 || _pwdTextField.text == nil || _pwdTextField.text.length == 0) {
        MGPE(@"你输入的账号/密码有误");
        return;
    }
    
    [MBProgressHUD showMessage:@"明哥正在帮你登录"];
    if ([_loginTextField.text  isEqual:@"ming"] && [_pwdTextField.text  isEqual:@"234567"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [MBProgressHUD hideHUD];
            // 成功登陆的 通知
            [MGNotificationCenter postNotificationName:MGLoginSuccessNotification object:nil];
        }];
    }
}

/**
 *  注册
 */
- (IBAction)registClick:(UIButton *)sender {
    [self.navigationController pushViewController:[[RegistVC alloc] init] animated:YES];
}


/**
 *  dismiss
 */
- (IBAction)closeClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
