//
//  ReSetPasswordVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ReSetPasswordVC.h"

@interface ReSetPasswordVC ()<UITextFieldDelegate>
{
    UITextField *_pwTextFiled;
    UITextField *_repwTextFiled;
}

@end

@implementation ReSetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Navigation
- (instancetype)initWithPhoneText:(NSString *)phoneText WithVCTitle:(NSString *)title{
    if (self = [super initWithNibName:nil bundle:nil]) {
        
    }
    return self;
}


#pragma mark - view layout
// 布局
- (void)setMainView{
    float topPading = IS_IPHONE4 ? 164/2-45 : 164/2;
    // 1.背景图片
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImage.image = [UIImage imageNamed:@"login_register_background"];
    [self.view addSubview:backgroundImage];
    
    // 2.密码输入框
    _pwTextFiled = [[UITextField alloc] initWithFrame:(CGRectMake(106/2, topPading, MGSCREEN_width-106, 30))];
    _pwTextFiled.returnKeyType = UIReturnKeyDone;
    _pwTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _pwTextFiled.secureTextEntry=YES;
    _pwTextFiled.delegate = self;
    _pwTextFiled.font = MGFont(15);
    _pwTextFiled.placeholder = @"请输入新密码";
    _pwTextFiled.textColor = [UIColor whiteColor];
    [_pwTextFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _pwTextFiled.clearButtonMode=UITextFieldViewModeAlways;
    _pwTextFiled.tintColor = [UIColor whiteColor];
    [self.view addSubview:_pwTextFiled];

    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, _pwTextFiled.height-0.5,_pwTextFiled.width, 0.5f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [_pwTextFiled.layer addSublayer:bottomBorder];
    
    
    // 3.确认输入框
    _repwTextFiled=[[UITextField alloc] initWithFrame:(CGRectMake(106/2, CGRectGetMaxY(_pwTextFiled.frame)+20, MGSCREEN_width-106, 30))];
    _repwTextFiled.delegate=self;
    _repwTextFiled.font=_pwTextFiled.font;
    _repwTextFiled.returnKeyType = UIReturnKeyDone;
    _repwTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _repwTextFiled.secureTextEntry = YES;
    _repwTextFiled.placeholder = @"再次输入密码";
    _repwTextFiled.textColor = [UIColor whiteColor];
    [_repwTextFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _repwTextFiled.clearButtonMode=UITextFieldViewModeAlways;
    _repwTextFiled.tintColor = [UIColor whiteColor];
    [self.view addSubview:_repwTextFiled];
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0, _repwTextFiled.height-0.5,_repwTextFiled.width, 0.5f);
    bottomBorder2.backgroundColor = [UIColor grayColor].CGColor;
    [_repwTextFiled.layer addSublayer:bottomBorder2];
    
    
    // 4.提交
    UIButton *modifiedBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    modifiedBtn.frame=CGRectMake(_pwTextFiled.x,CGRectGetMaxY(_repwTextFiled.frame)+45,_repwTextFiled.width, 40);
    [modifiedBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [modifiedBtn setBackgroundColor:[UIColor magentaColor]];
    modifiedBtn.layer.borderWidth = 0.5;
    modifiedBtn.layer.borderColor = MGNavBarTiniColor.CGColor;
    modifiedBtn.titleLabel.font= MGFont(16);
    [modifiedBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [modifiedBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:modifiedBtn];
    
    
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

#pragma mark - custom delegates
#pragma mark - event response
/**
 *  查看注册协议
 *
 *  @param sender btn
 */
- (void)protocolBtnClicked:(UIButton *)sender{
    MGPS(@"注册协议");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jianshu.com/users/57b58a39b70e/latest_articles"]];
}


- (void)commitBtnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    if(([_pwTextFiled.text length] < 6) && (_pwTextFiled.text.length > 12)){
        MGPE(@"密码长度为6-12位");
    }
    
    
    if([_pwTextFiled.text isEqualToString:_repwTextFiled.text]){
        sender.userInteractionEnabled = NO;
        MGPS(@"密码修改成功！");
        // 后台接口 修改
        
    }else{
        MGPE(@"两次密码输入不一致");
    }
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    // 有表情符号
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"]||[string isEqualToString:@" "]){
        return NO;
    }
    return YES;
}

@end
