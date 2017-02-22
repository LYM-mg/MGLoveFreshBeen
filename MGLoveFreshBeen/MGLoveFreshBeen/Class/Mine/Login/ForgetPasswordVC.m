//
//  ForgetPasswordVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "ReSetPasswordVC.h"

@interface ForgetPasswordVC ()<UITextFieldDelegate>
{
    UITextField *_phoneTextField;
    UITextField *_yzmTextFiled;
    UIButton *receiveBtn;//获取验证码
    NSInteger seconds;//倒计时秒数
    NSTimer *timer; // 定时器
}
@end

@implementation ForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    seconds=60;
    [self setMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - view layout
// 布局
- (void)setMainView{
    float topPading = IS_IPHONE4 ? 164/2-45 : 164/2;
    // 1.背景图片
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImage.image = [UIImage imageNamed:@"login_register_background"];
    [self.view addSubview:backgroundImage];
    
    // 2.手机号
    _phoneTextField = [[UITextField alloc] initWithFrame:(CGRectMake(106/2, topPading, MGSCREEN_width-106, 30))];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.delegate = self;
    _phoneTextField.font = MGFont(15);
    _phoneTextField.placeholder = @"手机号";
    _phoneTextField.textColor = [UIColor whiteColor];
    [_phoneTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTextField.clearButtonMode=UITextFieldViewModeAlways;
    _phoneTextField.tintColor = [UIColor whiteColor];
    [self.view addSubview:_phoneTextField];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, _phoneTextField.height-0.5,_phoneTextField.width, 0.5f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [_phoneTextField.layer addSublayer:bottomBorder];

    // 3.验证码输入框
    _yzmTextFiled=[[UITextField alloc] initWithFrame:(CGRectMake(106/2,_phoneTextField.y+50, (MGSCREEN_width-106-210/2), 30))];
    _yzmTextFiled.delegate = self;
    _yzmTextFiled.placeholder = @"验证码";
    _yzmTextFiled.font = MGFont(15);
    _yzmTextFiled.textColor = [UIColor whiteColor];
    _yzmTextFiled.keyboardType = _phoneTextField.keyboardType;
    _yzmTextFiled.tintColor = [UIColor whiteColor];
    [_yzmTextFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_yzmTextFiled];
    CALayer *codeBottomBorder = [CALayer layer];
    codeBottomBorder.frame = CGRectMake(0, _yzmTextFiled.height-0.5,_yzmTextFiled.width, 0.5f);
    codeBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [_yzmTextFiled.layer addSublayer:codeBottomBorder];
    
    // 4.获取验证码
    receiveBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    receiveBtn.frame=CGRectMake(MGSCREEN_width-106/2-210/2, CGRectGetMaxY(_phoneTextField.frame)-0.5, 210/2, 51);
    [receiveBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [receiveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    receiveBtn.titleLabel.font = MGFont(15);
    [receiveBtn addTarget:self action:@selector(getCode:) forControlEvents:(UIControlEventTouchUpInside)];
    [receiveBtn setBackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:receiveBtn];
    
    // 5.下一步
    UIButton *nextBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    nextBtn.frame=CGRectMake(_phoneTextField.x,CGRectGetMaxY(_yzmTextFiled.frame)+45,_phoneTextField.width, 40);
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [nextBtn setBackgroundColor:[UIColor magentaColor]];
    nextBtn.titleLabel.font = MGFont(16);
    [nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:nextBtn];
    
    // 6.注册协议
    UIButton *protocloBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    protocloBtn.frame=CGRectMake(0, MGSCREEN_height-64-76/2, MGSCREEN_width, 76/2);
    [protocloBtn setBackgroundColor:MGNavBarTiniColor];
    [protocloBtn addTarget:self action:@selector(protocolBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [protocloBtn setTitle:@"注册即视为同意爱鲜蜂平台服务协议" forState:(UIControlStateNormal)];
    [protocloBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    protocloBtn.titleLabel.font = MGFont(12);
    [self.view addSubview:protocloBtn];
    UIView *line=[[UIView alloc] initWithFrame:(CGRectMake(MGSCREEN_width/2-36, protocloBtn.frame.origin.y+56/2, 11*12, 0.5f))];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
}

#pragma  mark - event response
//确认用户注册协议
- (void)protocolBtnClicked:(UIButton *)sender{
    MGPS(@"注册协议");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jianshu.com/users/57b58a39b70e/latest_articles"]];
}

//获取验证码
- (void)getCode:(UIButton *)sender{
    [self.view endEditing:YES];
    
    if([_phoneTextField.text length] != 11){
        MGPE(@"请输入11位手机号码");
        return;
    }
    
    // 判断是否是正确的手机号!
    if (![self validateMoblie:_phoneTextField.text]) {
        MGPE(@"请输入正确的11位手机号码");
        return;
    }
    
    // 短信
    [self sendVerificationByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneTextField.text];
}
- (void)sendVerificationByMethod:(SMSGetCodeMethod)method phoneNumber:(NSString *)phoneNumber{
    // 必须要输入正确的手机号码才能来到下面的代码
    [SMSSDK getVerificationCodeByMethod:method phoneNumber:phoneNumber zone:@"86" customIdentifier:nil result:^(NSError *error) {
        receiveBtn.userInteractionEnabled = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
        
        if (error != nil) { //有错误
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码发送失败" message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"getVerificationCode"]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码发送成功"  message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
}
/**
 *  正则表达式 判断是否是手机号码
 *
 *  @param sender 返回bool
 */
- (BOOL)validateMoblie:(NSString *)mobile{
    // 手机号以13，15，18开头，9个\d数字字符 (15[^4,\\D])
    NSString *phoneRegex = @"^((13[0-9])|(15[0-3,5-9])|(18[0,0-9])|(17[0-3,5-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
}

/**
 *  倒计时
 *
 *  @param sender timer
 */
- (void)onTimer:(NSTimer *)sender{
    seconds -= 1;
    if(seconds == 0){
        receiveBtn.userInteractionEnabled = YES;
        [receiveBtn  setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        seconds = 60;
        timer = nil;
    }else{
        [receiveBtn setTitle:[NSString stringWithFormat:@"已发送(%ld)",seconds] forState:(UIControlStateNormal)];
    }
}

//下一步
- (void)nextBtnClick:(UIButton *)sender{
    [self.view endEditing:YES];

    if(_yzmTextFiled.text != nil && _yzmTextFiled.text.length == 4){
        ReSetPasswordVC *resetPwdVC = [[ReSetPasswordVC alloc] initWithPhoneText:_phoneTextField.text WithVCTitle:@"修改密码"];
        [self.navigationController pushViewController:resetPwdVC animated:YES];
    }else{
        MGPE(@"请输入正确的验证码");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"]||[string isEqualToString:@" "]){
        return NO;
    }
    return YES;
}



@end
