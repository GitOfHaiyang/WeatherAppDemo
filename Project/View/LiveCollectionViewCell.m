//
//  LiveCollectionViewCell.m
//  WeatherDemo
//
//  Created by yhy on 2022/8/14.
//  Copyright © 2022 yhy. All rights reserved.
//

#import "LiveCollectionViewCell.h"
#import "commonDefine.h"
#import "Masonry.h"
@implementation LiveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //add UIIamgeView
    
    _Label = [[UILabel alloc] init];

    _Label.backgroundColor = [UIColor clearColor];
    _Label.textAlignment = NSTextAlignmentNatural;
    _Label.font = [UIFont boldSystemFontOfSize:12];
    _Label.numberOfLines = 0; //自定义高度
    NSLog(@"%@之前" , self.Label.superview);
/*
    [self.Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView.mas_width);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(10);
    }];
  //添加到VC中
 */
    [self addSubview:self.Label];
    _Label.frame = self.bounds;
    NSLog(@"%@之后" , self.Label.superview);


    
    return self;
}

@end
