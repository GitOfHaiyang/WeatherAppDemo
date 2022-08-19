//
//  YHYForecastItem.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/12.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "YHYForecastDaysItem.h"
#import "YHYWeatherData.h"

@implementation YHYForecastDaysItem

- (instancetype)initWithForecastDaysData:(NSArray *)ForecastDaysData{
    if(self = [super init]){
        //15天天气预报
        _tempDay = [NSMutableArray array];
        _tempNight = [NSMutableArray array];
        _conditionDay = [NSMutableArray array];
        _conditionNight = [NSMutableArray array];
        _popDay = [NSMutableArray array];
        _predictDate = [NSMutableArray array];
        _sunrise = [NSMutableArray array];
        _sunset = [NSMutableArray array];
        _uvi = [NSMutableArray array];
        _windDirDay = [NSMutableArray array];
        _windDirNight = [NSMutableArray array];
        _windSpeedDay = [NSMutableArray array];
        _windSpeedNight = [NSMutableArray array];
        _windLevelDay = [NSMutableArray array];
        _windLevelNight = [NSMutableArray array];
        _humidity = [NSMutableArray array];
        
        for(int i = 0; i < ForecastDaysData.count; i++){
            [_tempDay addObject:[ForecastDaysData[i] objectForKey:@"tempDay"]];
            [_tempNight addObject:[ForecastDaysData[i] objectForKey:@"tempNight"]];
            [_conditionDay addObject:[ForecastDaysData[i] objectForKey:@"conditionDay"]];
            [_conditionNight addObject:[ForecastDaysData[i] objectForKey:@"conditionNight"]];
            [_popDay addObject:[ForecastDaysData[i] objectForKey:@"pop"]];
            [_predictDate addObject:[ForecastDaysData[i] objectForKey:@"predictDate"]];
            [_windDirDay addObject:[ForecastDaysData[i] objectForKey:@"windDirDay"]];
            [_windDirNight addObject:[ForecastDaysData[i] objectForKey:@"windDirNight"]];
            [_windSpeedDay addObject:[ForecastDaysData[i] objectForKey:@"windSpeedDay"]];
            [_windSpeedNight addObject:[ForecastDaysData[i] objectForKey:@"windSpeedNight"]];
            [_windLevelDay addObject:[ForecastDaysData[i] objectForKey:@"windLevelDay"]];
            [_windLevelNight addObject:[ForecastDaysData[i] objectForKey:@"windLevelNight"]];
            [_humidity addObject:[ForecastDaysData[i] objectForKey:@"humidity"]];
            NSString *temp = [ForecastDaysData[i] objectForKey:@"sunrise"];
            temp = [temp substringWithRange:NSMakeRange(11, 5)];
            [_sunrise addObject:temp];
            temp = [ForecastDaysData[i] objectForKey:@"sunset"];
            temp = [temp substringWithRange:NSMakeRange(11, 5)];
            [_sunset addObject:temp];
        }
    }
    return self;
}


@end
