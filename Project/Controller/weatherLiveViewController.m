//
//  weatherLiveViewController.m
//  WeatherDemo
//
//  Created by yhy on 2022/8/14.
//  Copyright © 2022 yhy. All rights reserved.
//
#import "weatherLiveViewController.h"
#import "YHYWeatherData.h"
#import "YHYLiveItem.h"
#import "YHYLifeIndexItem.h"
#import "LiveCollectionViewCell.h"
#import "LifeIndexCollectionViewCell.h"
#import "HoursCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "commonDefine.h"

static NSString * const reuseIdentifier_live = @"liveCell";
static NSString * const reuseIdentifier_lifeIndex = @"lifeIndexCell";

#define live(obj)       self.weatherData.liveItem.obj
#define lifeIndex(obj)  self.weatherData.lifeIndexArray.obj

@interface weatherLiveViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) YHYWeatherData *weatherData;

@property (nonatomic, strong) UICollectionView *liveView;

@property (nonatomic, strong) UICollectionView *lifeIndexView;

@property (nonatomic, strong) UIImageView* backgroundView;

@property (nonatomic, strong) NSMutableArray *myArray;

@property (nonatomic, strong) NSMutableArray<LifeIndexCollectionViewCell *> *liveIndexArray;
@end

@implementation weatherLiveViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if(self = [super init]){
        self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationData:) name:@"Data" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.liveView];
//    [self.view addSubview:self.lifeIndexView];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;

}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshMyArray];
    [self.liveView reloadData];
}

- (void)notificationData:(NSNotification *)noti{
    NSDictionary  *dict=[noti userInfo];
    _weatherData = [dict objectForKey:@"weatherData"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0) {
        return 6;
    }
    else {
        return self.weatherData.lifeIndexArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) {
        LifeIndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier_lifeIndex forIndexPath:indexPath];
        cell.backgroundColor = HexToRGB(0xf5f7fa, 0.5);
        cell.backgroundView.alpha = 0.1;
        cell.nameLabel.text = self.myArray[0][indexPath.item];
        cell.statusLabel.text = self.myArray[1][indexPath.item];
        cell.imageView.image = [UIImage imageNamed:self.myArray[2][indexPath.item]];
        return cell;
    }
    else {
        LifeIndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier_lifeIndex forIndexPath:indexPath];
        cell.backgroundColor = HexToRGB(0xf5f7fa, 0.45);
//        cell.backgroundColor = 0;
        cell.nameLabel.text = self.weatherData.lifeIndexArray[indexPath.item].name;
        cell.statusLabel.text = self.weatherData.lifeIndexArray[indexPath.item].status;
        cell.imageView.backgroundColor = [UIColor clearColor];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.weatherData.lifeIndexArray[indexPath.item].code]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.imageView.clipsToBounds = NO;
        return cell;
    }

}

- (UICollectionView *)liveView {
    if(!_liveView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        NSInteger cellHeight = 50;
        layout.itemSize = CGSizeMake(100, 100);
        //第一个cell和最后一个cell与父空间的间距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //最小行间距
        layout.minimumInteritemSpacing = 5;
        //最小列间距
        layout.minimumLineSpacing = 5;

        _liveView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
        _liveView.showsVerticalScrollIndicator = NO;
        _liveView.dataSource = self;
        _liveView.delegate = self;
        _liveView.backgroundColor = [UIColor clearColor];
        _liveView.layer.cornerRadius = 10;
        _liveView.layer.masksToBounds = YES;
        _liveView.layer.borderWidth = 0.5;
        _liveView.layer.borderColor = [UIColor grayColor].CGColor;
//        NSLog(@"collection初始化");
        [_liveView registerClass:[LiveCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier_live];
        [_liveView registerClass:[LifeIndexCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier_lifeIndex];

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
    if(!_myArray) {
        _myArray = [[NSMutableArray alloc] initWithArray: @[
                        @[@"实时温度(°C)",@"体感温度(°C)",@"湿度(%)",@"风向",@"风力",@"大气压力(百Pa)"],
                        @[live(temp),live(realFeel),live(humidity),live(windDir),live(windLevel),live(pressure)],
                        @[@"live_1",@"live_2",@"live_3",@"live_4",@"live_5",@"live_6"]]
        ];
    }
    return _myArray;
}


- (void)refreshMyArray {
    _myArray[1] = @[live(temp),live(realFeel),live(humidity),live(windDir),live(windLevel),live(pressure)];
}

- (NSMutableArray *) liveIndexArray {
    if(!_liveIndexArray) {
        
    }
    return _liveIndexArray;
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
