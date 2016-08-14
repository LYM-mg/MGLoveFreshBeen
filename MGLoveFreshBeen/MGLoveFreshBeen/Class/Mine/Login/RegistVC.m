//
//  RegistVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/14.
//  Copyright © 2016年 ming. All rights reserved.
// login_register_background

#import "RegistVC.h"
//#import "UITextField+placeholderColor.h"

@interface RegistVC ()<UITextFieldDelegate>
{
    UIButton *receiveBtn;//获取验证码
    NSInteger seconds;//倒计时秒数
    NSString *codeString;//验证码字符串
    BOOL flag;
}

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     seconds=60;
    [self setUpMainView];
}

#pragma mark - view layout
/**
 *  布局
 */
- (void)setUpMainView {
    
    float topPading=IS_IPHONE4?164/2-45:164/2;
    // 1.背景图片
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImage.image = [UIImage imageNamed:@"login_register_background"];
    [self.view addSubview:backgroundImage];
    
    
    NSArray *arr=@[@"请输入手机号",@"设置密码(6-12位)",@"再次输入密码",@"验证码"];
    for (int i=0; i<4; i++) {
        UITextField *textFiled=[[UITextField alloc] initWithFrame:(CGRectMake(106/2, topPading+50*i, MGSCREEN_width-106, 30))];
        if(i==0||i==3)
            textFiled.keyboardType=UIKeyboardTypeNumberPad;
        else
            textFiled.secureTextEntry=YES;
        textFiled.delegate = self;
        textFiled.font=MGFont(15);
        textFiled.returnKeyType=UIReturnKeyDone;
        textFiled.placeholder = arr[i];
        textFiled.textColor = [UIColor whiteColor];
        textFiled.tintColor = [UIColor whiteColor];
        [textFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        if(i != 3)
            textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFiled.tag = 101+i;
        [self.view addSubview:textFiled];
        
        if(i == 3)
            textFiled.width = MGSCREEN_width-106-105;
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0, textFiled.height-0.5,textFiled.width, 0.5f);
        bottomBorder.backgroundColor = [UIColor grayColor] .CGColor;
        [textFiled.layer addSublayer:bottomBorder];
        
        if(i!=3){
            UIButton *clearBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
            clearBtn.frame=CGRectMake(CGRectGetMaxX(textFiled.frame)-30, textFiled.y, 30, 30);
            [clearBtn setImage:[UIImage imageNamed:@"icon_clear"] forState:(UIControlStateNormal)];
            clearBtn.imageView.contentMode = UIViewContentModeCenter;
            [clearBtn addTarget:self action:@selector(clearBtnHandled:) forControlEvents:(UIControlEventTouchUpInside)];
            clearBtn.tag=201+i;
            [self.view addSubview:clearBtn];
            
        }
        if(i ==2 ){
            //    获取验证码
            receiveBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
            receiveBtn.frame=CGRectMake(MGSCREEN_width-106/2-210/2,CGRectGetMaxY(textFiled.frame)-0.5, 210/2, 51);
            [receiveBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
            [receiveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            receiveBtn.titleLabel.font=MGFont(15);
            [receiveBtn addTarget:self action:@selector(getCode:) forControlEvents:(UIControlEventTouchUpInside)];
            [receiveBtn setBackgroundColor:MGNavBarTiniColor];
            [self.view addSubview:receiveBtn];
        }
    }
    
    
    
    //    新注册确认
    UIButton *loginBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    loginBtn.frame=CGRectMake(106/2,614/2 , MGSCREEN_width-106, 40);
    [loginBtn addTarget:self action:@selector(registerBtnHandled:) forControlEvents:(UIControlEventTouchUpInside)];
    [loginBtn setBackgroundColor:MGNavBarTiniColor];
    loginBtn.titleLabel.font = MGFont(16);
    [loginBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginBtn addTarget:self action:@selector(btnTouchDown:) forControlEvents:(UIControlEventTouchDown)];
    [self.view addSubview:loginBtn];
    if(IS_IPHONE4)
        loginBtn.y=614/2-50;
    
    
    //    注册协议
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
/**
 *  注册按钮按下改变背景
 */
- (void)btnTouchDown:(UIButton *)sender{
    sender.backgroundColor=[UIColor clearColor];
    sender.layer.borderWidth = 0.5;
    sender.layer.borderColor = MGNavBarTiniColor.CGColor;
}
//确认用户注册协议
- (void)protocolBtnClicked:(UIButton *)sender{
    MGPS(@"注册协议");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jianshu.com/users/57b58a39b70e/latest_articles"]];
}

//获取验证码
- (void)getCode:(UIButton *)sender{
    [self.view endEditing:YES];
    UITextField *phoneTextField = (UITextField *)[self.view viewWithTag:101];
    
    if([phoneTextField.text length] == 11){
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
            NSLog(@"code:%ld,domain:%@,userInfo:%@",(long)error.code,error.domain,error.userInfo);
            sender.userInteractionEnabled=NO;
            if (error == nil) {
                sender.userInteractionEnabled=YES;
//                codeString = 
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码发送成功"  message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }else {//有错误
                sender.userInteractionEnabled=YES;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码发送失败" message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"getVerificationCode"]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            };
        }];
    }else{
        MGPE(@"请输入11位手机号码");
    }
}
- (void)onTimer:(NSTimer *)sender{
    seconds -= 1;
    if(seconds == 0){
        receiveBtn.userInteractionEnabled=YES;
        [receiveBtn  setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        seconds=60;
        [sender invalidate];
    }else{
        [receiveBtn setTitle:[NSString stringWithFormat:@"已发送(%li)",seconds] forState:(UIControlStateNormal)];
    }
}
//注册完成
- (void)registerBtnHandled:(UIButton *)sender{
    [self.view endEditing:YES];
    UITextField *ptf=(UITextField *)[self.view viewWithTag:101];
    UITextField *pwtf=(UITextField *)[self.view viewWithTag:102];
    UITextField *rpw=(UITextField *)[self.view viewWithTag:103];
    UITextField *codetf=(UITextField *)[self.view viewWithTag:104];
    if([ptf.text length]==11){
        
        if([pwtf.text length]>=6&&pwtf.text.length<=12){
            
            if([pwtf.text isEqualToString:rpw.text]){
                
//                if([codetf.text isEqualToString:codeString]){
                    if(flag==NO){
                        sender.userInteractionEnabled = NO;
                        [SMSSDK commitVerificationCode:codetf.text phoneNumber:ptf.text zone:@"86" result:^(NSError *error) {
                            NSLog(@"code:%ld,domain:%@,userInfo:%@",(long)error.code,error.domain,error.userInfo);
                            
                            if (error == nil) {
                                MGPS(@"注册成功");
                                [self.navigationController popViewControllerAnimated:YES];
                                
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证成功"
                                                                                    message:nil
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"确定"
                                                                          otherButtonTitles:nil, nil];
                                [alertView show];
                            }else {//有错误
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证失败"
                                                                                    message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"commitVerificationCode"]]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"确定"
                                                                          otherButtonTitles:nil, nil];
                                [alertView show];
                            }
                        }];
                        sender.userInteractionEnabled = YES;
                    }else
                        MGPE(@"请您先同意注册协议");
//                }else{
//                    MGPE(@"请输入正确的验证码");
//                }
                
            }else{
                
                MGPE(@"两次密码输入不一致");
            }
        }else{
            
            MGPE(@"密码长度为6-12位");
        }
    }else{
        
        MGPE(@"请输入11位手机号码");
    }
    sender.backgroundColor = MGNavBarTiniColor;
}

-(void)clearBtnHandled:(UIButton *)sender{
    
    for(UIView *view in self.view.subviews){
        
        if(view.tag>100&&view.tag<200){
            
            if(view.tag==sender.tag-100){
                
                UITextField *tf=(UITextField *)view;
                tf.text=@"";
            }
        }
    }
}
#pragma mark - custom delegates
#pragma - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]||[string isEqualToString:@" "]){
        
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if(textField.tag==104){
        if(IS_IPHONE4||IS_IPhone5){
            [UIView animateWithDuration:0.2 animations:^{
                self.view.frame=CGRectMake(0, -60, MGSCREEN_width, MGSCREEN_height-64);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField .tag==104){
        if(IS_IPHONE4||IS_IPhone5){
            [UIView animateWithDuration:0.2 animations:^{
                self.view.frame=CGRectMake(0, 64,  MGSCREEN_width, MGSCREEN_height-64);
            } completion:nil];
        }
    }
    if(textField.tag==101){
        if( [textField.text length]!=11)
            MGPE(@"请输入11位手机号码");
    }
    
}


@end