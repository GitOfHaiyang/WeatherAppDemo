//
//  YHYWeatherData.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/10.
//  Copyright © 2022 yhy. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YHYCityItem,YHYForecastHoursItem,YHYForecastDaysItem,YHYLiveItem,YHYLifeIndexItem;

@protocol weatherDataDelegate <NSObject>

- (void) hoursData:(YHYForecastHoursItem *) hoursItem;
- (void) daysData:(YHYForecastDaysItem *) daysItem;
- (void) liveData:(YHYLiveItem *) liveItem;
- (void) lifeIndexData:(YHYLifeIndexItem*) lifeIndexItem;

@end

typedef NS_ENUM(char, forecastDataEnum){
    forecastDays,
    forecastHours,
    weatherLive,
    lifeIndex
};

@interface YHYWeatherData : NSObject
//设置委托者
@property (nonatomic, weak) id<weatherDataDelegate> dataDelegate;
//存city信息
@property (nonatomic, strong) YHYCityItem* cityItem;
//存预测未来15天信息
@property (nonatomic, strong) YHYForecastDaysItem *forecastDaysItem;
//存预测未来24小时信息
@property (nonatomic, strong) YHYForecastHoursItem *forecastHoursItem;
@property (nonatomic, strong) YHYLiveItem *liveItem;
@property (nonatomic, strong) YHYLifeIndexItem *lifeIndexItem;

//本地存储天气数据的路径
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *YHYForecastDaysPath;
@property (nonatomic, strong) NSString *YHYForecastHoursPath;
@property (nonatomic, strong) NSString *YHYWeatherLivePath;
@property (nonatomic, strong) NSString *YHYLifeIndexPath;

@property (nonatomic) forecastDataEnum forecastData;

+ (instancetype)sharedInstance;

- (void)refreshWeatherData:(NSString *)cityId;

@end

NS_ASSUME_NONNULL_END
