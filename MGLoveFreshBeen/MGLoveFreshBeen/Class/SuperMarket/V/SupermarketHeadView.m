//
//  SupermarketHeadView.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "SupermarketHeadView.h"

@interface SupermarketHeadView ()

@end

@implementation SupermarketHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = MGRGBColor(240, 240, 240);
        [self build_titleLabel];

    }
    return self;
}

- (void)build_titleLabel{
    _titleLabel = [UILabel new];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = MGFont(13);
    _titleLabel.textColor = MGRGBColor(100, 100, 100);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(MGMargin, 0, self.width - MGMargin, self.height);
}


@end
