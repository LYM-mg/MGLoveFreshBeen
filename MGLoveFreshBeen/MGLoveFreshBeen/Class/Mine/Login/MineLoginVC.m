//
//  MineLoginVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.

#import "MineLoginVC.h"
#import "MGTextField.h"

#import "RegistVC.h"
#import "ForgetPasswordVC.h"

#import "UMSocial.h"

@interface MineLoginVC ()<UITextFieldDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet MGTextField *loginTextField;
@property (weak, nonatomic) IBOutlet MGTextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *rememberPwdBtn; // 记住密码

// 主面板
@property (weak, nonatomic) IBOutlet UIView *mainPanel;
// 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewTopLayout;

@end

@implementation MineLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainViewTopLayout.constant = IS_IPHONE4 ? 20 : MGSCREEN_height*0.18;
    
    // 设置输入框左边的图片
    self.loginTextField.leftIcon = @"icon_people";
    self.pwdTextField.leftIcon = @"icon_password";
    self.pwdTextField.delegate = self;
    
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
- (IBAction)autoLoginClick:(UIButton *)rememberPwdBtn {
    rememberPwdBtn.selected = !rememberPwdBtn.isSelected;
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
            // 成功登录的 通知
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
 *  忘记密码
 */
- (IBAction)forgetPasswordClick:(UIButton *)sender {
    [self.navigationController pushViewController:[[ForgetPasswordVC alloc] init] animated:YES];
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

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.pwdTextField]) {
        self.mainViewTopLayout.constant = IS_IPHONE4 ? -80 : MGMargin * 1.5;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.pwdTextField]) {
        if (IS_IPHONE4){
            self.mainViewTopLayout.constant = IS_IPHONE4 ? 20 : MGSCREEN_height*0.18;
        }
    }
}

#pragma mark - 第三方 社交账号登录
// QQ
- (IBAction)socialQQLoginClick:(UIButton *)sender {
    [self loginWithSocialPlatformWithName:UMShareToQQ];
}

// 新浪微博
- (IBAction)socialSinaLoginClick:(UIButton *)sender {
    [self loginWithSocialPlatformWithName:UMShareToSina];
}

// 微信
- (IBAction)socialWeChatLoginClick:(UIButton *)sender {
    [self loginWithSocialPlatformWithName:UMShareToWechatSession];
}

- (void)loginWithSocialPlatformWithName:(NSString *)socialPlatformWithName{
    // 获取不同的平台名称
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:socialPlatformWithName];

    // 授权
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        /**
         *  这里获取到用户的信息   并保存登录（一般有一个专门保存userInfo的工具类）
         *
         *  @param 如果项目一进来就是登录界面的，就在这里跳转到首页
         *
         */
        //  获取用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            MGLog(@"%@",dict);
        }});
}

#pragma mark - UMSocialUIDelegate



@end
