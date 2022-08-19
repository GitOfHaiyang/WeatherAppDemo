//
//  HoursCollectionViewCell.h
//  HomePwner
//
//  Created by ByteDance on 2022/8/12.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoursCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
