//
//  LYMScanTool.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVMetadataMachineReadableCodeObject;

@interface LYMScanTool : NSObject
/**
 *  在哪个界面的View上扫描,返回扫描结果
 */
- (NSString *)scanQRCodeWithOnView:(UIView *)view;

@end
