//
//  HomeHotView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "HeadReosurce.h"
@interface HomeHotView : UIView
/** UIImageView */
//@property (nonatomic,weak) UIImageView *imageView;
//
///** textLabel */
//@property (nonatomic,weak) UILabel *textLabel;

/** 模型 */
@property (nonatomic,strong) HeadData *headData;
@end

@interface ContantView : UIButton

@property (nonatomic,weak) UIImageView *iconView;

/** textLabel */
@property (nonatomic,weak) UILabel *textLabel;

/** <#注释#> */
@property (nonatomic,strong) Activities *activity;

@end