//
//  HoursCollectionViewCell.h
//  WeatherDemo
//
//  Created by yhy on 2022/8/12.
//  Copyright © 2022 yhy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoursCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
