//
//  MGGlobalConstant.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/15.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGGlobalConstant.h"

@implementation MGGlobalConstant

/** 优惠劵使用规则的网址  */
NSString * const MGCouponUserRuleURLString = @"http://m.beequick.cn/show/webview/p/coupon?zchtauth=e33f2ac7BD%252BaUBDzk6f5D9NDsFsoCcna6k%252BQCEmbmFkTbwnA&__v=ios4.7&__d=d14ryS0MFUAhfrQ6rPJ9Gziisg%2F9Cf8CxgkzZw5AkPMbPcbv%2BpM4HpLLlnwAZPd5UyoFAl1XqBjngiP6VNOEbRj226vMzr3D3x9iqPGujDGB5YW%2BZ1jOqs3ZqRF8x1keKl4%3D";


#pragma mark - 间距

/** 全局间距10 */
CGFloat const MGMargin = 10;

/** 全局小间距5 */
CGFloat const MGSmallMargin = 5;

/** 默认导航栏的高度64 */
CGFloat const MGNavHeight = 64;



#pragma mark - 通知

/** 通知：添加地址的通知 */
NSString * const MGAddAddressNotificationCenter = @"MGAddAddressNotificationCenter";

/** 通知：编辑地址的通知 */
NSString * const MGEditAddressNotificationCenter = @"MGEditAddressNotificationCenter";

/** 通知：分类栏选中的的通知 */
NSString * const MGCategortsSelectedIndexPathNotificationCenter = @"MGCategortsSelectedIndexPathNotificationCenter";

/** 通知：头部即将消失的的通知 */
NSString * const MGWillDisplayHeaderViewNotificationCenter = @"MGWillDisplayHeaderViewNotificationCenter";

/** 通知：头部完全消失的的通知 */
NSString * const MGDidEndDisplayingHeaderViewNotificationCenter = @"MGDidEndDisplayingHeaderViewNotificationCenter";

#pragma mark - 友盟分享APPKey
NSString * const MGUmengAppkey = @"578b2021e0f55af6c9000e65";

@end
