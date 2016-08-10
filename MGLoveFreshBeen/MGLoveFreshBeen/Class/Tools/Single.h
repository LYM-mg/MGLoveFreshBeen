//
//  Single.h
//  01-掌握-单例ARC
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#define interfaceSingle(name)  + (instancetype)share##name

#if __has_feature(objc_arc)
// 如果是ARC
#define implementationSingle(name)  + (instancetype)share##name \
{ \
    return [[self alloc] init]; \
} \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}
#else
// 如果不是ARC
#define implementationSingle(name)  + (instancetype)share##name \
{ \
return [[self alloc] init]; \
} \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
return _instance; \
}\
- (oneway void)release \
{} \
- (instancetype)retain \
{ \
    return _instance; \
} \
- (NSUInteger)retainCount \
{ \
    return MAXFLOAT; \
}
#endif