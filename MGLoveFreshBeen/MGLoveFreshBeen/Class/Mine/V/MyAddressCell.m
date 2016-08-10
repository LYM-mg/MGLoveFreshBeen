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

/** 编辑手势点击的回调 */
@property (nonatomic,copy) void (^editTapClickCompletion)();

@end

@implementation MyAddressCell
#pragma mark - 创建方法
- (void)awakeFromNib {
    [self setupUI];
}
//
+ (instancetype)myAddressCellWithTableView:(UITableView *)tableView withEditTapClick:(void(^)())block{
    static NSString *const KMyAddressCellIdentifier = @"KMyAddressCellIdentifier";
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:KMyAddressCellIdentifier];
    if (cell == nil) {
        cell = [[MyAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMyAddressCellIdentifier];
        cell.editTapClickCompletion = block;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.userInteractionEnabled = YES;
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
    nameLabel.font = MGFont(16);
    nameLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.numberOfLines = 0;
    phoneLabel.font = MGFont(15);
    phoneLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:phoneLabel];
    _phoneLabel = phoneLabel;
    
    UILabel *addressLabel = [UILabel new];
    addressLabel.numberOfLines = 0;
    addressLabel.font = MGFont(13);
    [self.contentView addSubview:addressLabel];
    _addressLabel = addressLabel;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.7;
    [self.contentView addSubview:lineView];
    
    UIImageView *modifyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_address_edit_highlighted"]];
    [self.contentView addSubview:modifyImageView];
    _modifyImageView = modifyImageView;
    modifyImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *editTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTapClick:)];
    [modifyImageView addGestureRecognizer:editTap];
    
    // 2.布局子控件
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(25);
    }];
    [modifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-MGMargin);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(MGMargin);
        make.bottom.mas_equalTo(self.contentView).offset(-MGMargin);
        make.right.mas_equalTo(modifyImageView.mas_left).offset(-MGMargin);
        make.width.mas_equalTo(1);
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(nameLabel);
        make.left.mas_equalTo(nameLabel.mas_right).offset(-5);
        make.right.mas_equalTo(lineView);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.right.mas_equalTo(lineView).offset(-MGMargin);
        make.bottom.mas_equalTo(self.contentView).offset(-MGMargin);
        make.height.mas_equalTo(25);
    }];
}

#pragma mark - 重写模型的setter方法
- (void)setAddressModel:(AddressCellModel *)addressModel{
    _addressModel = addressModel;
    self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",addressModel.accept_name];
    self.phoneLabel.text = [NSString stringWithFormat:@"Tel：%@",addressModel.telphone];
    self.addressLabel.text = [NSString stringWithFormat:@"地址：%@",addressModel.address];
}

#pragma mark - 编辑手势点击
- (void)editTapClick:(UITapGestureRecognizer *)tap{
    if (_editTapClickCompletion) {
        self.editTapClickCompletion();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor grayColor] : [UIColor whiteColor];
}

@end



@implementation AddressCellModel


@end


