//
//  MyAddressVC.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressCellModel;
@interface MyAddressVC : BaseController

- (instancetype)initWithSelectedAdressCallback:(void (^)(AddressCellModel *address))selectedAdressCallback;


@end
