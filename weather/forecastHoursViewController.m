//
//  forecastHoursViewController.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/11.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "forecastHoursViewController.h"
#import "HoursCollectionViewCell.h"

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
static NSString * const reuseIdentifier = @"HoursCell";

@interface forecastHoursViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation forecastHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[HoursCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 24;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                  forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(40, 60);
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
        _collectionView.backgroundColor = [UIColor greenColor];
        NSLog(@"collection初始化");
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

@end
