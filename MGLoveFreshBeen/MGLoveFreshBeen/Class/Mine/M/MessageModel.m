//
//  MessageModel.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MessageModel.h"

CGFloat titleViewH = 60;

@implementation MessageModel

- (CGFloat)cellHeight{
    // 如果_cellHeight有值就返回（其实这就是懒加载，为性能着想）
    if (_cellHeight) return _cellHeight;

    /******************titleView高度************************/
    _cellHeight = titleViewH;
    
    /******************正文高度************************/
    CGFloat textMaxW = MGSCREEN_width - 2 * MGMargin;
    CGFloat height = [self.content boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height + MGMargin;
 
    _cellHeight += height;
    
    return _cellHeight;
}
//
//- (CGFloat)subTitleViewHeightNomarl{
//    return 60 + 60 + 20;
//}

//- (void)setCellHeight:(CGFloat)cellHeight{
//    cellHeight = 60 + 60 + 20;
//}
//
//- (void)subTitleViewHeightNomarl:(CGFloat)subTitleViewHeightNomarl{
//    subTitleViewHeightNomarl = 60;
//}

@end
