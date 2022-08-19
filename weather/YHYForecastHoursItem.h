//
//  YHYForecastHoursItem.h
//  HomePwner
//
//  Created by ByteDance on 2022/8/12.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHYForecastHoursItem : NSObject
//温度
@property (nonatomic, strong) NSMutableArray<NSString *> *tempHour;
//天气
@property (nonatomic, strong) NSMutableArray<NSString *> *conditionHour;
//降水概率
@property (nonatomic, strong) NSMutableArray<NSString *> *popHour;
//时间（单位：h)
@property (nonatomic, strong) NSMutableArray<NSString *> *timeHour;
//天气icon
@property (nonatomic, strong) NSMutableArray<NSString *> *iconDayHour;

@property (nonatomic, strong) NSMutableArray<NSString *> *iconNightHour;

- (instancetype)initWithForecastHoursData:(NSArray *)ForecastHoursData;
@end

NS_ASSUME_NONNULL_END
