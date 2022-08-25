//
//  chooseCityViewController.h
//  WeatherDemo
//
//  Created by ByteDance on 2022/8/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol chooseCityViewDelegate <NSObject>

- (void)sendCityInformation:(NSMutableArray <NSString *> *) cityArray;

@end

@interface chooseCityViewController : UIViewController

@property (nonatomic, weak) id<chooseCityViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
