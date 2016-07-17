//
//  HomeHotView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeHotView.h"

@interface HomeHotView ()
/** 记录tag */
@property (nonatomic,weak) ContantView *contantView;
@end

@implementation HomeHotView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI:(HeadData *)headData{
    NSInteger count =  headData.icons.count;
    CGFloat width = (MGSCREEN_width - (count+1)*2*MGMargin)/count;
    for (int i = 0; i<count; i++) {
        
        ContantView *contantView = [[ContantView alloc] initWithFrame:CGRectMake(i*(width + 2*MGMargin)+ 2*MGMargin, 0, width, self.height)];
        contantView.tag = i + 20;
        [self addSubview:contantView];
        
        // contantView添加点按手势
        UITapGestureRecognizer *hotPan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotPanClick:)];
        [self addGestureRecognizer:hotPan];
        
        
        
        NSArray *tmpArr = [Activities objectArrayWithKeyValuesArray:headData.icons];
        
        contantView.activity = tmpArr[i];
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - 重新模型和布局控件
- (void)setHeadData:(HeadData *)headData{
    _headData = headData;
    
    [self setupUI:headData];
}

#pragma mark - pan 手势
- (void)hotPanClick:(UITapGestureRecognizer *)tap{
    int tag = (int)tap.view.tag;
    
    [MGNotificationCenter postNotificationName:MGHotPanClickNotification object:nil userInfo:@{@"tag":@(tag)}];
}


@end

#pragma mark -
#pragma mark -ContantView
@implementation ContantView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = NO;
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
    _imageView = imageView;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = MGFont(12);
    textLabel.textColor = [UIColor blackColor];
    textLabel.userInteractionEnabled = NO;
    [self addSubview:textLabel];
    _textLabel = textLabel;
}

#pragma mark - 布局控件
- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(MGSmallMargin, MGMargin, self.width - MGMargin, self.height*0.5);
    _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame) + MGMargin, self.width, self.height*0.25);
}

#pragma mark - 重新模型
- (void)setActivity:(Activities *)activity{
    _activity = activity;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:activity.img] placeholderImage:[UIImage imageNamed:@"icon_icons_holder"]];
    _textLabel.text = activity.name;
}

@end
