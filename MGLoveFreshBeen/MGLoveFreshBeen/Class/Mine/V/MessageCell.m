//
//  MessageCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"


@interface MessageCell ()
/** titleView */
@property (nonatomic,weak) UIView *titleView;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UIView *subTitleView;
@property (nonatomic,weak) UILabel *subTitleLabel;
@property (nonatomic,weak) UIView *lineView;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic,weak) UITableView *tableView;
@end

@implementation MessageCell

static NSString *const KMessageCellIdentifier = @"KMessageCellIdentifier";

+ (instancetype)messageCellWitnTableView:(UITableView *)tableView{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:KMessageCellIdentifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMessageCellIdentifier];
        cell.tableView = tableView;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:titleView];
    self.titleView = titleView;

    UILabel *titleLabel = [UILabel new];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = MGFont(15);
    [titleView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.2;
    [titleView addSubview:lineView];
    _lineView = lineView;
    
    UIView *subTitleView = [[UIView alloc] init];
    subTitleView.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:subTitleView];
    _subTitleView = subTitleView;
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.numberOfLines = 0;
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor = [UIColor lightGrayColor];
    subTitleLabel.font = MGFont(12);
    [subTitleView addSubview:subTitleLabel];
    _subTitleLabel = subTitleLabel;
}


// 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    _titleView.frame = CGRectMake(0, 0, self.contentView.width, 44);
    _titleLabel.frame = CGRectMake(20, 0, self.contentView.width - 40, 44);
    _lineView.frame = CGRectMake(20, 43, self.contentView.width - 20, 1);
    
    _subTitleLabel.numberOfLines = 0;
    CGFloat textMaxW = MGSCREEN_width - 2 * MGMargin;
    CGFloat height = [_subTitleLabel.text boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    _subTitleView.frame = CGRectMake(0,CGRectGetMaxY(_titleView.frame), self.contentView.width, height + MGMargin*0.5);
    _subTitleLabel.frame = CGRectMake(20,MGMargin, self.contentView.width - 40, height);
}

// 重写模型
- (void)setModel:(MessageModel *)model{
    _model = model;
    _titleLabel.text = model.title;
    _subTitleLabel.text = model.content;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:model.content];
    NSMutableParagraphStyle *attStyle = [[NSMutableParagraphStyle alloc] init];
    attStyle.lineSpacing = 5.0;
    CGFloat leng = (int)(MGSCREEN_width - 40);
    if (attStr.length < leng) {
        leng = attStr.length;
    }
    
    [attStr addAttribute:NSParagraphStyleAttributeName value:attStyle range:NSMakeRange(0, leng)];
    
    _subTitleLabel.numberOfLines = 0;
    _subTitleLabel.attributedText = attStr;
    [_subTitleLabel sizeToFit];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
