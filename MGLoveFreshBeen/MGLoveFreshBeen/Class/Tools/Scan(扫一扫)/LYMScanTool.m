//
//  LYMScanTool.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "LYMScanTool.h"
#import <AVFoundation/AVFoundation.h>

@interface LYMScanTool()<AVCaptureMetadataOutputObjectsDelegate>

/** <#注释#> */
@property (nonatomic,strong) AVCaptureSession *session;
/** <#注释#> */
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *layer;

@property (nonatomic,strong) NSString *QRCodeStr;

@end

@implementation LYMScanTool

/**
 *  在哪个界面的View上扫描
 */
- (NSString *)scanQRCodeWithOnView:(UIView *)view{
    // 1.创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    // 2.设置回话输入
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    if (input == nil) {
        return @"";
    }
    
    [session addInput:input];
    
    // 3.设置会话输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session  addOutput:output];
    // 设置输出方式为二维码
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 4.添加一个显示到layer
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    layer.frame = view.bounds;
    self.layer = layer;
    [view.layer addSublayer:layer];
    
    // 5.开始扫描
    [session startRunning];
    
    return self.QRCodeStr;
}


#pragma mark 实现AVCaptureMetadataOutputObjectsDelegate代理方法
/**
 *  扫描结果
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        // 1.获取元数据
       AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        // 2.获取具体的值
        self.QRCodeStr = object.stringValue;
        
        // 3.停止扫描
        [self.session stopRunning];
        
        // 4.移除layer
        [self.layer removeFromSuperlayer];
    }
}


@end
