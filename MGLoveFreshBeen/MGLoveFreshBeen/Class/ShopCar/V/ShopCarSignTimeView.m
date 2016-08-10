//
//  ShopCarSignTimeView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShopCarSignTimeView.h"

@interface ShopCarSignTimeView ()
/** 时间选择器 */
@property (nonatomic,strong) UIDatePicker *timePicker;
/** 时间 */
@property (nonatomic,copy) NSString *timeStr;
@end

@implementation ShopCarSignTimeView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法
/**
 *  创建UI
 */
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    // 点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTimeClick:)];
    [self addGestureRecognizer:tap];
    
    UILabel *signTimeTitleLabel = [UILabel new];
    signTimeTitleLabel.text = @"收货时间";
    signTimeTitleLabel.textColor = [UIColor blackColor];
    signTimeTitleLabel.font = MGFont(15);
    [signTimeTitleLabel sizeToFit];
    signTimeTitleLabel.frame = CGRectMake(15, 0, signTimeTitleLabel.width, MGShopCartRowHeight);
    [self addSubview:signTimeTitleLabel];
    
    UITextField *signTimeField = [[UITextField alloc] init];
    signTimeField.frame = CGRectMake(CGRectGetMaxX(signTimeTitleLabel.frame) + 10, 0, MGSCREEN_width * 0.5, MGShopCartRowHeight);
    signTimeField.textColor = [UIColor redColor];
    signTimeField.font = MGFont(15);
    signTimeField.placeholder = @"闪电送,及时达";
    [signTimeField setValue:[UIColor orangeColor] forKeyPath:@"placeholderLabel.textColor"];
    [self addSubview:signTimeField];
    _signTimeField = signTimeField;
    signTimeField.inputView = self.timePicker;
    // 创建附加键盘的确定取消按钮
    signTimeField.inputAccessoryView = [self buildInputView];
    
    
    UILabel *reserveLabel = [UILabel new];
    reserveLabel.text = @"可预定";
    reserveLabel.backgroundColor = [UIColor whiteColor];
    reserveLabel.textColor =  [UIColor redColor];
    reserveLabel.font = MGFont(15);
    reserveLabel.frame = CGRectMake(self.width - 72, 0, 60, MGShopCartRowHeight);
    [self addSubview:reserveLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"icon_go"]];
    arrowImageView.frame = CGRectMake(self.width - 15, (MGShopCartRowHeight - arrowImageView.height) * 0.5, arrowImageView.width, arrowImageView.height);
    [self addSubview:arrowImageView];
    
    [self addSubview:[self lineView:CGRectMake(0, MGShopCartRowHeight - 0.5, MGSCREEN_width, 0.5)]];
}

- (UIView *)lineView:(CGRect)frame {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}



#pragma mark - 日期选择
- (UIView *)buildInputView  {
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, 40)];
    toolBar.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MGSCREEN_width, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.2;
    [toolBar addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = MGFont(15);
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.alpha = 0.8;
    titleLabel.text = @"选择时间";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 0, MGSCREEN_width, toolBar.height);
    [toolBar addSubview:titleLabel];
    
    UIButton *cancleButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, toolBar.height)];
    cancleButton.tag = 12;
    [cancleButton addTarget:self action:@selector(selectedCityTextFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setTitle:@"取消"  forState: UIControlStateNormal];
    [cancleButton setTitleColor:MGRGBColor(88, 233, 168) forState:UIControlStateNormal];
    [toolBar addSubview:cancleButton];
    
    UIButton *determineButton = [[UIButton alloc] initWithFrame:CGRectMake(MGSCREEN_width - 80, 0, 80, toolBar.height)];
    determineButton.tag = 13;
    [determineButton addTarget:self action:@selector(selectedCityTextFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [determineButton setTitle:@"确定"  forState: UIControlStateNormal];
    [determineButton setTitleColor:MGRGBColor(82, 203, 238) forState:UIControlStateNormal];
    [toolBar addSubview:determineButton];
    
    return toolBar;
}

- (void)selectedCityTextFieldDidChange:(UIButton *)sender{
    if (sender.tag == 13) {
        self.signTimeField.text = self.timeStr;
    }
    [self endEditing:YES];
}

- (UIDatePicker *)timePicker{
    if (!_timePicker) {
        _timePicker = [[UIDatePicker alloc] init];
        _timePicker.datePickerMode = UIDatePickerModeDateAndTime;// @"h:mm a";
        [_timePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    }
    return _timePicker;
}
/**
 *  修改收货时间
 */
- (void)changeDate:(UIDatePicker *)datePick{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd hh:mm a";
    self.timeStr = [formatter stringFromDate:datePick.date];
    MGLog(@"%@",_timeStr);
}

/**
 *  手势点击
 */
- (void)changeTimeClick:(UITapGestureRecognizer *)tap {
    [self.signTimeField becomeFirstResponder];
}

@end
