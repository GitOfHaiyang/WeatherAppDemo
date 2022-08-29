//
//  BaseforecastSevenDaysVC.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/11.
//  Copyright © 2022 yhy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@class YHYWeatherData;

@interface BaseforecastSevenDaysVC : UIViewController
@property (nonatomic, strong) UILabel *dateLabel;
//天气Label
@property (nonatomic, strong) UILabel *conditionLabel;
//降雨Label
@property (nonatomic, strong) UILabel *popLabel;
//温度Label
@property (nonatomic, strong) UILabel *tempLabel;
//白天最高温度label
@property (nonatomic, strong) UILabel *tempDayLabel;
//夜晚最低温度label
@property (nonatomic, strong) UILabel *tempNightLabel;
//
//@property (nonatomic, strong) YHYWeatherData* forecastData;
@end

NS_ASSUME_NONNULL_END
