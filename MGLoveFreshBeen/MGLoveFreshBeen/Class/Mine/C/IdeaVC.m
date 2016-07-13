//
//  IdeaVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "IdeaVC.h"
#import "LYMTextViewWithLabel.h"

@interface IdeaVC ()
/** 意见输入框 */
@property (nonatomic,weak) LYMTextViewWithLabel *iderTextView;
@end

@implementation IdeaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    self.view.backgroundColor = MGRGBColor(230, 230, 230);
    
    // 1.导航栏右边发布按钮
    [self  setUpRightItemButton];
    
    // 2.setUpUI
    [self setUpMainView];
}

// 右边按钮
- (void)setUpMainView{
    // 提示文字
    CGFloat margin  = 15;
    
    CGFloat y = self.navigationController ? MGNavHeight + 10 : 20;
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, y, MGSCREEN_width - 2 * margin, 50)];
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
    LYMTextViewWithLabel *iderTextView = [[LYMTextViewWithLabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(tipLabel.frame) + margin, MGSCREEN_width - 2 * margin, height)];
    iderTextView.backgroundColor = MGRGBColor(21, 221, 43);
    iderTextView.placeholder = @"请输入宝贵意见(300字以内)";
    iderTextView.placeholderColor = MGRandomColor;
    [self.view addSubview:iderTextView];
    [iderTextView becomeFirstResponder];
    self.iderTextView.scrollEnabled = YES;
    self.iderTextView.scrollsToTop = YES;
    self.iderTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.iderTextView = iderTextView;
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


@end
