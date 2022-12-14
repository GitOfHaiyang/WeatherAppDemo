//
//  forecastSevenDaysViewController.m
//  
//
//  Created by yhy on 2022/8/11.
//

#import "forecastSevenDaysViewController.h"
#import "Masonry.h"
#import "YHYWeatherData.h"
#import "BaseforecastSevenDaysVC.h"
#import "YHYLiveItem.h"
#import "HoursCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "commonDefine.h"
#import <objc/runtime.h>
#import "todaydetailView.h"
#import "chooseCityViewController.h"
#import "WHToast.h"
#import "YHYDaysItem.h"
#import "YHYHoursItem.h"

static NSString * const reuseIdentifier = @"HoursCell";
static NSInteger const countDay = 14;



@interface forecastSevenDaysViewController () <UICollectionViewDataSource, UICollectionViewDelegate, weatherDataDelegate, chooseCityViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YHYWeatherData *weatherData;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) todaydetailView *detailView;
@property (nonatomic, strong) NSMutableArray <BaseforecastSevenDaysVC *> *subvArray;
@property (nonatomic, strong) UIBarButtonItem *leftBtn;
@property (nonatomic, strong) UIBarButtonItem *rightBtn;
@property (nonatomic, strong) NSString *cityId;
- (void)layoutSubviewConstraints;

@end

@implementation forecastSevenDaysViewController

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod([self class], @selector(collectionView: didSelectItemAtIndexPath:));
        Method hookMethod = class_getInstanceMethod([self class], @selector(hook_collectionView: didSelectItemAtIndexPath:));
        method_exchangeImplementations(originMethod, hookMethod);
    });
}

- (void)hook_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"hook test for collectionView select-----");
    [self hook_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath];

}

- (void)hoursData:(NSArray *)hoursArray {
    _weatherData.hoursArray = hoursArray;
    if([NSThread isMainThread]) {
        NSLog(@"isMainThread");
    }
    else {
        NSLog(@"No mainThread");
        dispatch_sync(dispatch_get_main_queue(), ^{
            //??????24??????????????????
            [self.collectionView reloadData];
            //????????????????????????
            self.detailView.tempNowLabel.text = [NSString stringWithFormat:@"%@??", self.weatherData.hoursArray[0].temp];
            self.detailView.conditionLabel.text = self.weatherData.hoursArray[0].condition;
            //????????????
            [self reloadImageView];
        });
    }
}

- (void)daysData:(NSArray *)daysArray {
    _weatherData.daysArray = daysArray;
    if([NSThread isMainThread]) {
        NSLog(@"isMainThread");
    }
    else {
        NSLog(@"No mainThread");
        dispatch_sync(dispatch_get_main_queue(), ^{
            //??????15???????????????
            NSLog(@"??????days??????----");
            for ( int i = 0 ; i < countDay ; ++i )
            {
                self.subvArray[i].conditionLabel.text = [NSString stringWithFormat:@"%@ / %@", self.weatherData.daysArray[i+1].conditionDay, self.weatherData.daysArray[i+1].conditionNight];
                self.subvArray[i].tempLabel.text = [NSString stringWithFormat:@"%@ / %@??C", self.weatherData.daysArray[i+1].tempDay, self.weatherData.daysArray[i+1].tempNight];
                self.subvArray[i].popLabel.text = [NSString stringWithFormat:@"%@%%", self.weatherData.daysArray[i+1].pop];
                NSString *test = [self.weatherData.daysArray[i+1].predictDate substringFromIndex:self.weatherData.daysArray[i+1].predictDate.length - 5];
                NSString *tmpstr1 = [self timeToTurnTheTimestamp];
                self.subvArray[i].dateLabel.text = [NSString stringWithFormat:@"%@ %@", [self weekdayStringFromDate:tmpstr1 addCount:i], test];
            }
            //????????????????????????
            self.detailView.tempTodayLabel.text = [NSString stringWithFormat:@"???????????????%@??    ???????????????%@??", self.weatherData.daysArray[1].tempDay, self.weatherData.daysArray[1].tempNight];
            self.detailView.sunRiseAndSetLabel.text =
            [NSString stringWithFormat:@"???????????????%@    ???????????????%@",
                          [self clipTimeString:self.weatherData.daysArray[1].sunrise],
                          [self clipTimeString:self.weatherData.daysArray[1].sunset]] ;
        });
    }
}

