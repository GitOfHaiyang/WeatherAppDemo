//
//  commonDefine.h
//  HomePwner
//
//  Created by ByteDance on 2022/8/16.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#ifndef commonDefine_h
#define commonDefine_h

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height

#define weakify(object) __weak __typeof__(object) weak##object = object;
#define strongify(object) __strong __typeof__(object) object = weak##object;

#define urlForecast15days @"/whapi/json/alicityweather/forecast15days"
#define urlTokenForecast15days @"f9f212e1996e79e0e602b08ea297ffb0"

#define urlForecast24hours @"/whapi/json/alicityweather/forecast24hours"
#define urlTokenForecast24hours @"008d2ad9197090c5dddc76f583616606"

#define urlweatherLive @"/whapi/json/alicityweather/condition"
#define urlTokenweatherLive @"50b53ff8dd7d9fa320d3d3ca32cf8ed1"

#define urlBgImageDay @"https://s3.us-west-2.amazonaws.com/images.unsplash.com/application-1660485977938-9fb0fcaf9bb6image"
#define urlBgImageNight @"https://s3.us-west-2.amazonaws.com/images.unsplash.com/application-1660485958312-fd5422c212c1image"
#define urlbgImageLive @"https://s3.us-west-2.amazonaws.com/images.unsplash.com/application-1660563562784-7212e2789bccimage"

#endif /* commonDefine_h */
