//
//  LYMCollectionViewCell.m
//  01-
//
//  Created by ming on 16/07/18.
//  Copyright (c) 2016年 ming. All rights reserved.
//

#import "LYMCollectionViewCell.h"
#import "TabBarVC.h"


#define LYMkeyWindow [UIApplication sharedApplication].keyWindow

@interface LYMCollectionViewCell ()

@property (nonatomic,weak) UIImageView *imageView;

/** 用户体验按钮 */
@property (nonatomic,strong) UIButton *startBtn;
@end

@implementation LYMCollectionViewCell
#pragma mark - lazy
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _imageView = imageV;
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}

// 一定要重写setImage方法
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 1.设置按钮的背景图片
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        _startBtn.backgroundColor = [UIColor grayColor];
        [_startBtn sizeToFit];
        _startBtn.centerX = self.contentView.center.x;
        _startBtn.centerY = self.contentView.height * 0.85;
        
        // 2.监听按钮点击
        [_startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 3.添加按钮
        [self.contentView addSubview:_startBtn];
    }
    return _startBtn;
}


// 监听按钮点击
- (void)startClick{
    // 1.创建LYMTabBarController控制器
    TabBarVC *tabBar = [[TabBarVC alloc] init];
    // 2.重新设置窗口的根控制器
    [LYMkeyWindow setRootViewController:tabBar];
    
    // 3.添加转场动画
    CATransition *transition = [CATransition animation];
    transition.type = @"rippleEffect";
    
    [LYMkeyWindow.layer addAnimation:transition forKey:nil];
}

- (void)setIndexPath:(NSIndexPath *)index withCount:(int)count
{
    self.startBtn.hidden = (index.row  == count - 1);
}


- (void)layoutSubviews{
    [super layoutSubviews];
}


@end
