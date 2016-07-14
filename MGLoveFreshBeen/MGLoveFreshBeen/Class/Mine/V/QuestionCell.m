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
          self.userInteractionEnabled = NO;
//        UILabel *questionLabel = [[UILabel alloc] init];
//        self.questionLabel.numberOfLines = 0;
//        questionLabel.numberOfLines = 30;
//        questionLabel.adjustsFontSizeToFitWidth = YES;
//        questionLabel.minimumScaleFactor = 0.5;
//        questionLabel.textColor = [UIColor grayColor];
//        questionLabel.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:questionLabel];
       
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.labArr.count) {
        NSInteger count = _questionModel.texts.count;
        
        for (int i = 0; i<count; i++) {
            UILabel *textLabel = [self.labArr objectAtIndex:i];
            textLabel.numberOfLines = 0;

            CGFloat y = CGRectGetMaxY(self.lastLabel.frame) + MGMargin;
            textLabel.frame = CGRectMake(2*MGMargin, y  , MGSCREEN_width - 4*MGMargin, [self.questionModel.everyRowHeight[i] integerValue]);
            self.lastLabel = textLabel;
        }
    }
}

- (void)setQuestionModel:(questionCellModel *)questionModel{
    _questionModel = questionModel;
    
    NSInteger count = _questionModel.texts.count;
    for (int i = 0; i<count; i++) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.text = _questionModel.texts[i];
        textLabel.numberOfLines = 0;
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:textLabel];
        [self.labArr addObject:textLabel];
    }
}


@end

@implementation MGModel


@end
