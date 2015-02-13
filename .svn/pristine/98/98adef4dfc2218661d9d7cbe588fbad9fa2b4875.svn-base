//
//  MyRecentCourseViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "MyRecentCourseViewController.h"
#import "XRHttpRequestWithBlock.h"
#import "MyCourseCell.h"

@interface MyRecentCourseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  *   _tableView;
    NSMutableArray * _dataArray;
    NSInteger        _currentIndex;
}

@end

@implementation MyRecentCourseViewController

//- (void)loadData
//{
//    _dataArray = [[NSMutableArray alloc] init];
//    
//    [XRHttpRequest requestGetWithUrl:baiduVideo_Url successful:^(NSMutableData *downloadData) {
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:downloadData options:NSJSONReadingMutableContainers error:nil];
//        
//        NSArray * arr = dict[@"slices"];
//        NSDictionary * dict1 = arr[0];
//        NSArray * dataArr = dict1[@"hot"];
//        
//        for (NSDictionary * dic in dataArr)
//        {
//            TCourseOnlineModel * model = [[TCourseOnlineModel alloc] init];
//            [model setValuesForKeysWithDictionary:dic];
//            [_dataArray addObject:model];
//        }
//        
//        // 刷新表格
//        [_tableView reloadData];
//    } faild:^(NSError *error) {
//        NSLog(@"error: %@", error);
//    } requestTag:101 isRefresh:NO];
//}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 154+49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
}

#pragma mark - UITableViewDelegate
/*
 * Modify By Hangang 加入很炫酷的卡片式插入屏幕列表
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat rotationAngleDegrees = 0;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(-200, -20);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    
    UIView *card = [cell contentView];
    card.layer.transform = transform;
    card.layer.opacity = 0.8;
    
    [UIView animateWithDuration:1.0f animations:^{
        card.layer.transform = CATransform3DIdentity;
        card.layer.opacity = 1;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    
    MyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MyCourseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.headerImageView.image = [UIImage imageNamed:@"cornerShare"];
    cell.titleLabel.text = @"待评价课程名称";

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self loadData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
