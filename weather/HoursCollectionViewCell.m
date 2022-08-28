//
//  HoursCollectionViewCell.m
//  WeatherDemo
//
//  Created by yhy on 2022/8/12.
//  Copyright © 2022 yhy. All rights reserved.
//

#import "HoursCollectionViewCell.h"

@implementation HoursCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //add UIIamgeView
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    self.imageView.backgroundColor=[UIColor clearColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    
    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 40, 30)];
    self.tempLabel.backgroundColor = [UIColor clearColor];
    self.tempLabel.textAlignment = NSTextAlignmentCenter;
    self.tempLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:self.tempLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 40, 10)];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont systemFontOfSize:8];
    [self addSubview:self.timeLabel];
    
    return self;
}
@end