- (void)refreshDaysData {
    YHYweakify(self);
    _weatherData.dataBlock = ^(NSArray * _Nonnull daysArray) {
        YHYstrongify(self);
        self.weatherData.daysArray = daysArray;
        if([NSThread isMainThread]) {
            NSLog(@"isMainThread");
        }
        else {
            NSLog(@"No mainThread");
            dispatch_sync(dispatch_get_main_queue(), ^{
                //??????15???????????????
                NSLog(@"??????days??????----");
                for ( int i = 0 ; i < countDay ; ++i )
                {
                    self.subvArray[i].conditionLabel.text = [NSString stringWithFormat:@"%@ / %@", self.weatherData.daysArray[i+1].conditionDay, self.weatherData.daysArray[i+1].conditionNight];
                    self.subvArray[i].tempLabel.text = [NSString stringWithFormat:@"%@ / %@??C", self.weatherData.daysArray[i+1].tempDay, self.weatherData.daysArray[i+1].tempNight];
                    self.subvArray[i].popLabel.text = [NSString stringWithFormat:@"%@%%", self.weatherData.daysArray[i+1].pop];
                    NSString *test = [self.weatherData.daysArray[i+1].predictDate substringFromIndex:self.weatherData.daysArray[i+1].predictDate.length - 5];
                    NSString *tmpstr1 = [self timeToTurnTheTimestamp];
                    self.subvArray[i].dateLabel.text = [NSString stringWithFormat:@"%@ %@", [self weekdayStringFromDate:tmpstr1 addCount:i], test];
                }
                //????????????????????????
                self.detailView.tempTodayLabel.text = [NSString stringWithFormat:@"???????????????%@??    ???????????????%@??", self.weatherData.daysArray[1].tempDay, self.weatherData.daysArray[1].tempNight];
                self.detailView.sunRiseAndSetLabel.text =
                [NSString stringWithFormat:@"???????????????%@    ???????????????%@",
                              [self clipTimeString:self.weatherData.daysArray[1].sunrise],
                              [self clipTimeString:self.weatherData.daysArray[1].sunset]] ;
            });
        }
    };
}

- (instancetype)init{
    if( self = [super init]){
        _weatherData = [YHYWeatherData shareYHYWeatherData];
        _weatherData.dataDelegate = self;

    
        _leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"?????????" style:UIBarButtonItemStylePlain target:self action:@selector(selectCity)];
        [_leftBtn setTintColor:[UIColor blackColor]];
        self.navigationItem.leftBarButtonItem = _leftBtn;
        
        _rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"??????" style:UIBarButtonItemStylePlain target:self action:@selector(refreshAllData)];
        [_rightBtn setTintColor:[UIColor blackColor]];
        self.navigationItem.rightBarButtonItem = _rightBtn;
        
        [self refreshDaysData];
    }
    return self;
}

- (void)selectCity {
    chooseCityViewController *cityVC = [[chooseCityViewController alloc]init];
    cityVC.delegate = self;
    [self presentViewController:cityVC animated:YES completion:nil];
}

- (void)sendCityInformation:(NSMutableArray<NSString *> *)cityArray{
    [_leftBtn setTitle:cityArray[0]];
    _cityId = cityArray[1];
    //?????????????????????????????????????????????
    [WHToast showMessage:@"??????????????????" duration:3 finishHandler:nil];
    [_weatherData refreshWeatherData:_cityId];
}

- (void)refreshAllData {
    if (_cityId) {
        [_weatherData refreshWeatherData:_cityId];
    } else {
        [_weatherData refreshWeatherData:@"50"];
    }
    NSString *updateTime = self.weatherData.liveItem.updatetime;
    [WHToast showMessage:[NSString stringWithFormat: @"????????????\n?????????????????????%@",updateTime] duration:3 finishHandler:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.forestHoursVC.view];
    [self initImageView]; // ?????????????????????
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.detailView];
    [self.scrollView addSubview:self.containerView];
    
    
    [self layoutSubviewConstraints];
    
    
}

- (void)layoutSubviewConstraints {
    //?????????????????????????????????????????????
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    //detailView??????????????????????????????
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).with.offset(10);
    }];
    
    //24h?????????????????????
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(ScreenHeight/3);
        make.left.equalTo(self.view).with.offset(10);
        make.height.equalTo(@(ScreenHeight/8));
        make.width.equalTo(@(ScreenWidth-20));
    }];
    
    //15??????????????????????????????????????????
    int superViewTop = screenBounds.size.height/2;
    int superViewBottom = 50;
    UIEdgeInsets padding = UIEdgeInsetsMake(superViewTop, 10, superViewBottom, 10);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    

