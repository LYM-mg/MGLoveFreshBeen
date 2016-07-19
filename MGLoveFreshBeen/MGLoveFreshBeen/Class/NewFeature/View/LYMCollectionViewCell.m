//
//  LYMCollectionViewCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/07/18.
//  Copyright (c) 2016年 ming. All rights reserved.
//

#import "LYMCollectionViewCell.h"
#import "TabBarVC.h"


#define LYMkeyWindow [UIApplication sharedApplication].keyWindow

@interface LYMCollectionViewCell ()
/** 定时器 */
@property (weak, nonatomic) NSTimer *timer;
/** 背景图片 */
@property (nonatomic,weak) UIImageView *imageView;
/** 用户体验按钮 */
@property (nonatomic,strong) UIButton *startBtn;
/** 提示Label */
@property (nonatomic,strong) UILabel *tipLable;
@end

@implementation LYMCollectionViewCell
#pragma mark - lazy
#pragma mark - 提示Label
- (UILabel *)tipLable
{
    if (!_tipLable) {
        _tipLable = [[UILabel alloc] init];
        
        _tipLable.frame = CGRectMake(self.width -150,1.5 * MGMargin, 140, 30);
        _tipLable.textColor = [UIColor redColor];
        _tipLable.textAlignment = NSTextAlignmentCenter;
        _tipLable.backgroundColor = MGBackGray;
        _tipLable.text = @"n秒后进入主界面";
//        [_tipLable sizeToFit];
        // 添加提示Label
        [self.contentView addSubview:_tipLable];
    }
    return _tipLable;
}

#pragma mark - 开启定时器
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)timeChange{
    static int t = 60; // 必须用static修饰
    NSString *str = [NSString stringWithFormat:@"%d秒后进入主界面",t];
    self.tipLable.text = str;;
    if (t == -1) {
        [self startClick];
    }
    t--;
}

#pragma mark - 背景图片
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

#pragma mark - 开始体验按钮
- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 1.设置按钮的背景图片
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        _startBtn.backgroundColor = [UIColor grayColor];
        [_startBtn sizeToFit];
        _startBtn.centerX = self.contentView.center.x;
        _startBtn.centerY = self.contentView.height * 0.9;
        
        // 2.监听按钮点击
        [_startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 3.添加按钮
        [self.contentView addSubview:_startBtn];
    }
    return _startBtn;
}


// 监听按钮点击
- (void)startClick{
    // 0.移除定时器
    [self.timer invalidate];
    
    // 1.创建TabBarVC控制器
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
    self.startBtn.hidden = (index.row  != count - 1);
    self.tipLable.hidden = (index.row  != count - 1);
    if (index.row == count - 1) {
        // 1.开始按钮动画
        _startBtn.transform = CGAffineTransformMakeTranslation(0, -self.height);
        
        [UIView animateWithDuration:1.5 animations:^{
            _startBtn.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.2 initialSpringVelocity:20 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                _startBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                _startBtn.transform = CGAffineTransformIdentity;
            }];
        }];
        
        // 2.开启定时器
        [self timer];
        
        // 3.提示Label出现
        _tipLable.transform = CGAffineTransformMakeTranslation(-self.width, 0);
        [UIView animateWithDuration:0.8 animations:^{
            self.tipLable.transform = CGAffineTransformIdentity;
        }];
    }else{
        // 0.移除定时器
        [self.timer invalidate];
        _timer = nil;
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
}


@end
