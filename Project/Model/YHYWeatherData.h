//
//  YHYWeatherData.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/10.
//  Copyright © 2022 yhy. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "commonDefine.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^daysBlock) (NSArray *daysArray);
@class YHYCityItem,YHYLiveItem,YHYLifeIndexItem;
@class YHYDaysItem;
@class YHYHoursItem;

@protocol weatherDataDelegate <NSObject>

- (void) hoursData:(NSArray *) hoursArray;
- (void) daysData:(NSArray *) daysArray;
- (void) liveData:(YHYLiveItem *) liveItem;
- (void) lifeIndexData:(NSArray *) lifeIndexArray;

@end

typedef NS_ENUM(char, forecastDataEnum){
    forecastDays,
    forecastHours,
    weatherLive,
    lifeIndex
};

@interface YHYWeatherData : NSObject
////回调block
@property (nonatomic, weak) daysBlock dataBlock;
//设置委托者
@property (nonatomic, weak) id<weatherDataDelegate> dataDelegate;
///city信息
@property (nonatomic, strong) YHYCityItem* cityItem;
///未来15天信息
@property (nonatomic, strong) NSArray<YHYDaysItem *> *daysArray;
///未来24小时信息
@property (nonatomic, strong) NSArray<YHYHoursItem *> *hoursArray;
///实况信息
@property (nonatomic, strong) YHYLiveItem *liveItem;
///生活指数
@property (nonatomic, strong) NSArray<YHYLifeIndexItem *> *lifeIndexArray;

//本地存储天气数据的路径
@property (nonatomic, strong) NSString *cityID;

@property (nonatomic, strong) NSString *YHYForecastDaysPath;

@property (nonatomic, strong) NSString *YHYForecastHoursPath;

@property (nonatomic, strong) NSString *YHYWeatherLivePath;

@property (nonatomic, strong) NSString *YHYLifeIndexPath;

@property (nonatomic) forecastDataEnum forecastData;

singleH(YHYWeatherData)

- (void)refreshWeatherData:(NSString *)cityId;

- (void)sendWeatherData:(YHYWeatherData *)data;

@end

NS_ASSUME_NONNULL_END
