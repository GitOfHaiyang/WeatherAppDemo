//
//  commonDefine.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/16.
//  Copyright © 2022 yhy. All rights reserved.
//

#ifndef commonDefine_h
#define commonDefine_h

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height

#define YHYweakify(object) __weak __typeof__(object) weak##object = object;
#define YHYstrongify(object) __strong __typeof__(object) object = weak##object;

#define mojiAPIAppcode @"20bc090be5de4127936e249baa57797d"
#define urlForecast15days @"/whapi/json/alicityweather/forecast15days"
#define urlTokenForecast15days @"f9f212e1996e79e0e602b08ea297ffb0"

#define urlForecast24hours @"/whapi/json/alicityweather/forecast24hours"
#define urlTokenForecast24hours @"008d2ad9197090c5dddc76f583616606"

#define urlWeatherLive @"/whapi/json/alicityweather/condition"
#define urlTokenWeatherLive @"50b53ff8dd7d9fa320d3d3ca32cf8ed1"

#define urlLifeIndex @"/whapi/json/alicityweather/index"
#define urlTokenLifeIndex @"5944a84ec4a071359cc4f6928b797f91"

#define urlBgImageDay @"https://s3.us-west-2.amazonaws.com/images.unsplash.com/application-1660485977938-9fb0fcaf9bb6image"
#define urlBgImageNight @"https://s3.us-west-2.amazonaws.com/images.unsplash.com/application-1660485958312-fd5422c212c1image"
#define urlbgImageLive @"https://s3.us-west-2.amazonaws.com/images.unsplash.com/application-1660485942921-0a531ef385beimage"

#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HexToRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]/// rgb颜色转换（16进制->10进制）
///

///单例模式
#define singleH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)

#define singleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
\
+(instancetype)share##name\
{\
    return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
    return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
    return _instance;\
}

#else
#define singleM static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shareTools\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
    return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
    return MAXFLOAT;\
}
#endif

#endif /* commonDefine_h */
