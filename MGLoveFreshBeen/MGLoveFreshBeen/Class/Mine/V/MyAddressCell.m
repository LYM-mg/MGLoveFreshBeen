//
//  MyAddressCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MyAddressCell.h"

@interface MyAddressCell ()
/** 名字 */
@property (nonatomic,weak) UILabel *nameLabel;
/** 电话 */
@property (nonatomic,weak) UILabel *phoneLabel;
/** 地址 */
@property (nonatomic,weak) UILabel *addressLabel;
/** 分割线 */
@property (nonatomic,weak) UIView *lineView;
/** 编辑的View */
@property (nonatomic,weak) UIImageView *modifyImageView;

@end

@implementation MyAddressCell
#pragma mark - 创建方法
- (void)awakeFromNib {
    [self setupUI];
}

+ (instancetype)myAddressCellWithTableView:(UITableView *)tableView{
    static NSString *const KMyAddressCellIdentifier = @"KMyAddressCellIdentifier";
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:KMyAddressCellIdentifier];
    if (cell == nil) {
        cell = [[MyAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMyAddressCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI {
    // 1.创建子控件
    UILabel *nameLabel = [UILabel new];
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UILabel *phoneLabel = [UILabel new];
    [self.contentView addSubview:phoneLabel];
    _phoneLabel = phoneLabel;
    
    UILabel *addressLabel = [UILabel new];
    [self.contentView addSubview:addressLabel];
    _addressLabel = addressLabel;
    
    UIView *lineView = [UIView new];
    [self.contentView addSubview:lineView];
    
    UIImageView *modifyImageView = [UIImageView new];
    [self.contentView addSubview:modifyImageView];
    _modifyImageView = modifyImageView;
    
    // 2.布局子控件
    [nameLabel ]
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation AddressCellModel


@end

