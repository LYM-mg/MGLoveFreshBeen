//
//  HomeHeaderView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeHeaderView.h"
#import "XRCarouselView.h"
#import "HomeHotView.h"
#import "HeadReosurce.h"

@interface HomeHeaderView ()
{
    XRCarouselView *_carouseView; /// 轮播器View
}

/** 容器 */
@property (nonatomic,weak) HomeHotView *hotView;
@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

/**
 *  UI
 */
- (void)setupUI{
    // 1.CarouseView
    [self setCarouseView];
    
    // 2.hotView
    [self setHotView];
}

/**
 *  轮播器底部的四个小东西
 */
- (void)setHotView{
    HomeHotView *hotView = [[HomeHotView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_carouseView.frame), self.width, 80)];
    hotView.backgroundColor = [UIColor whiteColor];
    [self addSubview:hotView];
    _hotView = hotView;
}

/**
 *  轮播器
 */
- (void)setCarouseView{
     _carouseView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, 150)];
    
    //设置每张图片的停留时间，默认值为5s，最少为2s
    _carouseView.time = 2;
    
    //设置分页控件的图片,不设置则为系统默认
    [_carouseView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的位置，默认为PositionBottomCenter
    _carouseView.pagePosition = PositionBottomRight;
    
    // 点击了某张图片的Block
    _carouseView.imageClickBlock = ^(NSInteger index){
        [MGNotificationCenter postNotificationName:MGCarouseViewImageClickNotification object:nil userInfo:@{@"index":@(index)}];
    };
    
    [self addSubview:_carouseView];
}

// 布局
- (void)layoutSubviews{
    [super layoutSubviews];
//    _carouseView.frame = CGRectMake(0, 0, MGSCREEN_width, 150);
//    _hotView.frame = CGRectMake(0, CGRectGetMaxY(_carouseView.frame), self.width, 80);
}

#pragma mark - 重写模型,主要赋值轮播器的图片数据
- (void)setHeadData:(HeadReosurce *)headData{
    _headData = headData;
    
    NSArray *tmpArr = [NSArray array];
    tmpArr = [Activities objectArrayWithKeyValuesArray:headData.data.focus];
    NSMutableArray *tmpImgs = [NSMutableArray array];
    for (int i = 0 ; i< tmpArr.count; i++) {
        Activities *data = tmpArr[i];
        [tmpImgs addObject:data.img];
    }
//     _hotView.backgroundColor = [UIColor redColor];
    _carouseView.imageArray = [NSArray arrayWithArray:tmpImgs];
    
    
    _hotView.headData = headData.data;
}



@end
