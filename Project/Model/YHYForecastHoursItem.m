//
//  YHYForecastHoursItem.m
//  WeatherDemo
//
//  Created by yhy on 2022/8/12.
//  Copyright © 2022 yhy. All rights reserved.
//

#import "YHYForecastHoursItem.h"

@implementation YHYForecastHoursItem

- (instancetype)initWithForecastHoursData:(NSArray *)ForecastHoursData{
    if(self = [super init]){
        _tempHour = [NSMutableArray array];
        _conditionHour = [NSMutableArray array];
        _popHour = [NSMutableArray array];
        _timeHour = [NSMutableArray array];
        _iconDayHour = [NSMutableArray array];
        _iconNightHour = [NSMutableArray array];
        for( int i = 0; i < ForecastHoursData.count; i++){
            [_tempHour addObject:[ForecastHoursData[i] objectForKey:@"temp"]];
            [_conditionHour addObject:[ForecastHoursData[i] objectForKey:@"condition"]];
            [_popHour addObject:[ForecastHoursData[i] objectForKey:@"pop"]];
            [_timeHour addObject:[ForecastHoursData[i] objectForKey:@"hour"]];
            [_iconDayHour addObject:[ForecastHoursData[i] objectForKey:@"iconDay"]];
            [_iconNightHour addObject:[ForecastHoursData[i] objectForKey:@"iconNight"]];
        }
        
    }
    return self;
}

@end
