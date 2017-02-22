//
//  MineHeadView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MineHeadView.h"

@interface MineHeadView ()

@property (nonatomic,weak) UIButton *setUpBtn;
@end

#pragma mark - MineHeadView

@implementation MineHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame setUpButtonClick:(void (^)())setUpButtonClickBlock{
    if (self = [super init]) {
        self.setUpButtonClickBlock = setUpButtonClickBlock;
    }
    return self;
}

#pragma mark - 私有方法
#pragma mark - setUpUI
- (void)setUpUI{
    self.image = [UIImage imageNamed:@"v2_my_avatar_bg"];
    
    UIButton *setUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setUpBtn setImage:[UIImage imageNamed:@"v2_my_settings_icon"] forState:UIControlStateNormal];
    [setUpBtn addTarget:self action:@selector(setUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setUpBtn];
    self.userInteractionEnabled = true;
    self.setUpBtn = setUpBtn;
    
    IconView *iconView = [[IconView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
}

- (void)setUpButtonClick{
    if (_setUpButtonClickBlock) {
        self.setUpButtonClickBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iconViewWH = 150;
    self.iconView.frame = CGRectMake((self.width - iconViewWH) * 0.5, 30, iconViewWH, iconViewWH);
    
    self.setUpBtn.frame = CGRectMake(self.width - 50, 10, 50, 50);
}

@end

#pragma mark -
#pragma mark - IconView

@implementation IconView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法
#pragma mark - setUpUI
- (void)setUpUI{
    UIImageView *icon  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_my_avatar"]];
    icon.userInteractionEnabled = YES;
    self.iconImageView = icon;
    [self addSubview:_iconImageView];
    
    UILabel *phone = [[UILabel alloc] init];
    [self addSubview:phone];
    self.phoneNum = phone;
    _phoneNum.text = @"1375055922";
    _phoneNum.font = [UIFont boldSystemFontOfSize:18];
    _phoneNum.textColor = [UIColor whiteColor];
    _phoneNum.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _iconImageView.frame = CGRectMake((self.width - _iconImageView.width) * 0.5, 0, _iconImageView.size.width, _iconImageView.size.height);
    _phoneNum.frame = CGRectMake(0, CGRectGetMaxY(_iconImageView.frame) + 5, self.width, 30);
    
    _iconImageView.layer.cornerRadius = _iconImageView.size.width * 0.5;
    _iconImageView.layer.masksToBounds = YES;
}

@end
