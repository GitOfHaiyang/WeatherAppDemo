//
//  chooseCityViewController.m
//  WeatherDemo
//
//  Created by yhy on 2022/8/19.
//  Copyright © 2022 yhy. All rights reserved.
//

#import "chooseCityViewController.h"
#import "commonDefine.h"

static NSString * const cellIndentifier = @"cell";


@interface chooseCityViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSMutableArray *indexSourceArray;

@end

@implementation chooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    [self initDataSource];
    [self initTableView];

    [self.cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndentifier];
}

- (void)initNav {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    bgView.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f  blue:241/255.0f  alpha:1.0f];
    [self.view addSubview:bgView];
    
    //取消按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(10, 30, 50, 20);
    [closeBtn setTitle:@"🔙" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [closeBtn setImage:[UIImage imageNamed:@"W0"] forState:UIButtonTypePlain];
//    closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [closeBtn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-50, 30, 100, 25)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"选择城市";
    [bgView addSubview:titleLabel];
}

- (void)initTableView {
    self.cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.cityTableView.dataSource = self;
    self.cityTableView.delegate = self;
    self.cityTableView.sectionIndexColor = [UIColor colorWithRed:252/255.0f green:74/255.0f blue:132/255.0f alpha:1.0f];
    [self.view addSubview:self.cityTableView];

}

- (void)initDataSource {
    self.dataSourceArray = [[NSMutableArray alloc]init];
    self.indexSourceArray = [[NSMutableArray alloc]init];
    
//    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"city.plist"];
    NSMutableArray *cityArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    self.dataSourceArray = [self sortArray:cityArr];
}

- (NSMutableArray *)sortArray:(NSMutableArray *)originalArray {
    NSMutableArray *array = [[NSMutableArray alloc]init];
       
       //根据拼音对数组排序
       NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"cityEng" ascending:YES]];
       //排序
       [originalArray sortUsingDescriptors:sortDescriptors];
       
       NSMutableArray *tempArray = nil;
       BOOL flag = NO;
       
       //分组
       for (int i = 0; i < originalArray.count; i++) {
           NSString *cityEng = [originalArray[i] objectForKey:@"cityEng"];
           while ([[cityEng substringToIndex:1] isEqual: @"\""] || [[cityEng substringToIndex:1] isEqual:@"\\"]){
               cityEng = [cityEng substringFromIndex:1];
           }
           NSString *firstChar = [cityEng substringWithRange:NSMakeRange(0,1)];
           if (![_indexSourceArray containsObject:[firstChar uppercaseString]]) {
               [_indexSourceArray addObject:[firstChar uppercaseString]];
               tempArray = [[NSMutableArray alloc]init];
               flag = NO;
           }
           if ([_indexSourceArray containsObject:[firstChar uppercaseString]]) {
               [tempArray addObject:originalArray[i]];
               if (!flag) {
                   [array addObject:tempArray];
                   flag = YES;
               }
           }
       }
       return array;
}

#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSourceArray[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_indexSourceArray objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexSourceArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.textLabel.text = [[self.dataSourceArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"city"];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //代理传值
    if (self.delegate != nil) {
        NSString *city = [[self.dataSourceArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"city"];
        NSString *cityId = [[self.dataSourceArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"cityId"];
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:@[city,cityId]];
        [self.delegate sendCityInformation:array];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)closeBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
