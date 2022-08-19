//
//  BaseforecastSevenDaysVC.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/11.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "BaseforecastSevenDaysVC.h"
#import "Masonry.h"
#import "YHYWeatherData.h"
#import "commonDefine.h"
@interface BaseforecastSevenDaysVC ()

- (void)layoutSubviewConstraints;

@end

@implementation BaseforecastSevenDaysVC

- (void)viewDidLoad{
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.conditionLabel];
    [self.view addSubview:self.popLabel];
    [self.view addSubview:self.tempLabel];
        
    [self layoutSubviewConstraints];

}

- (void)layoutSubviewConstraints{
    int padding1 = 2;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self.view).with.inset(2);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@(ScreenWidth * 0.25));
    }];
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenWidth * 0.3));
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.dateLabel.mas_right).with.offset(padding1);
        make.right.equalTo(self.popLabel.mas_left).with.offset(-padding1);
    }];
    [self.popLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenWidth * 0.1));
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.conditionLabel.mas_right).with.offset(padding1);
        make.right.equalTo(self.tempLabel.mas_left).with.offset(-padding1);
    }];
    [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.popLabel.mas_right).with.offset(padding1);
        make.right.equalTo(self.view.mas_right).with.offset(-padding1);
    }];
    
}


- (UILabel *)dateLabel {
    if(!_dateLabel){
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dateLabel;
}

- (UILabel *)conditionLabel {
    if(!_conditionLabel){
        _conditionLabel = [UILabel new];
        _conditionLabel.font = [UIFont systemFontOfSize:12];
    }
    return _conditionLabel;
}

- (UILabel *)popLabel {
    if(!_popLabel){
        _popLabel = [UILabel new];
        _popLabel.font = [UIFont systemFontOfSize:12];
    }
    return _popLabel;
}

- (UILabel *)tempLabel{
    if(!_tempLabel){
        _tempLabel = [UILabel new];
        _tempLabel.font = [UIFont systemFontOfSize:12];
        _tempLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tempLabel;
}

- (UILabel *)tempDayLabel{
    if(!_tempDayLabel){
        _tempDayLabel = [UILabel new];
    }
    return _tempDayLabel;
}

- (UILabel *)tempNightLabel {
    if(!_tempNightLabel) {
        _tempNightLabel = [UILabel new];
    }
    return _tempNightLabel;
}
    


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
