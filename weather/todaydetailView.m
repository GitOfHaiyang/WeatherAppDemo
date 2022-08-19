//
//  todaydetailView.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/16.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "todaydetailView.h"
#import "commonDefine.h"

@implementation todaydetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    
    if (self = [super init]) {
        CGFloat width = ScreenWidth - 20;
        CGFloat height = ScreenHeight / 4;
        CGFloat subviewStartY = ScreenHeight / 10;
        
        self.frame = CGRectMake(0, 0, width, height);
        _tempNowLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, subviewStartY, width, 60)];
        _tempNowLabel.textAlignment = NSTextAlignmentCenter;
        _tempNowLabel.font = [UIFont boldSystemFontOfSize:60];
        
        _conditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(width / 2 + 40, subviewStartY + 40, 40, 20)];
        _conditionLabel.textAlignment = NSTextAlignmentCenter;
        _conditionLabel.font = [UIFont systemFontOfSize:10];
        
        _tempTodayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, subviewStartY + 70, width, 20)];
        _tempTodayLabel.textAlignment = NSTextAlignmentCenter;
        _tempTodayLabel.font = [UIFont systemFontOfSize:10];

        
        _sunRiseAndSetLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, subviewStartY + 90, width, 20)];
        _sunRiseAndSetLabel.textAlignment = NSTextAlignmentCenter;
        _sunRiseAndSetLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:self.tempNowLabel];
        [self addSubview:self.conditionLabel];
        [self addSubview:self.tempTodayLabel];
        [self addSubview:self.sunRiseAndSetLabel];
    }
    return self;
}

@end
