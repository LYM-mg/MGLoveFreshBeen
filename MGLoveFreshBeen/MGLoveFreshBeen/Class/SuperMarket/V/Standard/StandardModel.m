//
//  StandardModel.m
//  LanDouS
//
//  Created by Wangjc on 16/2/24.
//  Copyright © 2016年 Mao-MacPro. All rights reserved.
//

#import "StandardModel.h"

@implementation standardClassInfo

+(instancetype)StandardClassInfoWith:(NSString *)classId andStandClassName:(NSString *)className
{

    return [[self alloc]initWithClassId:classId andStandClassName:className];
}

-(instancetype)initWithClassId:(NSString *)classId andStandClassName:(NSString *)className
{
    self = [super init];
    
    if (self) {
        
        self.standardClassId = classId;
        self.standardClassName = className;
        
    }
    
    return self;
}

-(void)setStandardClassId:(NSString *)standardClassId
{
    _standardClassId = [NSString stringWithFormat:@"%@",standardClassId];
}

@end

@implementation StandardModel


+(instancetype)StandardModelWith:(NSArray<standardClassInfo *>*)classinfo andStandName:(NSString *)standName
{
    return [[self alloc] initWithClassInfo:classinfo andStandName:standName];
}

-(instancetype)initWithClassInfo:(NSArray<standardClassInfo *> *)classinfo andStandName:(NSString *)standName
{
    self = [super init];
    
    if(self)
    {
        self.standardClassInfo = classinfo;
        self.standardName = standName;
        
    }
    return self;
}



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com