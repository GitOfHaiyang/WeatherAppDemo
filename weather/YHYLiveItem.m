//
//  YHYLiveItem.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/14.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "YHYLiveItem.h"

@implementation YHYLiveItem

- (instancetype)initWithLiveDictionary:(NSDictionary *)liveDictionary {
    if(self = [super init]){
        _condition = [liveDictionary objectForKey:@"condition"];
        _conditionId = [liveDictionary objectForKey:@"conditionId"];
        _humidity = [liveDictionary objectForKey:@"humidity"];
        _icon = [liveDictionary objectForKey:@"icon"];
        _pressure = [liveDictionary objectForKey:@"pressure"];
        _realFeel = [liveDictionary objectForKey:@"realFeel"];
        _sunRise = [liveDictionary objectForKey:@"sunRise"];
        _sunSet = [liveDictionary objectForKey:@"sunSet"];
        _temp = [liveDictionary objectForKey:@"temp"];
        _tips = [liveDictionary objectForKey:@"tips"];
        _updatetime = [liveDictionary objectForKey:@"updatetime"];
        _uvi = [liveDictionary objectForKey:@"uvi"];
        _windDir = [liveDictionary objectForKey:@"windDir"];
        _windLevel = [liveDictionary objectForKey:@"windLevel"];
        _windSpeed = [liveDictionary objectForKey:@"windSpeed"];
        
    }
    return self;
}

- (instancetype)init{
    [NSException raise:@"WallSafeInitilization" format:@"Use initWithLiveDictionary:, not init"];
    return self;
}

@end
