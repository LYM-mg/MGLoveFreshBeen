//
//  ShopCarHeaderView.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressCellModel;

@interface ShopCarHeaderView : UIView
/** 地址模型 */
@property (nonatomic,strong) AddressCellModel *addressModel;
/** 修改用户收货信息 */
@property (nonatomic,copy) void (^changeUserInfoClickCallBack)();


@end
