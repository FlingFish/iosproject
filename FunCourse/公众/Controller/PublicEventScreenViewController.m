//
//  PublicEventScreenViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "PublicEventScreenViewController.h"
#import "PublicEventModel.h"
#import "XRHttpRequestWithBlock.h"
#import "MyImageView.h"
#import "PublicEventCell.h"
#import "PublicEventDetailViewController.h"
#import "MyCATransition.h"

@interface PublicEventScreenViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UITableView  *   _tableView;
    UIScrollView *   _scrollView;
    UIPageControl *  _page;
    NSMutableArray * _dataArray;
    NSInteger        _currentIndex;
    NSTimer  *       _timer;
    UIView *         _headerView;
}

@end

@implementation PublicEventScreenViewController

/**
 *  下载数据
 */
- (void)loadData
{
    _dataArray = [[NSMutableArray alloc] init];
    
    [XRHttpRequest GetWithUrl:baiduVideo_Url successful:^(NSMutableData *downloadData) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:downloadData options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * arr = dict[@"slices"];
        NSDictionary * dict1 = arr[0];
        NSArray * dataArr = dict1[@"hot"];
        
        for (NSDictionary * dic in dataArr) {
            PublicEventModel * model = [[PublicEventModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
        [self fillData];
    } faild:^(NSError *error) {
        NSLog(@"error: %@", error);
    } requestTag:101 isRefresh:NO];
}

/**
 *  创建头视图
 */
- (void)setupHeaderView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 200)];
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 200)];
    [_headerView addSubview:_scrollView];
    [self.view addSubview:_headerView];
}

/**
 *  填充数据
 */
- (void)fillData
{
    for (int i = 0; i < _dataArray.count; i++) {
        MyImageView * imageView = [[MyImageView alloc] initWithFrame:CGRectMake(i * SCREEN_SIZE.width, 0, SCREEN_SIZE.width, 200)];
        PublicEventModel * model = _dataArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgh_url] placeholderImage:nil];
        imageView.tag = i + 1;
        [imageView addTarget:self action:@selector(imgClick:)];
        [_scrollView addSubview:imageView];
    }
    
    _scrollView.contentSize = CGSizeMake(SCREEN_SIZE.width * _dataArray.count, 200);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentOffset = CGPointMake(_currentIndex * SCREEN_SIZE.width, 0);
    
    // pageControl
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - 250, CGRectGetMaxY(_scrollView.frame) - 20, 200, 10)];
    _page.numberOfPages = _dataArray.count;
    _page.pageIndicatorTintColor = [UIColor whiteColor];
    _page.currentPageIndicatorTintColor = [UIColor redColor];
    _page.currentPage = _currentIndex;
    [_page addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_headerView addSubview:_page];
}

- (void)pageChanged:(UIPageControl *)page
{
    _currentIndex = page.currentPage;
    _scrollView.contentOffset = CGPointMake(_currentIndex * SCREEN_SIZE.width, 0);
}

/**
 *  headImage 点击事件
 */
- (void)imgClick:(MyImageView *)imgView
{
    
}

- (void)dealloc
{
    [_timer invalidate]; // 使定时器无效
    _timer = nil; // 释放定时器
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 116) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _headerView;
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"公众";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:nil rightItem:nil titleView:titleView];
    [self setupTableView];
}

/**
 *  启动一个定时器
 */
- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    [_timer setFireDate:[NSDate distantPast]];
}

/**
 *  更新头视图
 */
- (void)updateTimer
{
    _scrollView.contentOffset = CGPointMake(_currentIndex * SCREEN_SIZE.width, 0);
    _page.currentPage = _currentIndex;
    _currentIndex++;
    if (_currentIndex == 12) {
        _currentIndex = 0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeaderView];
    [self loadData];
    [self setupUI];
    [self startTimer];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint pointX = scrollView.contentOffset;
    
    NSInteger index = pointX.x / _scrollView.bounds.size.width;
    
    _page.currentPage = index;
    _currentIndex = index;
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    
    PublicEventCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PublicEventCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 191;
}

/**
 *  跳转
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 公众详情
    PublicEventDetailViewController * pdVc = [[PublicEventDetailViewController alloc] init];
    
    MyCATransition * animiation = [MyCATransition catransitionWithType:@"push" subType:@"fromLeft" duration:0.5 timingFunction:@"easeInEaseOut"];
    [self.navigationController.view.layer addAnimation:animiation forKey:@"animation"];
    
    [self.navigationController pushViewController:pdVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
