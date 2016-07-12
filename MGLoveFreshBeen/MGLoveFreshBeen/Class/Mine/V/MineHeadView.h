//
//  MineHeadView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>

@interface MineHeadView : UIImageView
/** 设置按钮的点击回调 */
@property (nonatomic,strong) void (^setUpButtonClickBlock)();
/** 便利构造方法 */
- (instancetype)initWithFrame:(CGRect)frame setUpButtonClick:(void (^)())setUpButtonClickBlock;
@end

@interface IconView : UIView
/** 头像 */
@property (nonatomic,weak) UIImageView *iconImageView;
/** 电话号 */
@property (nonatomic,weak) UILabel *phoneNum;

@end