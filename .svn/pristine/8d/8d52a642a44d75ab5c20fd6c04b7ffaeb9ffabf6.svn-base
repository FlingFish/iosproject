//
//  TCourseOnlineViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/26.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "TCourseOnlineViewController.h"
#import "XRHttpRequestWithBlock.h"
#import "TCourseOnlineModel.h"
#import "TCourseOnlineCell.h"

@interface TCourseOnlineViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView  *   _tableView;
    NSMutableArray * _dataArray;
    NSInteger        _currentIndex;
}

@end

@implementation TCourseOnlineViewController

- (void)loadData
{
    _dataArray = [[NSMutableArray alloc] init];
    
    [XRHttpRequest GetWithUrl:baiduVideo_Url successful:^(NSMutableData *downloadData) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:downloadData options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * arr = dict[@"slices"];
        NSDictionary * dict1 = arr[0];
        NSArray * dataArr = dict1[@"hot"];
        
        
        for (NSDictionary * dic in dataArr) {
            TCourseOnlineModel * model = [[TCourseOnlineModel alloc] init];
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
    TCourseOnlineCell * cell = [TCourseOnlineCell cellWithTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 167.0;
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
