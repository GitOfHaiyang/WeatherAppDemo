//
//  LifeIndexCollectionViewCell.m
//  WeatherDemo
//
//  Created by yhy on 2022/8/25.
//  Copyright © 2022 yhy. All rights reserved.
//

#import "LifeIndexCollectionViewCell.h"

@implementation LifeIndexCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //add UIIamgeView
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 50, 50)];
    self.imageView.backgroundColor=[UIColor clearColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 30)];
    self.statusLabel.backgroundColor = [UIColor clearColor];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:self.statusLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 100, 10)];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:8];
    [self addSubview:self.nameLabel];
    
    return self;
}

@end
