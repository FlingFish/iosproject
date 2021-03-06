//
//  TCourseOfflineViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/26.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "TCourseOfflineViewController.h"
#import "XRHttpRequestWithBlock.h"
#import "TCourseOfflineCell.h"
#import "TCourseOfflineModel.h"

@interface TCourseOfflineViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView       * _tableView;
    NSMutableArray    * _dataArray;
    NSInteger        _currentIndex;
}

@end

@implementation TCourseOfflineViewController

- (void)loadData
{
    _dataArray = [[NSMutableArray alloc] init];
    
    [XRHttpRequest GetWithUrl:baiduVideo_Url successful:^(NSMutableData *downloadData) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:downloadData options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * arr = dict[@"slices"];
        NSDictionary * dict1 = arr[0];
        NSArray * dataArr = dict1[@"hot"];
        
        for (NSDictionary * dic in dataArr) {
            TCourseOfflineModel * model = [[TCourseOfflineModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
        // 刷新表格
        [_tableView reloadData];
    } faild:^(NSError *error) {
        NSLog(@"error: %@", error);
    } requestTag:101 isRefresh:NO];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 154) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
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
    
    
    
    [UIView animateWithDuration:0.6f animations:^{
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
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCourseOfflineCell * cell = [TCourseOfflineCell cellWithTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
