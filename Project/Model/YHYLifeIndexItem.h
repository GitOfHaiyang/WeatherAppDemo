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

@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSMutableArray<NSString *> *desc;
@property (nonatomic, strong) NSMutableArray<NSString *> *name;
@property (nonatomic, strong) NSMutableArray<NSString *> *status;
@property (nonatomic, strong) NSMutableArray<NSString *> *code;
- (instancetype)initwithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
