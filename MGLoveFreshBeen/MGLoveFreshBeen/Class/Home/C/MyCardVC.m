//
//  MyCardVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MyCardVC.h"
#import "LYMQRCodeTool.h"

@interface MyCardVC ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

@end

@implementation MyCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpQRCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation
/**
 *  创建二维码照片
 */
- (void)setUpQRCode{
    // 1.设置图片
    UIImage *image = [LYMQRCodeTool creatCIQRWithText:@"http://www.jianshu.com/users/57b58a39b70e/latest_articles"];
    
    // 6.在二维码中画上头像
    self.cardImageView.image = [self drawImage:image iconName:@"12.png"];
}

/**
 *  画图片,利用Quartz2D,在二维码中间生成一张小图片
 */
- (UIImage *)drawImage:(UIImage *)image iconName:(NSString *)iconName {
    // 1.开启位图文
    UIGraphicsBeginImageContextWithOptions(image.size, false, 1.0);
    
    // 2.渲染
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.将传入进来的image绘画上去
    [image drawInRect:CGRectMake(0, 0, image.size.width,image.size.height)];
    
    // 4.计算中间图片的大小以及放图片进去的矩形框
    UIImage *centerImage = [UIImage imageNamed:iconName];
    
    CGFloat width = 60;
    CGFloat height = 60;
    CGFloat x = (image.size.width - width)/2;
    CGFloat y = (image.size.height - height)/2;
    
    [centerImage drawInRect:CGRectMake(x, y, width, height)];
    
    // 5.获得当前感图片
    UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.结束(关闭)图形上下文
    UIGraphicsEndImageContext();
    
    // 7.返回绘制好的图片
    return drawImage;
}


@end


/// 拉伸图片,去除生成的二维码模糊的BUG
//- (UIImage *)scaleImage:(CIImage *)imgae{
//    CGAffineTransform transform = CGAffineTransformMakeScale(10, 10);
//
//    CIImage *newImage = [imgae imageByApplyingTransform:transform];
//
//    return [UIImage imageWithCIImage:newImage];
//}