//
//  YHYForecastItem.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/12.
//  Copyright © 2022 yhy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHYForecastDaysItem : NSObject
//白天最高温度
@property (nonatomic, strong) NSMutableArray<NSString *> *tempDay;
//夜间最低温度
@property (nonatomic, strong) NSMutableArray<NSString *> *tempNight;
//白天天气
@property (nonatomic, strong) NSMutableArray<NSString *> *conditionDay;
//夜间天气
@property (nonatomic, strong) NSMutableArray<NSString *> *conditionNight;
//降水概率
@property (nonatomic, strong) NSMutableArray<NSString *> *popDay;
//预测日期
@property (nonatomic, strong) NSMutableArray<NSString *> *predictDate;

@property (nonatomic, strong) NSMutableArray<NSString *> *sunrise;

@property (nonatomic, strong) NSMutableArray<NSString *> *sunset;

@property (nonatomic, strong) NSMutableArray<NSString *> *uvi;

@property (nonatomic, strong) NSMutableArray<NSString *> *windDirDay;

@property (nonatomic, strong) NSMutableArray<NSString *> *windDirNight;

@property (nonatomic, strong) NSMutableArray<NSString *> *windSpeedDay;

@property (nonatomic, strong) NSMutableArray<NSString *> *windSpeedNight;

@property (nonatomic, strong) NSMutableArray<NSString *> *windLevelDay;

@property (nonatomic, strong) NSMutableArray<NSString *> *windLevelNight;
//湿度
@property (nonatomic, strong) NSMutableArray<NSString *> *humidity;



- (instancetype)initWithForecastDaysData:(NSArray *)ForecastDaysData;
@end

NS_ASSUME_NONNULL_END
