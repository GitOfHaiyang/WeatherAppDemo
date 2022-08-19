//
//  LiveCollectionViewCell.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/14.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "LiveCollectionViewCell.h"

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height

@implementation LiveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //add UIIamgeView
    
    _Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    _Label.backgroundColor = [UIColor clearColor];
    _Label.textAlignment = NSTextAlignmentCenter;
    _Label.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:self.Label];

    
    return self;
}

@end
