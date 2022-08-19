//
//  forecastSevenDaysViewController.m
//  
//
//  Created by ByteDance on 2022/8/11.
//

#import "forecastSevenDaysViewController.h"
#import "Masonry.h"
#import "YHYWeatherData.h"
#import "BaseforecastSevenDaysVC.h"
#import "YHYForecastDaysItem.h"
#import "YHYForecastHoursItem.h"
#import "YHYLiveItem.h"
#import "HoursCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "commonDefine.h"
#import <objc/runtime.h>
#import "todaydetailView.h"
#import "chooseCityViewController.h"
#import "WHToast.h"
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

- (void)hoursData:(YHYForecastHoursItem *)hoursItem {
    _weatherData.forecastHoursItem = hoursItem;
    if([NSThread isMainThread]) {
        NSLog(@"isMainThread");
    }
    else {
        NSLog(@"No mainThread");
        dispatch_sync(dispatch_get_main_queue(), ^{
            //更新24小时预报数据
            [self.collectionView reloadData];
            //更新当日细节天气
            self.detailView.tempNowLabel.text = [NSString stringWithFormat:@"%@˚", self.weatherData.forecastHoursItem.tempHour[0]];
            self.detailView.conditionLabel.text = self.weatherData.forecastHoursItem.conditionHour[0];
            //更新背景
            [self reloadImageView];
        });
    }
}

- (void)daysData:(YHYForecastDaysItem *)daysItem {
    _weatherData.forecastDaysItem = daysItem;
    if([NSThread isMainThread]) {
        NSLog(@"isMainThread");
    }
    else {
        NSLog(@"No mainThread");
        dispatch_sync(dispatch_get_main_queue(), ^{
            //更新15天预备数据
            NSLog(@"更新days数据----");
            for ( int i = 0 ; i < countDay ; ++i )
            {
                self.subvArray[i].conditionLabel.text = [NSString stringWithFormat:@"%@ / %@", self.weatherData.forecastDaysItem.conditionDay[i+1], self.weatherData.forecastDaysItem.conditionNight[i+1]];
                self.subvArray[i].tempLabel.text = [NSString stringWithFormat:@"%@ / %@˚C", self.weatherData.forecastDaysItem.tempDay[i+1], self.weatherData.forecastDaysItem.tempNight[i+1]];
                self.subvArray[i].popLabel.text = [NSString stringWithFormat:@"%@%%", self.weatherData.forecastDaysItem.popDay[i+1]];
                NSString *test = [self.weatherData.forecastDaysItem.predictDate[i+1] substringFromIndex:self.weatherData.forecastDaysItem.predictDate[i+1].length - 5];
                NSString *tmpstr1 = [self timeToTurnTheTimestamp];
                self.subvArray[i].dateLabel.text = [NSString stringWithFormat:@"%@ %@", [self weekdayStringFromDate:tmpstr1 addCount:i], test];
            }
            //更新当日细节天气
            self.detailView.tempTodayLabel.text = [NSString stringWithFormat:@"最高温度：%@˚    最低温度：%@˚", self.weatherData.forecastDaysItem.tempDay[1], self.weatherData.forecastDaysItem.tempNight[1]];
            self.detailView.sunRiseAndSetLabel.text = [NSString stringWithFormat:@"日出时间：%@    日落时间：%@", self.weatherData.forecastDaysItem.sunrise[1], self.weatherData.forecastDaysItem.sunset[1]];
        });
    }
}

- (instancetype)init{
    if( self = [super init]){
        _weatherData = [YHYWeatherData sharedInstance];
        _weatherData.dataDelegate = self;

    
        _leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"闵行区" style:UIBarButtonItemStylePlain target:self action:@selector(selectCity)];
        [_leftBtn setTintColor:[UIColor blackColor]];
        self.navigationItem.leftBarButtonItem = _leftBtn;
        
        _rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refreshAllData)];
        [_rightBtn setTintColor:[UIColor blackColor]];
        self.navigationItem.rightBarButtonItem = _rightBtn;
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
    //退出城市选择界面时自动更新数据
    [WHToast showMessage:@"切换城市成功" duration:3 finishHandler:nil];
    [_weatherData refreshWeatherData:_cityId];
}

