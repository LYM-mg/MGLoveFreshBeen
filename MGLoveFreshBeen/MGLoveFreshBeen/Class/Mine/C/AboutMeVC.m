//
//  AboutMeVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "AboutMeVC.h"

@interface AboutMeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *AboutMeIconView;

@end

@implementation AboutMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.title = @"关于作者";
}

#pragma mark - 操作
- (IBAction)turnToGithub:(UIButton *)btn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:btn.titleLabel.text]];
}

- (IBAction)turnToJianshu:(UIButton *)btn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:btn.titleLabel.text]];
}



#pragma mark - 动画
- (IBAction)aboutMeIconViewTapClick:(UITapGestureRecognizer *)tap {
    static int i = 0;
    i++;
    if (i %2==1) {
        [self setAnimationTransition:UIViewAnimationTransitionCurlUp imageName:@"ming3.jpg"];
    }else{
        [self setAnimationTransition:UIViewAnimationTransitionCurlDown imageName:@"ming1.jpg"];
    }
}

- (void)setAnimationTransition:(UIViewAnimationTransition)transition imageName:(NSString *)imageName{
    [UIView beginAnimations:@"FlipAni" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:transition forView:self.AboutMeIconView cache:YES];
    self.AboutMeIconView.image = [UIImage imageNamed:imageName];
    [UIView commitAnimations];
}

- (void)startAni:(NSString *)aniID{
    MGPS(aniID);
}

- (void)stopAni:(NSString *)aniID{
//    // MGLogFunc;
}

@end