#pragma mark - ???UIScrollView????????????view???????????????contentSize
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    CGFloat eachBarHeight = (superViewTop - superViewBottom) / 8;
    UIView *lastView = nil;
    //??????????????????
//    YHYWeatherData *weatherData = [[YHYWeatherData alloc] init];
//    sleep(5);
    for ( int i = 0 ; i < countDay ; ++i )
    {
        //????????????
        BaseforecastSevenDaysVC *subv = self.subvArray[i];
        [self.containerView addSubview:subv.view];
        [subv.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.containerView);
            make.height.mas_equalTo(eachBarHeight);
            //??????subv?????????????????????
            if(lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else {
                make.top.mas_equalTo(self.containerView.mas_top);
            }
        }];
        lastView = subv.view;
    }
    //???????????????????????????????????????????????????
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

#pragma mark - <delegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 24;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HoursCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                  forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.tempLabel.text = [NSString stringWithFormat:@"%@??", self.weatherData.hoursArray[indexPath.item].temp];
    NSString *timeHourStr = self.weatherData.hoursArray[indexPath.item].hour;
    NSInteger hour = [timeHourStr integerValue];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@%@:00 %@M",
                           hour<=10?@"0":@"",
                           timeHourStr,
                           hour<=12?@"A":@"P"];
    NSString *iconStr;
    if(hour >= 6 && hour <18){
        iconStr = self.weatherData.hoursArray[indexPath.item].iconDay;
    } else {
        iconStr = self.weatherData.hoursArray[indexPath.item].iconNight;
    }
    NSInteger iconIndex = [iconStr integerValue];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"W%ld.png", iconIndex]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}

#pragma mark - ?????????
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(40, 80);
        //?????????cell???????????????cell?????????????????????
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        //???????????????
        layout.minimumInteritemSpacing = 20;
        //???????????????
        layout.minimumLineSpacing = 20;
        CGFloat width = ScreenWidth - 20;
        CGFloat height = ScreenHeight/8;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.layer.cornerRadius = 10;
        _collectionView.layer.masksToBounds = YES;
        _collectionView.layer.borderWidth = 0.5;
        _collectionView.layer.borderColor = [UIColor clearColor].CGColor;
//        NSLog(@"collection?????????");
        [_collectionView registerClass:[HoursCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

//???????????????????????????????????????
//??????????????????????????????for???????????????????????????????????????scrollView?????????????????????????????????scrollView???????????????????????????????????????
//????????????????????????????????????scrollview
- (UIView *)containerView{
    if(!_containerView){
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.alpha = 1;
        _containerView.layer.borderColor = [[UIColor clearColor] CGColor];
        _containerView.layer.borderWidth = 1;
    }
    return _containerView;
}

- (void)initImageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    }
}

- (void)reloadImageView{
    if(self.imageView){
        NSString *timeHourStr = self.weatherData.hoursArray[0].hour;
        NSInteger hour = [timeHourStr integerValue];
        if(hour < 18 && hour >=6){
            [self.imageView sd_setImageWithURL:urlBgImageDay];
            self.imageView.alpha = 0.3;
        }

        else {
            [self.imageView sd_setImageWithURL:urlBgImageNight];
            self.imageView.alpha = 0.6;
        }
    }
}

- (UIView *)detailView{
    if(!_detailView){
        _detailView = [todaydetailView new];
    }
    return _detailView;
}

- (NSMutableArray<BaseforecastSevenDaysVC *> *)subvArray {
    if(!_subvArray){
        _subvArray = [NSMutableArray array];
        for ( int i = 0 ; i < countDay ; ++i )
        {
            //???????????????
            BaseforecastSevenDaysVC *subv = [BaseforecastSevenDaysVC new];
            [_subvArray addObject:subv];
        }
    }
    return _subvArray;
}

#pragma mark - private method
//????????????????????????
- (NSString *)timeToTurnTheTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return timeString;
}
//????????????????????????
- (NSString*)weekdayStringFromDate:(NSString *)timeString addCount:(NSInteger)count
 {
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString doubleValue]];
   NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"??????", @"??????", @"??????", @"??????", @"??????", @"??????", @"??????",  nil];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:nd];
    
    //??????????????????+count???1???7??? - 1????????????????????????
    NSInteger whichDay = (theComponents.weekday + count);
    while(whichDay > 7)
        whichDay -= 7;
    return [weekdays objectAtIndex:whichDay];
    
}

- (NSString *)clipTimeString:(NSString *)str {
    return [str substringWithRange:NSMakeRange(11, 5)];
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
