//
//  CouponCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "CouponCell.h"
#import "CouponVC.h"

#define  circleWidth (MGSCREEN_width * 0.16)


@interface CouponCell ()
{
   UIImageView *_backImageView; //v2_coupon_gray  v2_coupon_yellow
   UIImageView *_outdateImageView; // v2_coupon_outdated 过期 // v2_coupon_used已使用
   UILabel *_titleLabel;
   UILabel *_dateLabel;
   UILabel *_descLabel;
   UIView *_line1View;
   UIView *_line2View;
   UILabel *_priceLabel;
   UILabel *_statusLabel;
   UIImageView *_circleImageView;
}

//@property (nonatomic,strong) UIImageView *backImageView; 
//@property (nonatomic,strong) UIImageView *outdateImageView;
//@property (nonatomic,strong) UILabel *titleLabel;
//@property (nonatomic,strong) UILabel *dateLabel;
//@property (nonatomic,strong) UILabel *descLabel;
//@property (nonatomic,strong) UIView *line1View;
//@property (nonatomic,strong) UIView *line2View;
//@property (nonatomic,strong) UILabel *priceLabel;
//@property (nonatomic,strong) UILabel *statusLabel;
//@property (nonatomic,strong) UIImageView * circleImageView;
@end


@implementation CouponCell


+ (instancetype)couponCellWithTableView:(UITableView *)tableView{
    static NSString *const KCouponCellIdentifier = @"KCouponCellIdentifier";
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:KCouponCellIdentifier];
    if (cell ==  nil) {
        cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCouponCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

// 1.创建子控件
- (void)setupUI {

    _backImageView = [UIImageView new];
    [self.contentView addSubview:_backImageView];
    
    _dateLabel = [UILabel new];
    _dateLabel.font = MGFont(12);
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_dateLabel];
    
    _line1View = [UIView new];
    _line1View.alpha = 0.3;
    [self.contentView addSubview:_line1View];
    
    _line2View = [UIView new];
    _line2View.alpha = 0.3;
     [self.contentView addSubview:_line2View];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:13];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, circleWidth, circleWidth)];
    [self.contentView addSubview:_circleImageView];
    
    _statusLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 35, circleWidth, 20)];
    _statusLabel.hidden = true;
    _statusLabel.textColor = MGRGBColor(105, 105, 105);
    _statusLabel.font = MGFont(10);
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    [_circleImageView addSubview:_statusLabel];
    
    _priceLabel = [UILabel new];;
    _priceLabel.font = [UIFont boldSystemFontOfSize:16];
    _priceLabel.frame = CGRectMake(0, 10, circleWidth, 30);
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = [UIColor whiteColor];
    [_circleImageView addSubview:_priceLabel];

    
    _descLabel = [UILabel new];;
    _descLabel.font = MGFont(10);
    _descLabel.numberOfLines = 0;
    [self.contentView addSubview:_descLabel];
}

// 2.布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat CouponVCMargin = MGMargin * 2;
    
    CGFloat starRightL = (MGSCREEN_width - 2 * CouponVCMargin) * 0.26 + CouponVCMargin;
    CGFloat rightWidth = (MGSCREEN_width - 2 * CouponVCMargin) * 0.74;
    
    _backImageView.frame = CGRectMake(CouponVCMargin,MGSmallMargin, self.contentView.width - 2 * CouponVCMargin, self.contentView.height - MGMargin);
    
    CGFloat circleX = ((MGSCREEN_width - 2 * CouponVCMargin) * 0.26 - circleWidth) * 0.65;
    _circleImageView.frame = CGRectMake(CouponVCMargin + circleX, 0, circleWidth, circleWidth);
    _circleImageView.centerY = _backImageView.center.y;
    
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake((rightWidth - _titleLabel.width) * 0.5 + starRightL, 15, _titleLabel.width, _titleLabel.height);
    
    _line1View.frame = CGRectMake(CouponVCMargin + (MGSCREEN_width - 2 * CouponVCMargin) * 0.26 + MGMargin, 2, (MGSCREEN_width - 2 * CouponVCMargin) * 0.74 - 20, 0.8);
    _line1View.centerY = (_titleLabel.center.y);
    [_dateLabel sizeToFit];
    _dateLabel.frame = CGRectMake((rightWidth - _dateLabel.width) * 0.5 + starRightL, CGRectGetMaxY(_titleLabel.frame) + MGMargin, _dateLabel.width, _dateLabel.height);
    
    _line2View.frame = CGRectMake(CGRectGetMinX(_dateLabel.frame), CGRectGetMaxY(_dateLabel.frame) + 15, _dateLabel.width, 0.4);
    
    _descLabel.frame = CGRectMake(starRightL + CouponVCMargin, CGRectGetMinY(_line2View.frame) + MGSmallMargin, rightWidth - CouponVCMargin - MGMargin, 40);
}

// 3.重新赋值模型
- (void)setCouponModel:(Coupon *)couponModel{
    _couponModel = couponModel;
    switch (couponModel.status) {
    case 0:
        [self setCouponColor:true];
            break;
    case 1:
        [self setCouponColor:NO];
        _statusLabel.text = @"已使用";
            break;
    default:
       [self setCouponColor:NO];
        _statusLabel.text = @"已过期";
            break;
    }
    _priceLabel.text = [NSString stringWithFormat:@"$%@",couponModel.value];
    _titleLabel.text = [NSString stringWithFormat:@" %@ ",couponModel.name];
    _dateLabel.text = [NSString stringWithFormat:@"有效期: %@ 至 %@",couponModel.start_time,couponModel.end_time];
    _descLabel.text = couponModel.desc;
}

/** 优惠券是否使用，设置不同的颜色 */
- (void)setCouponColor:(BOOL)isUse {
    _backImageView.image = isUse ? [UIImage imageNamed:@"v2_coupon_yellow"] : [UIImage imageNamed:@"v2_coupon_gray"];
    _titleLabel.textColor = isUse ? MGRGBColor(161, 161, 90) : MGRGBColor(158, 158, 158);
    _titleLabel.backgroundColor = isUse ? MGRGBColor(255, 224, 224) : MGRGBColor(238, 238, 238);
    _dateLabel.textColor = _titleLabel.textColor;
    _statusLabel.hidden = isUse;
    _line1View.backgroundColor = isUse ? MGRGBColor(161, 161, 90) :  MGRGBColor(158, 158, 158);;
    _line2View.backgroundColor = _line1View.backgroundColor;
    _descLabel.textColor = _titleLabel.textColor;
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, circleWidth, circleWidth)];
    tmpView.backgroundColor = isUse ? MGRGBColor(253, 212, 49) : MGRGBColor(210, 210, 210);
    UIImage *image = [self createImageFromView:tmpView];
    _circleImageView.image = [self imageClipOvalImage:image];
}

/** 产生一张图片 */
- (UIImage *)createImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

/** 产生原图 */
- (UIImage *)imageClipOvalImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
