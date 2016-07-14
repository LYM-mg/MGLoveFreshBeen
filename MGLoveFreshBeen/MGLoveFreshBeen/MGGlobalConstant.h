//
//  MGGlobalConstant.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/15.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGGlobalConstant : NSObject

/** 全局间距10 */
UIKIT_EXTERN CGFloat const MGMargin;

/** 全局小间距5 */
UIKIT_EXTERN CGFloat const MGSmallMargin;

/** 默认导航栏的高度64 */
UIKIT_EXTERN CGFloat const MGNavHeight;


/** 通知：添加地址的通知 */
UIKIT_EXTERN NSString * const MGAddAddressNotificationCenter;

/** 通知：编辑地址的通知 */
UIKIT_EXTERN NSString * const MGEditAddressNotificationCenter;

@end
