//
//  MyAddressCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressCellModel;
@interface MyAddressCell : UITableViewCell

/** 地址模型 */
@property (nonatomic,strong) AddressCellModel *addressModel;

/** 快速创建cell的构造方法 */
+ (instancetype)myAddressCellWithTableView:(UITableView *)tableView withEditTapClick:(void(^)())block;

@end


@interface AddressCellModel : NSObject

/** 接收人 */
@property (nonatomic,copy) NSString *accept_name;
/** 接收人电话 */
@property (nonatomic,copy) NSString * telphone;
/** 接收人所在城市 */
@property (nonatomic,copy) NSString * province_name;
/** 接收人所在地区 */
@property (nonatomic,copy) NSString * city_name;
/** 接收人详细地址 */
@property (nonatomic,copy) NSString * address;


@property (nonatomic,copy) NSString * lng;
@property (nonatomic,copy) NSString * lat;
@property (nonatomic,copy) NSString * gender;

@end


