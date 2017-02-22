//
//  HomeHotView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "HeadReosurce.h"

#pragma mark - HomeHotView
@interface HomeHotView : UIView

/** HeadData模型 */
@property (nonatomic,strong) HeadData *headData;

@end



#pragma mark - ContantView
@interface ContantView : UIButton
/** 轮播器下面的图片 */
@property (nonatomic,weak) UIImageView *iconView;

/** 轮播器下  图片下面textLabel文字 */
@property (nonatomic,weak) UILabel *textLabel;

/** Activities模型 */
@property (nonatomic,strong) Activities *activity;

@end