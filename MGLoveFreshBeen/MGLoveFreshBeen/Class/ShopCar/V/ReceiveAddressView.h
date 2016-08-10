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

- (instancetype)initWithFrame:(CGRect)frame changeUserInfoClickCallBack:(void (^)())changeUserInfoClickCallBack;

@end
