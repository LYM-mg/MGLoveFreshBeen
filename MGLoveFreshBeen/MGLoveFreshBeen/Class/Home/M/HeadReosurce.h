//
//  HeadReosurce.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HeadData;

#pragma mark - HeadReosurce
@interface HeadReosurce : NSObject

@property (nonatomic,copy) NSString *String;
@property (nonatomic,copy) NSString *reqid;
/** HeadData */
@property (nonatomic,strong) HeadData *data;

@end
#pragma mark - HeadData

@interface HeadData : NSObject

@property (nonatomic,copy) NSArray *focus;
@property (nonatomic,copy) NSArray *icons;
@property (nonatomic,copy) NSArray *activities;

@end

#pragma mark - Activities

@interface Activities : NSObject

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *topimg;
@property (nonatomic,copy) NSString *jptype;
@property (nonatomic,copy) NSString *trackid;
@property (nonatomic,copy) NSString *mimg;
@property (nonatomic,copy) NSString *customURL;

@end