//
//  QuestionCell.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "QuestionCell.h"
#import "questionCellModel.h"

@interface QuestionCell ()

/** cellHight */
/** 数组 */
@property (nonatomic,strong)  NSMutableArray *labArr;

/** <#注释#> */
@property (nonatomic,weak) UILabel *lastLabel;
@end

@implementation QuestionCell

- (NSMutableArray *)labArr{
    if (_labArr == nil) {
        _labArr = [NSMutableArray array];
    }
    return _labArr;
}

- (void)awakeFromNib {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *questionLabel = [[UILabel alloc] init];
        self.questionLabel.numberOfLines = 0;
//        questionLabel.adjustsFontSizeToFitWidth = YES;
//        questionLabel.minimumScaleFactor = 0.5;
        [self.contentView addSubview:questionLabel];
        self.questionLabel = questionLabel;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self caclueCellHeight];
}

- (void)setModel:(questionCellModel *)model{
    _model = model;
    
    NSInteger count = model.texts.count;
    for (int i = 0; i<count; i++) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.text = model.texts[i];
        textLabel.numberOfLines = 0;
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:textLabel];
        [self.labArr addObject:textLabel];
    }
    model.cellHeight = self.contentView.height;
}


- (CGFloat)caclueCellHeight{
    NSInteger count = _model.texts.count;
    CGSize MaxSize = CGSizeMake(MGSCREEN_width - 2*MGMargin, MAXFLOAT);
    for (int i = 0; i<count; i++) {
        UILabel *textLabel = [self.labArr objectAtIndex:i];
        textLabel.text = _model.texts[i];
        textLabel.numberOfLines = 0;
        textLabel.backgroundColor = MGRandomColor;
        //  根据计算得出  HEIGHT
        CGFloat height  = [textLabel.text boundingRectWithSize:MaxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
        CGFloat y = CGRectGetMaxY(self.lastLabel.frame);
        textLabel.frame = CGRectMake(MGMargin, y  , MGSCREEN_width - 2*MGMargin, height);
        self.lastLabel = textLabel;
        self.contentView.height += height;
    }
    return self.height += MGMargin;
//    UILabel *lastLabel = [self.labArr lastObject];
//   return  CGRectGetMaxY(lastLabel.frame) + 2 * MGMargin;
}

@end

@implementation MGModel


@end
