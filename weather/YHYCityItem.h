//
//  YHYCityItem.h
//  HomePwner
//
//  Created by ByteDance on 2022/8/11.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHYCityItem : NSObject

@property (nonatomic, copy) NSNumber *cityId;
@property (nonatomic, copy) NSString *counname;
@property (nonatomic, copy) NSString *ianatimezone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pname;
@property (nonatomic, copy) NSString *secondaryname;
@property (nonatomic, copy) NSString *timezone;

- (instancetype)initWithCityDictionary:(NSDictionary *)cityDictionary;

@end

NS_ASSUME_NONNULL_END
