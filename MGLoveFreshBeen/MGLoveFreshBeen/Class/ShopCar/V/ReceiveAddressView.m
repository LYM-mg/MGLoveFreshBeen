//
//  ReceiveAddressView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ReceiveAddressView.h"
#import "MyAddressCell.h"

@interface ReceiveAddressView ()

@property (weak, nonatomic) IBOutlet UILabel *receiveUserName;

@property (weak, nonatomic) IBOutlet UILabel *receiveUserPhone;

@property (weak, nonatomic) IBOutlet UILabel *receiveUserAddress;

//
/** <#注释#> */
@property (nonatomic,copy) void (^changeUserInfoClickCallBack)();

@end

@implementation ReceiveAddressView

- (instancetype)initWithFrame:(CGRect)frame changeUserInfoClickCallBack:(void (^)())changeUserInfoClickCallBack{
    if (self = [super init]) {
        self.changeUserInfoClickCallBack = changeUserInfoClickCallBack;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)awakeFromNib{
    
}

/**
 *  重写收货地址模型的getter方法
 */
- (void)setAddressModel:(AddressCellModel *)addressModel{
    _addressModel = addressModel;
    
    if (_addressModel) {
        NSString *nameTail = ([addressModel.gender isEqualToString:@"1"] ? @" 先生" : @" 女士");
        _receiveUserName.text = [NSString stringWithFormat:@"%@%@",addressModel.accept_name,nameTail];
        _receiveUserPhone.text = addressModel.telphone;
        _receiveUserAddress.text = addressModel.address;
    }
}

// 修改用户收货信息
- (IBAction)changeUserInfoClick:(UIButton *)sender {
    if (self.changeUserInfoClickCallBack) {
        self.changeUserInfoClickCallBack();
    }
}

@end
