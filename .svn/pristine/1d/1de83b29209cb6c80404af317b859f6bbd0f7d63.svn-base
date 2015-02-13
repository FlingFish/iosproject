//
//  PersonalScreenViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//
// 个人页面

#import "PersonalScreenViewController.h"
#import "PersonalInfoViewController.h"
#import "PersonalScreenCell.h"
#import "MyCourseViewController.h" 
#import "MyFavouriteViewController.h"
#import "FeedBackViewController.h"
#import "AppShareViewController.h"
#import "SettingViewController.h"
#import "GetCurrentDevice.h"
#import "MyImageView.h"
#import "UMSocial.h"

static CGFloat KImageOrginalHeight = 0;

@interface PersonalScreenViewController ()<UITableViewDataSource, UITableViewDelegate,UMSocialUIDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    MyImageView * _zoomImageView;
}

@end

@implementation PersonalScreenViewController

- (instancetype)init
{
    if (self = [super init]) {
        _zoomImageView = [[MyImageView alloc] init];
        [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/f9198618367adab47d5ff9e48bd4b31c8601e48e.jpg"] placeholderImage:[UIImage imageNamed:@"personBg2"]];
        [self setupHeaderView];
    }
    
    return self;
}

/**
 *  加载数据
 */
- (void)loadData
{
    NSArray * textArray  = @[@[@"我的动态", @"我的收藏"], @[@"反      馈", @"分      享"], @[@"设      置"]];
    
    _dataArray = [NSMutableArray arrayWithArray:textArray];
}

/**
 *  创建头视图
 */
- (void)setupHeaderView
{
    CGFloat height = 0;
    
    if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5])
    {
        height = 120;
    } else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5s])
    {
        height = 150;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6])
    {
        height = 200;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6_Plus])
    {
        height = 250;
    }
    
    KImageOrginalHeight = height;
    
    MyImageView * header = [[MyImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    header.image = [UIImage imageNamed:@"header.jpg"];
    header.layer.masksToBounds = YES;
    header.layer.cornerRadius = 25;
    header.userInteractionEnabled = YES;
    [header addTarget:self action:@selector(PushToPersonalInfo)];
    [_zoomImageView addSubview:header];
    
    
    UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(header.frame) + 10, header.frame.origin.y + 10, 100, 20)];
    nickNameLabel.text = @"小倩";
    nickNameLabel.font = [UIFont boldSystemFontOfSize:16];
    nickNameLabel.textColor = [UIColor redColor];
    
    [_zoomImageView addSubview:nickNameLabel];
}

/**
 *  初始化tableview
 */
- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(KImageOrginalHeight, 0, 0, 0);
    
    // 去掉cell留白 iOS 7
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // iOS 8
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    [_tableView addSubview:_zoomImageView];
    [self.view addSubview:_tableView];
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"我";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:nil rightItem:nil titleView:titleView];
    // 创建UItableView
    [self setupTableView];
}

-(void)PushToPersonalInfo
{
    PersonalInfoViewController *pVC = [[PersonalInfoViewController alloc] init];
    pVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _zoomImageView.frame = CGRectMake(0, -KImageOrginalHeight, SCREEN_SIZE.width, KImageOrginalHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
}

/**
 *  头部背景伸缩效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffSet = scrollView.contentOffset.y;
    if (yOffSet < -KImageOrginalHeight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = yOffSet;
        frame.size.height = -yOffSet;
        _zoomImageView.frame = frame;
    }
}

/**
 *  UITableView代理方法
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

/**
 *  cell 将要显示的时候调用
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去掉cell的留白 iOS 7
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    // iOS 8
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    
    PersonalScreenCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[PersonalScreenCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.infoLabel.text = _dataArray[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 我的动态
            MyCourseViewController * course = [[MyCourseViewController alloc] init];
            course.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:course animated:YES];
        }else if (indexPath.row == 1)
        {
            // 我的收藏
            MyFavouriteViewController * favourite = [[MyFavouriteViewController alloc] init];
            favourite.hidesBottomBarWhenPushed = YES; // 当push的时候隐藏TabBar
            [self.navigationController pushViewController:favourite animated:YES];
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            // 反馈
            FeedBackViewController * feedBack = [[FeedBackViewController alloc] init];
            feedBack.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:feedBack animated:YES];
        }else if (indexPath.row == 1)
        {
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"54d493f4fd98c59e070003e6"
                                              shareText:@"摩天居士+捉鬼 http://incorner.cn"
                                             shareImage:[UIImage imageNamed:@"cornerShare"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToWechatTimeline,nil]
                                               delegate:self];
        }
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            // 设置页面
            SettingViewController * setting = [[SettingViewController alloc] init];
            setting.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setting animated:YES];
        }
    }
}

//-(BOOL)isDirectShareInIconActionSheet
//{
//    return YES;
//}
//
//
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
