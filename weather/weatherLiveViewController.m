//
//  weatherLiveViewController.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/14.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//
#import "weatherLiveViewController.h"
#import "YHYWeatherData.h"
#import "YHYLiveItem.h"
#import "LiveCollectionViewCell.h"
#import "HoursCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "commonDefine.h"

static NSString * const reuseIdentifier_live = @"liveCell";
static NSString * const reuseIdentifier_lifeIndex = @"lifeIndexCell";

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define live(obj)       self.weatherData.liveItem.obj


@interface weatherLiveViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) YHYWeatherData *weatherData;

@property (nonatomic, strong) UICollectionView *liveView;
//@property (nonatomic, strong) UICollectionView *lifeIndexView;

@property (nonatomic, strong) UIImageView* backgroundView;

@property (nonatomic, strong) NSMutableArray *myArray;


@end

@implementation weatherLiveViewController

- (void)injected {
    [self viewDidLoad];

    [self.liveView reloadData];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if(self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationData:) name:@"Data" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.liveView];
    
}

- (void)notificationData:(NSNotification *)noti{
    NSDictionary  *dict=[noti userInfo];
    _weatherData = [dict objectForKey:@"weatherData"];
    NSLog(@"notification:%@", _weatherData);
//    [self.liveView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier_live forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    cell.backgroundView.alpha = 0.2;
    cell.Label.text = self.myArray[indexPath.row];
    return cell;
}

- (UICollectionView *)liveView {
    if(!_liveView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        NSInteger cellHeight = 50;
        layout.itemSize = CGSizeMake(ScreenWidth, cellHeight);
        //第一个cell和最后一个cell与父空间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //最小行间距
        layout.minimumInteritemSpacing = 0;
        //最小列间距
        layout.minimumLineSpacing = 0;
        CGFloat width = ScreenWidth;
        CGFloat height = cellHeight * self.myArray.count + 10;
        _liveView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
        _liveView.showsVerticalScrollIndicator = NO;
        _liveView.dataSource = self;
        _liveView.delegate = self;
        _liveView.backgroundColor = [UIColor clearColor];
        _liveView.layer.cornerRadius = 10;
        _liveView.layer.masksToBounds = YES;
        _liveView.layer.borderWidth = 0.5;
        _liveView.layer.borderColor = [UIColor whiteColor].CGColor;
        NSLog(@"collection初始化");
        [_liveView registerClass:[LiveCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier_live];

    }
    return _liveView;
}

- (UIImageView *)backgroundView {
    if(!_backgroundView) {
        _backgroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
        [_backgroundView sd_setImageWithURL:urlbgImageLive];
    }
    return _backgroundView;
}

- (NSMutableArray *) myArray {
    if(!_myArray){
        NSString *str1 = [NSString stringWithFormat:@"实时温度：%@    体感温度：%@", live(temp), live(realFeel)];
        NSString *str2 = [NSString stringWithFormat:@"风向：%@   风速：%@    风力：%@", live(windDir), live(windSpeed), live(windLevel)];
        NSString *str3 = live(tips);
        NSString *str4 = [NSString stringWithFormat:@"气压：%@（百帕）  UVI：%@    湿度：%@%%", live(pressure), live(uvi),live(humidity)];
        _myArray = [[NSMutableArray alloc] initWithArray:@[str1,str2,str4,str3]];
    }
    return _myArray;
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
