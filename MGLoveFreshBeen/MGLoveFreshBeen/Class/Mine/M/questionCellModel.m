//
//  questionCellModel.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "questionCellModel.h"

@implementation questionCellModel

+ (instancetype)questionModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (CGFloat)cellHeight{
    NSInteger count = self.texts.count;
    
    CGSize MaxSize = CGSizeMake(MGSCREEN_width - 2*MGMargin, MAXFLOAT);
    for (int i = 0; i<count; i++) {
        NSString *str = self.texts[i];
        //  根据计算得出  HEIGHT
        CGFloat rowHeight  = [str boundingRectWithSize:MaxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size.height;
        _cellHeight += rowHeight;
        [self.everyRowHeight addObject:@(rowHeight)];
//        MGLog(@"%@",NSStringFromCGRect([str boundingRectWithSize:MaxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil]));
    }
//    MGLog(@"%lf",_cellHeight);
    return _cellHeight;
}

- (NSMutableArray *)everyRowHeight{
    if (_everyRowHeight == nil) {
        _everyRowHeight = [NSMutableArray array];
    }
    return _everyRowHeight;
}

@end
