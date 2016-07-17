//
//  HomeHotView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeHotView.h"

@interface HomeHotView ()

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
        
        [self addSubview:contantView];
        
        NSArray *tmpArr = [Activities objectArrayWithKeyValuesArray:headData.icons];
        
        contantView.activity = tmpArr[i];
        
        // contantView添加点按手势
        UITapGestureRecognizer *hotPan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotPanClick:)];
        [contantView addGestureRecognizer:hotPan];
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
    [MGNotificationCenter postNotificationName:MGHotPanClickNotification object:nil];
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
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
    _imageView = imageView;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = MGFont(12);
    textLabel.textColor = [UIColor blackColor];
    textLabel.userInteractionEnabled = YES;
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
