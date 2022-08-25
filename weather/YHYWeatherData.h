//
//  YHYWeatherData.h
//  HomePwner
//
//  Created by ByteDance on 2022/8/10.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YHYForecastHoursItem;
@class YHYForecastDaysItem;
@class YHYLiveItem;

@protocol weatherDataDelegate <NSObject>

- (void) hoursData:(YHYForecastHoursItem *) hoursItem;
- (void) daysData:(YHYForecastDaysItem *) daysItem;
- (void) liveData:(YHYLiveItem *) liveItem;

@end

//@protocol YHYHoursDataDelegate <NSObject>
//
//- (void) hoursData:(YHYForecastHoursItem *) hoursItem;
//
//@end
//
//@protocol YHYDaysDataDelegate <NSObject>
//
//- (void) daysData:(YHYForecastDaysItem *) daysItem;
//
//@end
//
//@protocol YHYLiveDataDelegate <NSObject>
//
//- (void) liveData:(YHYLiveItem *) liveItem;
//
//@end

typedef NS_ENUM(char, forecastDataEnum){
    forecastDays,
    forecastHours,
    weatherLive,
    lifeIndex
};

@class YHYCityItem;
@class YHYForecastDaysItem;
@class YHYForecastHoursItem;
@class YHYLiveItem;
@class YHYLifeIndexItem;
@interface YHYWeatherData : NSObject
//设置委托者
@property (nonatomic, weak) id<weatherDataDelegate> dataDelegate;
//@property (nonatomic, weak) id<YHYHoursDataDelegate> hoursDelegate;
//@property (nonatomic, weak) id<YHYDaysDataDelegate> daysDelegate;
//@property (nonatomic, weak) id<YHYLiveDataDelegate> liveDelegate;

//- (instancetype) initWithCityName:(NSString *)name
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


//内部用
@property (nonatomic, copy) NSDictionary *YHYAllData;
@property (nonatomic, copy) NSDictionary *YHYCityData;
@property (nonatomic, copy) NSDictionary *YHYWeatherLiveData;


@property (nonatomic, copy) NSArray *YHYForecastDaysData;
@property (nonatomic, copy) NSArray *YHYForecastHoursData;
@property (nonatomic, copy) NSArray *YHYLifeIndexData;


@property (nonatomic) forecastDataEnum forecastData;

+ (instancetype)sharedInstance;

- (void)refreshWeatherData:(NSString *)cityId;

@end

NS_ASSUME_NONNULL_END
