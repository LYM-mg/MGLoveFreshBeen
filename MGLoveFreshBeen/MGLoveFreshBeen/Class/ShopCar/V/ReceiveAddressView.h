//
//  ReceiveAddressView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressCellModel;

@interface ReceiveAddressView : UIView

/** 地址模型 */
@property (nonatomic,strong) AddressCellModel *addressModel;

/** 修改用户收货信息 */
@property (nonatomic,copy) void (^changeUserInfoClickCallBack)();

//- (instancetype)initWithFrame:(CGRect)frame changeUserInfoClickCallBack:(void (^)())changeUserInfoClickCallBack;
/**
 *  快速从xib创建 ReceiveAddressView
 *
 *  @return ReceiveAddressView
 */
+ (instancetype)receiveAddressView;

@end
