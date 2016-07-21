//
//  ThrowLineTool.h
//  Animation
//
//  Created by 王建成 on 15/11/25.
//  Copyright © 2015年 zykj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ThrowLineToolDelegate;

@interface ThrowLineTool : NSObject

@property (nonatomic, assign) id<ThrowLineToolDelegate>delegate;
@property (nonatomic, retain) UIView *showingView;

+ (ThrowLineTool *)sharedTool;

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 *  @param height 高度，抛物线最高点比起点/终点y坐标最低(即高度最高)所超出的高度
 *  @param num view 变小的高度
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
             height:(CGFloat)height andViewBoundsScale:(CGFloat)num duration:(CGFloat)duration;

@end


@protocol ThrowLineToolDelegate <NSObject>

/**
 *  抛物线结束的回调
 */
- (void)animationDidFinish:(UIView *)view;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com