- (void)refreshAllData {
    if (_cityId) {
        [_weatherData refreshWeatherData:_cityId];
    } else {
        [_weatherData refreshWeatherData:@"50"];
    }
    NSString *updateTime = self.weatherData.liveItem.updatetime;
    [WHToast showMessage:[NSString stringWithFormat: @"更新成功\n数据更新时间：%@",updateTime] duration:3 finishHandler:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.forestHoursVC.view];
    [self initImageView]; // 尝试不用懒加载
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.detailView];
    [self.scrollView addSubview:self.containerView];
    
    
    [self layoutSubviewConstraints];
    
    
}

- (void)layoutSubviewConstraints {
    //获取屏幕大小，不同设备值也不同
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    //detailView（当天详细天气）布局
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).with.offset(10);
    }];
    
    //24h预报的布局设置
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(ScreenHeight/3);
        make.left.equalTo(self.view).with.offset(10);
        make.height.equalTo(@(ScreenHeight/8));
        make.width.equalTo(@(ScreenWidth-20));
    }];
    
    //15天天气，距离屏幕上下边的距离
    int superViewTop = screenBounds.size.height/2;
    int superViewBottom = 50;
    UIEdgeInsets padding = UIEdgeInsetsMake(superViewTop, 10, superViewBottom, 10);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    

#pragma mark - 在UIScrollView顺序排列view并自动计算contentSize
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    CGFloat eachBarHeight = (superViewTop - superViewBottom) / 8;
    UIView *lastView = nil;
    //获取天气数据
//    YHYWeatherData *weatherData = [[YHYWeatherData alloc] init];
//    sleep(5);
    for ( int i = 0 ; i < countDay ; ++i )
    {
        //设置布局
        BaseforecastSevenDaysVC *subv = self.subvArray[i];
        [self.containerView addSubview:subv.view];
        [subv.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.containerView);
            make.height.mas_equalTo(eachBarHeight);
            //设置subv的顶部与谁对齐
            if(lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else {
                make.top.mas_equalTo(self.containerView.mas_top);
            }
        }];
        lastView = subv.view;
    }
    //需给容器设置一个底部，这样才能滑动
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
    cell.tempLabel.text = [NSString stringWithFormat:@"%@˚", self.weatherData.forecastHoursItem.tempHour[indexPath.item]];
    NSString *timeHourStr = self.weatherData.forecastHoursItem.timeHour[indexPath.item];
    NSInteger hour = [timeHourStr integerValue];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@%@:00 %@M",
                           hour<=10?@"0":@"",
                           timeHourStr,
                           hour<=12?@"A":@"P"];
    NSString *iconStr;
    if(hour >= 6 && hour <18){
        iconStr = self.weatherData.forecastHoursItem.iconDayHour[indexPath.item];
    } else {
        iconStr = self.weatherData.forecastHoursItem.iconNightHour[indexPath.item];
    }
    NSInteger iconIndex = [iconStr integerValue];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Images/icon/W%ld.png", iconIndex]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}

#pragma mark - 初始化
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(40, 80);
        //第一个cell和最后一个cell与父空间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        //最小行间距
        layout.minimumInteritemSpacing = 20;
        //最小列间距
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
        NSLog(@"collection初始化");
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

//容器：用于盛放所有的条状框
//如果不使用容器，而将for循环中的所有子视图直接加到scrollView中，则图片显示的颜色为scrollView的背景色，不知道为啥？？？
//设置容器的宽和边长等同于scrollview
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
        NSString *timeHourStr = self.weatherData.forecastHoursItem.timeHour[0];
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
            //初始化数据
            
            BaseforecastSevenDaysVC *subv = [BaseforecastSevenDaysVC new];
            
            [_subvArray addObject:subv];
        }
    }
    return _subvArray;
}

#pragma mark - private method
//当前日期转时间戳
- (NSString *)timeToTurnTheTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return timeString;
}
//时间戳转星期格式
- (NSString*)weekdayStringFromDate:(NSString *)timeString addCount:(NSInteger)count
 {
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString doubleValue]];
   NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六",  nil];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:nd];
    
    //输出当前日期+count（1～7） - 1，按顺序得到日期
    NSInteger whichDay = (theComponents.weekday + count);
    while(whichDay > 7)
        whichDay -= 7;
    return [weekdays objectAtIndex:whichDay];
    
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
