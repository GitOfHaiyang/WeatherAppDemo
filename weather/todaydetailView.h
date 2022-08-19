//
//  todaydetailView.h
//  HomePwner
//
//  Created by ByteDance on 2022/8/16.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface todaydetailView : UIView

@property (nonatomic, strong) UILabel *tempNowLabel;
@property (nonatomic, strong) UILabel *conditionLabel;
@property (nonatomic, strong) UILabel *tempTodayLabel;
@property (nonatomic, strong) UILabel *sunRiseAndSetLabel;

@end

NS_ASSUME_NONNULL_END
