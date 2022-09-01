//
//  YHYHoursItem.h
//  WeatherDemo
//
//  Created by ByteDance on 2022/9/1.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHYHoursItem : NSObject
///天气
@property (nonatomic, strong) NSString *condition;
///天气Id
@property (nonatomic, strong) NSString *conditionId;
///日期
@property (nonatomic, strong) NSString *date;
///小时
@property (nonatomic, strong) NSString *hour;
///湿度
@property (nonatomic, strong) NSString *humidity;

@property (nonatomic, strong) NSString *iconDay;

@property (nonatomic, strong) NSString *iconNight;

@property (nonatomic, strong) NSString *pop;

@property (nonatomic, strong) NSString *pressure;
///未来一小时降水预报，单位mm
@property (nonatomic, strong) NSString *qpf;
///体感温度
@property (nonatomic, strong) NSString *realFeel;
///降雪量
@property (nonatomic, strong) NSString *snow;
///实时温度
@property (nonatomic, strong) NSString *temp;

@property (nonatomic, strong) NSString *updatetime;

@property (nonatomic, strong) NSString *uvi;
///风向角度，单位度
@property (nonatomic, strong) NSString *windDegrees;
///风向
@property (nonatomic, strong) NSString *windDir;
///风速 单位：km/h
@property (nonatomic, strong) NSString *windSpeed;
///风力等级
@property (nonatomic, strong) NSString *windlevel;


@end

NS_ASSUME_NONNULL_END
