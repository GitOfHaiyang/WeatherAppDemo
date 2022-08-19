//
//  YHYWeatherData.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/10.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "YHYWeatherData.h"
#import "YHYCityItem.h"
#import "YHYForecastDaysItem.h"
#import "YHYForecastHoursItem.h"
#import "YHYLiveItem.h"
#import "YHYLifeIndexItem.h"
#import "commonDefine.h"
//#import "AFNetworking.h"


@implementation YHYWeatherData

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithCityId:(NSString *)cityId {
    [self cityWriteToPList];
    [self refreshWeatherData:cityId];
    return self;
}

- (instancetype)init {
    return [self initWithCityId:@"50"];
}

- (void)refreshWeatherData:(NSString *)cityId {
    _cityID = cityId;
    /* https://market.aliyun.com/products/57096001/cmapi013828.html?spm=5176.2020520132.101.2.a77d72187hOy5U#sku=yuncode782800000 */
    //15天天气预报
    [self obtainWeatherData:_cityID
                    urlPath:urlForecast15days
                   urlToken:urlTokenForecast15days
                kindOfData:forecastDays];
    
    //24小时天气
    [self obtainWeatherData:_cityID
                    urlPath:urlForecast24hours
                   urlToken:urlTokenForecast24hours
                 kindOfData:forecastHours];
    //天气实况
    [self obtainWeatherData:_cityID
                    urlPath:urlweatherLive
                   urlToken:urlTokenweatherLive
                 kindOfData:weatherLive];
        
    NSDictionary  *dict=[[NSDictionary alloc]initWithObjects:@[self] forKeys:@[@"weatherData"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Data" object:nil userInfo:dict];
}
//将name转为CityID，需录入城市数据并做匹配
//也可根据定位的经纬度来匹配城市ID
- (void)nameTransferToCityID:(NSString *)name{
    
}

- (void)obtainWeatherData:(NSString *)cityID
                  urlPath:(NSString *)path
                 urlToken:(NSString *)token
               kindOfData:(forecastDataEnum)forecastData {
    //from mojiAPI
    NSString *appcode = @"20bc090be5de4127936e249baa57797d";
    NSString *host = @"https://aliv18.mojicb.com";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@", host, path, querys];
    NSString *bodys = [NSString stringWithFormat:@"cityId=%@&token=%@", cityID, token];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]
                                                           cachePolicy:1
                                                       timeoutInterval:5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" , appcode]  forHTTPHeaderField:  @"Authorization"];
    [request addValue: @"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    weakify(self);
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body ,
                                                                       NSURLResponse * _Nullable response,
                                                                       NSError * _Nullable error) {
        if(error){
            @throw [NSException exceptionWithName:NSGenericException
                                           reason:@"--------request Session failed----------"
                                         userInfo:nil];
        }
        else{
            strongify(self);
            NSLog(@"Response object: %@" , response);
            //json转化为字符串
            NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
            NSLog(@"Response body: %@" , bodyString);
            //字符串再生成NSData
            NSData * myData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
            //再解析为NSDictionary
            NSDictionary *AllData = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableLeaves error:nil];
            //存储到本地
            if(forecastData == forecastDays){
                _YHYForecastDaysPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                _YHYForecastDaysPath = [_YHYForecastDaysPath stringByAppendingString:@"/forecastDaysDict.plist"];
                [AllData writeToFile:_YHYForecastDaysPath atomically:YES];
                NSLog(@"forecastDays path : %@", self.YHYForecastDaysPath);
                NSDictionary *data = [AllData objectForKey:@"data"];
                _YHYCityData = [data objectForKey:@"city"];
                _YHYForecastDaysData = [data objectForKey:@"forecast"];
                _cityItem = [[YHYCityItem alloc] initWithCityDictionary:_YHYCityData];
                _forecastDaysItem = [[YHYForecastDaysItem alloc] initWithForecastDaysData:_YHYForecastDaysData];
                NSLog(@"----City测试用：name: %@, pname: %@", _cityItem.name, _cityItem.pname);
                NSLog(@"----forecastDay测试用：condition: %@, pop: %@", _forecastDaysItem.conditionDay[0], _forecastDaysItem.popDay[0]);
                if ([self.dataDelegate respondsToSelector:@selector((daysData:))]) {
                    [self.dataDelegate daysData:_forecastDaysItem];
                }
            }
            else if(forecastData == forecastHours){
                _YHYForecastHoursPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                _YHYForecastHoursPath = [_YHYForecastHoursPath stringByAppendingString:@"/forecastHoursDict.plist"];
                [AllData writeToFile:_YHYForecastHoursPath atomically:YES];
                NSLog(@"forecastDays path : %@", self.YHYForecastHoursPath);
                NSDictionary *data = [AllData objectForKey:@"data"];
                _YHYForecastHoursData = [data objectForKey:@"hourly"];
                _forecastHoursItem = [[YHYForecastHoursItem alloc] initWithForecastHoursData:_YHYForecastHoursData];
                NSLog(@"----forecastHour测试用：condition: %@, pop: %@", _forecastHoursItem.conditionHour[0], _forecastHoursItem.popHour[0]);
                if ([self.dataDelegate respondsToSelector:@selector(hoursData:)]) {
                    [self.dataDelegate hoursData:_forecastHoursItem];
                }
            }
            else if(forecastData == weatherLive) {
                _YHYWeatherLivePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                _YHYWeatherLivePath = [_YHYWeatherLivePath stringByAppendingString:@"/WeatherLiveDict.plist"];
                [AllData writeToFile:_YHYWeatherLivePath atomically:YES];
                NSLog(@"weatherLive path : %@", self.YHYWeatherLivePath);
                NSDictionary *data = [AllData objectForKey:@"data"];
                _YHYWeatherLiveData = [data objectForKey:@"condition"];
                _liveItem = [[YHYLiveItem alloc] initWithLiveDictionary:_YHYWeatherLiveData];
                NSLog(@"----weatherLive测试用：condition: %@, pop: %@", _liveItem.condition, _liveItem.tips);
                if ([self.dataDelegate respondsToSelector:@selector(liveData:)]) {
                    [self.dataDelegate liveData:_liveItem];
                }
            }
            else if(forecastData == lifeIndex) {
            }
        }
        }];
    [task resume];
}

- (void)cityWriteToPList {
    NSString *docs = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"city.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:docs] == YES) {
        NSLog(@"file exists:%@", docs);
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"城市信息列表_20210705" ofType:@"csv"];
        NSString *contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"cityList%@", contents);
        NSArray *contentsArray = [contents componentsSeparatedByString:@"\r\n"];
        NSLog(@"路径：%@", docs);
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSInteger idx;
        NSMutableArray<NSString *> *keyArray = [[NSMutableArray alloc] initWithArray:@[@"cityId",@"city",@"cityEng",@"cityLevel",@"cityLevelEng",@"ProvinceLevel",@"ProvinceLevelEng",@"country",@"countryEng",@"longitude",@"latitude"]];

        for (idx = 1; idx < contentsArray.count; idx++) {
            NSString* currentContent = [contentsArray objectAtIndex:idx];
            NSArray *timeDataArr = [currentContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            for (int i = 0; i < keyArray.count; i++) {
                [dic setObject:[timeDataArr objectAtIndex:i] forKey:keyArray[i]];
            }
            [arr addObject:dic];
        }
        [arr writeToFile:docs atomically:YES];
    }
}

@end
