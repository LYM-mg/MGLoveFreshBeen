//
//  HomeCollectionHeaderView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeCollectionHeaderView.h"

@interface HomeCollectionHeaderView ()

@end


@implementation HomeCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _sectionHTitleLabel.frame = CGRectMake(0, self.height - 30, MGSCREEN_width, 30);
}

// 私有方法
- (void)setupUI{
    self.backgroundColor = [UIColor grayColor];
    UILabel *lb = [[UILabel alloc] init];
    lb.textColor = MGProductBackGray;
    [self addSubview:lb];
    _sectionHTitleLabel = lb;
}

@end




#pragma mark -
#pragma amrk - HomeCollectionFooterView

//@implementation HomeCollectionFooterView
//
//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
//    }
//    return self;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self setupUI];
//    }
//    return self;
//}
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    _lookMoreBtn.frame = CGRectMake(0, 0, MGSCREEN_width, self.height);
//}
//
//// 私有方法
//- (void)setupUI{
//    self.backgroundColor = [UIColor grayColor];
//    
//    UIButton *btn = [[UIButton alloc] init];
//    [btn setTintColor:MGProductBackGray];
//    [self addSubview:btn];
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [btn addTarget:self action:@selector(lookMoreBtnClick:With:) forControlEvents:UIControlEventTouchUpInside];
//    _lookMoreBtn = btn;
//}
//
//// 监听点击
//- (void)lookMoreBtnClick:(UIButton *)btn With:(NSString *)title{
//    
//}
//
//
//@end