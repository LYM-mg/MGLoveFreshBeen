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
/**
 *  根据模型   设置控件
 */
- (void)setupUI:(HeadData *)headData{
    NSInteger count =  headData.icons.count;
    CGFloat width = (MGSCREEN_width - (count+1)*2*MGMargin)/count;
    for (int i = 0; i<count; i++) {
        
        ContantView *contantView = [[ContantView alloc] initWithFrame:CGRectMake(i*(width + 2*MGMargin)+ 2*MGMargin, 0, width, self.height)];
        contantView.tag = i + 20;
        [self addSubview:contantView];
        // contantView添加点按手势
        [contantView addTarget:self action:@selector(hotItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
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


#pragma mark - hotView里面的按钮的点击操作
- (void)hotItemClick:(ContantView *)sender{
    NSInteger tag = sender.tag;
    
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
/**
 *  设置UI界面
 */
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = NO;
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
    _iconView = imageView;
    
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
    _iconView.frame = CGRectMake(MGSmallMargin, MGMargin, self.width - MGMargin, self.height*0.5);
    _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_iconView.frame) + MGSmallMargin, self.width, self.height*0.25);
}

#pragma mark - 重新模型
- (void)setActivity:(Activities *)activity{
    _activity = activity;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:activity.img] placeholderImage:[UIImage imageNamed:@"icon_icons_holder"]];
    _textLabel.text = activity.name;
}

@end

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    UITouch *touch = [touches anyObject];
//    
//    // 获取当前的触摸点
//    CGPoint curP = [touch locationInView:self];
//    
//    for (ContantView *hot in self.subviews)
//    {
//        // 把btn的转化为坐标
//        CGPoint btnP = [self convertPoint:curP toView:hot];
//        //       CGRectContainsPoint(self.frame, curP) ;// 返回BOOL类型
//        
//        // 判断当前点是否点在按钮上并且选中为选中的按钮
//        //        if ([hot pointInside:btnP withEvent:event])
//        if ( CGRectContainsPoint(self.frame, btnP))
//        {
//            self.contantView = hot;
//        }
//    }
//}

