//
//  QuestionSectionHeader.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "QuestionSectionHeader.h"
#import "questionCellModel.h"

@interface QuestionSectionHeader ()
/** sectionHeader的点击回调 */
//@property (nonatomic,strong) void (^sectionHeaderClickBlock)();

/** titleLabel */
@property (nonatomic,weak)  UILabel *titleLabel;

/** arrowImage */
@property (nonatomic,weak) UIImageView *arrowImage;

/** 按钮 */
@property (nonatomic,weak) UIButton *btn;

@end


@implementation QuestionSectionHeader
//+ (instancetype)questionSectionHeaderWithIdentity:(NSString *)identity sectionHeaderClick:(void (^)(BOOL isExpanded))sectionHeaderClickBlock{
//    QuestionSectionHeader *header = [[self alloc] initWithReuseIdentifier:identity];
//    header.sectionHeaderClickBlock = sectionHeaderClickBlock;
//    return header;
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setUpUI];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]){
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setUpUI{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow_up_accessory"]];
    [self.contentView addSubview:arrowImage];
    self.arrowImage = arrowImage;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(sectionHeaderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView insertSubview:btn atIndex:299];
    self.btn = btn;
    
    CALayer *line = [[CALayer alloc] init];
    line.frame = CGRectMake(10, 44 - 0.5, MGSCREEN_width, 0.5);
    line.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:line];
}

// 重写model的setter方法
- (void)setModel:(questionCellModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    if (model.isExpanded) { // 已经展开
        self.arrowImage.image = [UIImage imageNamed:@"cell_arrow_down_accessory"];
    } else { // 未展开
        self.arrowImage.image = [UIImage imageNamed:@"cell_arrow_up_accessory"];
    }
    
    self.titleLabel.text = model.title;
}

#pragma mark - 点击事件的监听
- (void)sectionHeaderClick:(UIButton *)btn{
    self.model.isExpanded = !self.model.isExpanded;
    
    // 判断模型是否展开
    [UIView animateWithDuration:0.28 animations:^{
        if ( self.model.isExpanded) { // 已经展开
            self.arrowImage.image = [UIImage imageNamed:@"cell_arrow_down_accessory"];
        } else { // 未展开
            self.arrowImage.image = [UIImage imageNamed:@"cell_arrow_up_accessory"];
        }

    }];
    
    // 点击代码回调
    if (self.sectionHeaderClickBlock) {
        self.sectionHeaderClickBlock(self.model.isExpanded);
    }
}


// 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    self.arrowImage.orgin = CGPointMake(MGSCREEN_width - self.arrowImage.width - 15, (self.contentView.height - self.arrowImage.height)*0.5);
    self.titleLabel.frame = CGRectMake(16, (self.contentView.height - self.titleLabel.height)*0.5, MGSCREEN_width*0.9, 35);
     self.btn.frame = self.contentView.bounds;
}

@end
