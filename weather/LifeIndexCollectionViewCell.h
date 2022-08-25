//
//  LifeIndexCollectionViewCell.h
//  WeatherDemo
//
//  Created by ByteDance on 2022/8/25.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LifeIndexCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
