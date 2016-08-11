//
//  HotSearchView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/11.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HotSearchView.h"

@interface HotSearchView ()

/** 回调  */
@property (nonatomic,copy) void (^searchButtonClickCallback)(UIButton *sender);
/** searchLabel */
@property (nonatomic,weak) UILabel *searchTitleLabel;

@end


@implementation HotSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.searchTitleLabel.frame = CGRectMake(MGMargin, 0, MGSCREEN_width - 30, 35);
}

#pragma mark - 私有方法
/**
 *  创建UI
 */
- (void)setUpUI{
    UILabel *searchTitleLabel = [[UILabel alloc] init];
    searchTitleLabel.frame = CGRectMake(MGMargin, 0, self.width - 30, 35);
    searchTitleLabel.font = MGFont(15);
    searchTitleLabel.textAlignment = NSTextAlignmentLeft;
    searchTitleLabel.textColor = MGRGBColor(140, 140, 140);
    [self addSubview:searchTitleLabel];
    _searchTitleLabel = searchTitleLabel;

}

/**
 *  便利构造方法
 *
 *  @param frame                     尺寸
 *  @param searchTitleText           标题文字
 *  @param searchButtonTitleTexts    按钮文字
 *  @param searchButtonClickCallback 按钮回调
 *
 *  @return HotSearchView
 */
- (instancetype)initWithFrame:(CGRect)frame searchTitleText:(NSString *)searchTitleText searchButtonTitleTexts:(NSArray *)searchButtonTitleTexts searchButton:(void(^)(UIButton *sender))searchButtonClickCallback{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        
        self.searchTitleLabel.text = searchTitleText;
        
        CGFloat btnW = 0;
        CGFloat btnH  = 30;
        CGFloat addW  = 30;
        CGFloat marginX  = MGMargin;
        CGFloat marginY  = MGMargin;
        CGFloat lastX = MGMargin;
        CGFloat lastY = 35;
        
        NSInteger count = searchButtonTitleTexts.count;
        for (int i = 0; i < count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            [btn setTitle:searchButtonTitleTexts[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font = MGFont(14);
            [btn.titleLabel sizeToFit];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 15;
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = MGRGBColor(200, 200, 200).CGColor;
            [btn addTarget:self action:@selector(hotSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btnW = btn.titleLabel.width + addW;
            
            if (frame.size.width - lastX > btnW) {
                btn.frame = CGRectMake(lastX, lastY, btnW, btnH);
            } else {
                btn.frame = CGRectMake(marginX, lastY + marginY + btnH, btnW, btnH);
            }
            
            lastX = CGRectGetMaxX(btn.frame) + marginX;
            lastY = btn.y;
            
            self.searchHeight = CGRectGetMaxY(btn.frame) + MGSmallMargin;
            
            [self addSubview:btn];
        }
        
        self.searchButtonClickCallback = searchButtonClickCallback;
    }
    return self;
}

/**
 *  监听按钮点击
 *
 *  @param sender 按钮本身
 */
- (void)hotSearchBtnClick:(UIButton *)btn {
    if (self.searchButtonClickCallback) {
        self.searchButtonClickCallback(btn);
    }
}




@end
