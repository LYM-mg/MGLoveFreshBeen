//
//  ThrowLineTool.m
//  Animation
//
//  Created by 王建成 on 15/11/25.
//  Copyright © 2015年 zykj. All rights reserved.
//



#import "ThrowLineTool.h"

static ThrowLineTool *s_sharedInstance = nil;
@implementation ThrowLineTool

+ (ThrowLineTool *)sharedTool
{
    if (!s_sharedInstance) {
        s_sharedInstance = [[[self class] alloc] init];
    }
    return s_sharedInstance;
}

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 *  @param height 高度，抛物线最高点比起点/终点y坐标最低(即高度最高)所超出的高度
 *  @param num view 变小的比例
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
             height:(CGFloat)height andViewBoundsScale:(CGFloat)num duration:(CGFloat)duration
{
    self.showingView = obj;
    
//    [UIView commitAnimations];
    //初始化抛物线path
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat cpx = (start.x + end.x) / 2;
    CGFloat cpy = -height;
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, end.x, end.y);//抛物线
    //CGPathAddLineToPoint(path,NULL, end.x, end.y);//直线
    //CAKey
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    CFRelease(path);

    //变小
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.toValue = [NSNumber numberWithFloat:(CGFloat)((arc4random() % 4) + 4) / num];//变小点
    //旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
//    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 0.3;
    
    
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    
    groupAnimation.repeatCount = 1;
  //  groupAnimation.repeatCount = MAXFLOAT;
    
    groupAnimation.duration = duration;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = @[rotateAnimation,scaleAnimation, animation];
    [obj.layer addAnimation:groupAnimation forKey:@"position scale"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidFinish:)]) {
        [self.delegate performSelector:@selector(animationDidFinish:) withObject:self.showingView];
    }
//    self.showingView = nil;
}



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com