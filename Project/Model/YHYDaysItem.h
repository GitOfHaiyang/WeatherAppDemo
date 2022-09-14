//
//  YHYDaysItem.h
//  WeatherDemo
//
//  Created by ByteDance on 2022/9/1.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHYDaysItem : NSObject

//白天最高温度
@property (nonatomic, strong) NSString *tempDay;
//夜间最低温度
@property (nonatomic, strong) NSString *tempNight;
//白天天气
@property (nonatomic, strong) NSString *conditionDay;
//夜间天气
@property (nonatomic, strong) NSString *conditionNight;
//降水概率
@property (nonatomic, strong) NSString *pop;
//预测日期
@property (nonatomic, strong) NSString *predictDate;

@property (nonatomic, strong) NSString *sunrise;

@property (nonatomic, strong) NSString *sunset;

@property (nonatomic, strong) NSString *uvi;

@property (nonatomic, strong) NSString *windDirDay;

@property (nonatomic, strong) NSString *windDirNight;

@property (nonatomic, strong) NSString *windSpeedDay;

@property (nonatomic, strong) NSString *windSpeedNight;

@property (nonatomic, strong) NSString *windLevelDay;

@property (nonatomic, strong) NSString *windLevelNight;
//湿度
@property (nonatomic, strong) NSString *humidity;

@end

NS_ASSUME_NONNULL_END
