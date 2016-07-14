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
    // 如果_cellHeight有值就返回（其实这就是懒加载，为性能着想）
    if (_cellHeight) return _cellHeight;
    
    _cellHeight += MGMargin;
    
    NSInteger count = self.texts.count;
    
    CGSize MaxSize = CGSizeMake(MGSCREEN_width - 40, MAXFLOAT);
    for (int i = 0; i<count; i++) {
        NSString *str = self.texts[i];
        //  根据计算得出  HEIGHT
        CGFloat rowHeight  = [str boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size.height;
        
        _cellHeight += rowHeight;
        _cellHeight +=  MGMargin;
        [self.everyRowHeight addObject:@(rowHeight)];
    }
    return _cellHeight;
}


- (NSMutableArray *)everyRowHeight{
    if (_everyRowHeight == nil) {
        _everyRowHeight = [NSMutableArray array];
    }
    return _everyRowHeight;
}

@end
