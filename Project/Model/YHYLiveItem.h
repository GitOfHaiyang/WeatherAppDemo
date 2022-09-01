//
//  YHYLiveItem.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/14.
//  Copyright © 2022 yhy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHYLiveItem : NSObject

@property (nonatomic, copy) NSString *condition;
@property (nonatomic, copy) NSString *conditionId;
@property (nonatomic, copy) NSString *humidity;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *pressure;
@property (nonatomic, copy) NSString *realFeel;
@property (nonatomic, copy) NSString *sunRise;
@property (nonatomic, copy) NSString *sunSet;
@property (nonatomic, copy) NSString *temp;
@property (nonatomic, copy) NSString *tips;
@property (nonatomic, copy) NSString *updatetime;

@property (nonatomic, copy) NSString *uvi;
@property (nonatomic, copy) NSString *vis;
@property (nonatomic, copy) NSString *windDegrees;
@property (nonatomic, copy) NSString *windDir;
@property (nonatomic, copy) NSString *windLevel;
@property (nonatomic, copy) NSString *windSpeed;




@end

NS_ASSUME_NONNULL_END
