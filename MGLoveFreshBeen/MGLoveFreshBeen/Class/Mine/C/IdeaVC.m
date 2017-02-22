//
//  IdeaVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "IdeaVC.h"
#import <objc/runtime.h>
//#import "LYMTextViewWithLabel.h"

@interface IdeaVC ()<UITextViewDelegate>
/** 意见输入框 */
//@property (nonatomic,weak) LYMTextViewWithLabel *iderTextView;
@property (nonatomic,weak) UITextView *iderTextView;
@end

@implementation IdeaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    self.view.backgroundColor = MGRGBColor(230, 230, 230);
    
    
    // 0.通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
//        NSLog(@"%d : %@",i,objcName);
    }

    
    // 1.导航栏右边发布按钮
    [self  setUpRightItemButton];
    
    // 2.setUpUI
    [self setUpMainView];
}

// 右边按钮
- (void)setUpMainView{
        // 提示文字
        CGFloat margin  = 15;
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, MGSCREEN_width - 2 * margin, 50)];
        tipLabel.text = @"你的批评和建议能帮助我们更好的完善产品,请留下你的宝贵意见!";
        tipLabel.numberOfLines = 2;
        tipLabel.textColor = MGRGBColor(255, 10, 10);
        tipLabel.font = MGFont(16);
        [self.view addSubview:tipLabel];
        // 意见输入框
        CGFloat height  = 200;
#ifndef __IPHONE_4_0
        height = 100;
#endif

    UITextView *iderTextView = [[UITextView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(tipLabel.frame) + margin, MGSCREEN_width - 2 * margin, height)];
    iderTextView.backgroundColor = [UIColor whiteColor];
    iderTextView.layer.shadowRadius = 5;
    iderTextView.layer.shadowColor = [UIColor yellowColor].CGColor;
    iderTextView.layer.cornerRadius = 3;
    iderTextView.layer.borderWidth = 1;
    iderTextView.layer.borderColor = [UIColor grayColor].CGColor;
    iderTextView.scrollEnabled = YES;
    iderTextView.scrollsToTop = YES;
    iderTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    iderTextView.delegate = self;
    self.iderTextView = iderTextView;
    [self.view addSubview:iderTextView];
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入宝贵意见(300字以内)";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.font = [UIFont systemFontOfSize:16];
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [iderTextView addSubview:placeHolderLabel];
    
    [iderTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    iderTextView.font =  placeHolderLabel.font;
    
    UIButton *sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(margin, CGRectGetMaxY(iderTextView.frame) + margin, MGSCREEN_width - 2 * margin, 35);
    sendBtn.backgroundColor = [UIColor redColor];
    [sendBtn setTitle:@"发送意见" forState:UIControlStateNormal];
    [sendBtn setTintColor:[UIColor whiteColor]];
    sendBtn.layer.cornerRadius = 17;
    [sendBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

#pragma mark - 私有方法
// 右边按钮
- (void)setUpRightItemButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

- (void)rightItemClick {
    if (_iderTextView.text == nil ||  _iderTextView.text.length < 0.0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"v2_orderSuccess"] status:@"请输入意见,心里空空的"];
    } else if (_iderTextView.text.length < 5) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"v2_orderSuccess"] status:@"亲,你输入的太少啦，请输入超过5个字啊~"];
    } else if (_iderTextView.text.length >= 300) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"v2_orderSuccess"] status:@"妹子,说的太多了,👀看不完啊~"];
    } else {
        MGPE(@"发送中");
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (1.0 * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendIdeaSussessNotification" object:self];
        });

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}







#pragma mark - UITextViewDelegate
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    if([textView.text isEqualToString:@" 请输入详细描述"]){
//        textView.text=@"";
//        textView.textColor= [UIColor grayColor];
//    }
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView{
//    
//    if(textView.text.length == 0 && self.iderTextView ){
//        
//        textView.text=@" 请输入详细描述";
//        textView.textColor = [UIColor blackColor];
//    }
//}


@end
