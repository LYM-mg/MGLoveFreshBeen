//
//  SettingVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "SettingVC.h"
#import "AboutMeVC.h"


@interface SettingVC ()
/** 用来做动画的View */
@property (nonatomic,weak)  UIImageView *animationImage;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于作者";
    
    self.view.backgroundColor = MGRGBColor(230, 230, 230);
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


#pragma mark - 私有方法
#pragma mark - setUpUI
- (void)setUpUI{
    CGFloat subHeight = 50;
    
    // 关于我
    UIView *aboutMeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, subHeight)];
    aboutMeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aboutMeView];
    
    UITapGestureRecognizer *aboutMeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutMeTapClick)];
    [aboutMeView addGestureRecognizer:aboutMeTap];
    
    UILabel *aboutLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, subHeight)];
    aboutLabel.text = @"关于明哥";
    aboutLabel.font = MGFont(16);
    [aboutMeView addSubview:aboutLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"icon_go"]];
    arrowImageView.frame = CGRectMake(MGSCREEN_width - 20, (aboutMeView.height - arrowImageView.height)*0.5, 10, 15);
    [aboutMeView addSubview:arrowImageView];
  
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(10, CGRectGetMaxY(aboutMeView.frame) - 0.5, MGSCREEN_width - 10, 0.5);
    lineLayer.backgroundColor = [UIColor blackColor].CGColor;
    [aboutMeView.layer addSublayer:lineLayer];
    
    // 清理缓存
    UIView *cleanCacheView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(aboutMeView.frame) + 1, MGSCREEN_width, subHeight)];
    cleanCacheView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cleanCacheView];
    
    UITapGestureRecognizer *cleanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cleanCacheTapClick)];
    [cleanCacheView addGestureRecognizer:cleanTap];
    
    UILabel *cleanCacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, subHeight)];
    cleanCacheLabel.text = @"清理缓存";
    cleanCacheLabel.font = MGFont(16);
    [cleanCacheView addSubview:cleanCacheLabel];
    
    UILabel *cacheNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, MGSCREEN_width - 165, subHeight)];
    cacheNumberLabel.textAlignment = NSTextAlignmentRight;
    cacheNumberLabel.textColor = MGRGBColor(190, 190, 190);
    cacheNumberLabel.text = [NSString stringWithFormat:@""];
    [cleanCacheView addSubview:cacheNumberLabel];
    
    // 退出当前账号
    UIView *logoutView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cleanCacheView.frame) + 20, MGSCREEN_width, subHeight)];
    logoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logoutView];
    
    UITapGestureRecognizer *logoutTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutTapClick)];
    [logoutView addGestureRecognizer:logoutTap];

    
    UILabel *logoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, subHeight)];
    logoutLabel.text = @"退出当前账号";
    logoutLabel.textColor = MGRGBColor(90, 90, 90);
    logoutLabel.font = MGFont(16);
    logoutLabel.textAlignment = NSTextAlignmentCenter;
    [logoutView addSubview:logoutLabel];
    
    
    // 动画animationImage
    UIImageView *animationImage = [[UIImageView alloc] initWithFrame:CGRectMake(MGSCREEN_width*0.1, CGRectGetMaxY(logoutView.frame) + 50, MGSCREEN_width*0.8, 300*0.8)];
    animationImage.userInteractionEnabled = YES;
    animationImage.image = [UIImage imageNamed:@"ming2.jpg"];
    self.animationImage = animationImage;
    [self.view addSubview:animationImage];
    UITapGestureRecognizer *animationImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animationImageTapClick:)];
    [self.animationImage addGestureRecognizer:animationImageTap];
}

// 清除缓存
- (void)cleanCacheTapClick{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(
                                                               NSCachesDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:documentFolderPath];
    for (NSString *p in files) {
        NSError *error;
        NSString *Path = [documentFolderPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
            [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
        }
    }
    MGPS(@"缓存已清除");
}

// 关于我
- (void)aboutMeTapClick{
    AboutMeVC *aboutVC = [[AboutMeVC alloc] initWithNibName:NSStringFromClass([AboutMeVC class]) bundle:nil];
    
    [self.navigationController pushViewController:aboutVC animated:YES];
}

// 退出
- (void)logoutTapClick{
    MGPE(@"退出失败，现在还没有登录");
}



#pragma mark - 动画
- (void)animationImageTapClick:(UITapGestureRecognizer *)tap{
    self.animationImage.userInteractionEnabled = NO;
    static int i = 0;
    i++;
    if (i %2==1) {
        // 以"嵌套动画的外层历时5s将视图透明度修改为0.2,嵌套动画的内层不继承外层动画的持续时长,将视图大小缩小一半,期间重复2.5次"为例,代码如下
        [UIView beginAnimations:@"parent" context:nil];
        [UIView setAnimationDuration:5.0f];
        self.animationImage.alpha = 1.0f;
        
        [UIView beginAnimations:@"demo2" context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatCount:1];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.animationImage cache:YES];
        self.animationImage.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.animationImage.image = [UIImage imageNamed:@"ming4.jpg"];
        [UIView commitAnimations];
        
        [UIView commitAnimations];
    }else{
        // 翻页效果
        [UIView beginAnimations:@"FlipAni" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatCount:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.animationImage cache:YES];
        self.animationImage.image = [UIImage imageNamed:@"ming2.jpg"];
        [UIView commitAnimations];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.animationImage.userInteractionEnabled = YES;
    });
}


@end
