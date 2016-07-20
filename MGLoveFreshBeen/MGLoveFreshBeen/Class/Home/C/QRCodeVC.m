//
//  QRCodeVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "QRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreFoundation/CoreFoundation.h>

@interface QRCodeVC ()<UITabBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCaptureMetadataOutputObjectsDelegate>
#pragma mark - storyboard拖线属性
/**  底部选择Tabbar */
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
/**  容器 */
@property (weak, nonatomic) IBOutlet UIView *containView;
/**  扫描的边图片 */
@property (weak, nonatomic) IBOutlet UIImageView *borderView;
/**  扫描的View */
@property (weak, nonatomic) IBOutlet UIImageView *scanView;
/**  扫描的的结果 */
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

#pragma mark - 约束
/**  容器高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewHCon;
/**  容器顶部的约束 适配4s */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewTopCon;
/**  扫描的View顶部的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanViewTopCon;

#pragma mark - 自定义
/** session */
@property (nonatomic,strong) AVCaptureSession *session;
/** preViewLayer */
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *preViewLayer;
/**  扫描的边界框 */
@property (nonatomic,strong) CAShapeLayer *shapeLayer;

/** 定时器 */
//@property (weak, nonatomic) NSTimer *timer;
@end

@implementation QRCodeVC
#pragma mark - 开启定时器
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 5.停止扫描
    [self.session stopRunning];

    // 6.移除layer
    [self.preViewLayer removeFromSuperlayer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 3.添加扫描动画
    [self setUpScanAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (IS_IPHONE4) {
        self.containViewTopCon.constant = 2*MGMargin;
    }
    
    // 1.让Tabbar默认选择第0个
    self.tabBar.selectedItem = self.tabBar.items[0];
    
    // 2.开始扫描
    [self startScanning];
    
    // 3.添加扫描动画
//    [self setUpScanAnimation];
}

/**
 *  开始动画
 */
- (void)startScanning{
    // 1.创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    // 2.设置回话输入
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    if (input == nil) {
        MGPE(@"骚年，请换真机试试");
        return;
    }
    
    [session addInput:input];
    
    // 3.设置会话输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session  addOutput:output];
    // 设置输出方式为二维码
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 4.添加一个显示到layer
    AVCaptureVideoPreviewLayer *preViewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    preViewLayer.frame = self.view.bounds;
    self.preViewLayer = preViewLayer;
    [self.view.layer insertSublayer:preViewLayer atIndex:0];
    
    // 5.开始扫描
    [session startRunning];
}

#pragma mark - 自定义方法
/**
 *  冲击波动画(扫描动画)
 */
- (void)setUpScanAnimation{
    self.scanViewTopCon.constant = -self.containViewHCon.constant;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1.0 animations:^{
        // 告诉系统该动画需要重复
        [UIView setAnimationRepeatCount:MAXFLOAT];
        self.scanViewTopCon.constant = MGMargin;
//        [UIView setAnimationRepeatAutoreverses:YES];
        [self.view layoutIfNeeded];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>的代理方法
/**
 *  扫描结果
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        // 1.获取元数据
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        // 2.获取扫描结果并且显示出来
        self.resultLabel.text = object.stringValue;
        
        // 3.使用预览图层,将corners的点转成坐标系中的点
        AVMetadataMachineReadableCodeObject *newObject = (AVMetadataMachineReadableCodeObject *)[self.preViewLayer transformedMetadataObjectForMetadataObject:object];
        
        
        // 4.画边框
        [self drawBorder:newObject];
        
        // 5.停止扫描
//        [self.session stopRunning];
//        
//        // 6.移除layer
//        [self.preViewLayer removeFromSuperlayer];
        
        // 如果是网址就跳转
        if ([object.stringValue containsString:@"http:"] || [object.stringValue containsString:@"https:"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:object.stringValue]];
        }else{ // 其他信息 弹框显示
            [MBProgressHUD showSuccess:object.stringValue];
        }
    }else{
        [self.shapeLayer removeFromSuperlayer];
//        MGPE(@"没有扫描到结果");
    }
}

- (void)drawBorder:(AVMetadataMachineReadableCodeObject *)object{
    // 0.移除之前的图形
    [self.shapeLayer removeFromSuperlayer];
    
    // 1.创建CAShapeLayer(形状类型:专门用于画图)
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    
    // 2.设置layer属性
    shapeLayer.borderColor = [UIColor orangeColor].CGColor;
    shapeLayer.borderWidth = 5;
    shapeLayer.fillColor = [UIColor redColor ].CGColor;
    
    // 3.创建贝塞尔曲线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 4.给贝塞尔曲线添加对应的点
    NSInteger count = object.corners.count;
    for (int i = 0; i<count; i++) {
        // 4.1获取每一个点对应的字典
        CFDictionaryRef  dict = (__bridge CFDictionaryRef)object.corners[i];
        CGPoint point = CGPointZero;
        CGPointMakeWithDictionaryRepresentation(dict, &point);
        
        // 4.2如果是第一个点,移动到第一个点
        if (i == 1) {
            [path moveToPoint:point];
            continue;
        }
        
        // 4.3如果是其他的点,则添加线
        [path addLineToPoint:point];
    }
    
    // 5闭合path路径
    [path closePath];
    
    // 6.给shapeLayer添加路径
    shapeLayer.path = path.CGPath;
    
    // 7.将shapeLayer添加到其他视图上
    [self.preViewLayer addSublayer:shapeLayer];
    
    // 8.保存shapeLayer
    self.shapeLayer = shapeLayer;
}

#pragma mark - 导航栏点击
 /// 点击左边关闭按钮的操作
- (IBAction)close:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/// 点击导航栏右边照片的操作
- (IBAction)photoItemClick:(id)sender {
    // 1.判断照片源是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        MGPE(@"照片库不可用");
    }
    
    // 2.创建ipc
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    // 3.设置照片源
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 4.设置代理
    ipc.delegate = self;
    
    // 5.弹出控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = image = info[UIImagePickerControllerOriginalImage];
    // 2.识别照片中的二维码的信息
    [self getQRCodeInfo:image];
    
    // 3.退出控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 取得图片中的信息
- (void)getQRCodeInfo:(UIImage *)image{
    // 1.创建扫描器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    
    // 2.扫描结果
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    
    NSArray *features = [detector featuresInImage:ciImage];
    
    // 3.遍历扫描结果
    for (CIQRCodeFeature *f in features) {
        // 如果是网址就跳转
        if ([f.messageString containsString:@"http:"] || [f.messageString containsString:@"https:"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:f.messageString]];
        }else{ // 其他信息 弹框显示
            [MBProgressHUD showSuccess:f.messageString];
        }
    }
}


#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    // 1.修改内容view的高度
    self.containViewHCon.constant = (item.tag == 1) ? 250 : 120;
    [self.view layoutIfNeeded];
    
    // 2.移除之前动画
    [self.scanView.layer removeAllAnimations];
    
    // 3.重新调用之前的冲击波动画
    [self setUpScanAnimation];
    
    // 4.调用之前的开始扫描动画
//    [self startScanning];
}

@end
