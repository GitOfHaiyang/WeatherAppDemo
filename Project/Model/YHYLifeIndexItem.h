//
//  YHYLifeIndexItem.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/14.
//  Copyright © 2022 yhy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHYLifeIndexItem : NSObject
///指数代码
@property (nonatomic, strong) NSString *code;
///日期
@property (nonatomic, strong) NSString *day;
///描述
@property (nonatomic, strong) NSString *desc;
///等级
@property (nonatomic, strong) NSString *level;
///指数名称
@property (nonatomic, strong) NSString *name;
///状态
@property (nonatomic, strong) NSString *status;
///更新时间
@property (nonatomic, strong) NSString *updatetime;

@end

NS_ASSUME_NONNULL_END
