//
//  YHYCityItem.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/11.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//
#import "YHYCityItem.h"

@implementation YHYCityItem

- (instancetype)initWithCityDictionary:(NSDictionary *)cityDictionary{
    if(self = [super init]){
        _name = [cityDictionary objectForKey:@"name"];
        _pname = [cityDictionary objectForKey:@"pname"];
        _ianatimezone = [cityDictionary objectForKey:@"ianatimezone"];
        _counname = [cityDictionary objectForKey:@"counname"];
        _timezone = [cityDictionary objectForKey:@"timezone"];
        _secondaryname = [cityDictionary objectForKey:@"secondaryname"];
        _cityId = [cityDictionary objectForKey:@"cityId"];
    }
    return self;
}

- (instancetype)init{
    [NSException raise:@"WallSafeInitilization" format:@"Use initWithCityDictionary:, not init"];
    return self;
}

@end
