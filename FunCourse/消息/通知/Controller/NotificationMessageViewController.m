//
//  NotificationMessageViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//  通知

#import "NotificationMessageViewController.h"
#import "SRRefreshView.h"
#import "ApplyViewController.h"
#import "ChatListViewController.h"
#import "GetCurrentDevice.h"
#import "NeenedEvaluateMessageViewController.h"
#import "NotifiMessageCell.h"

@interface NotificationMessageViewController ()<UITableViewDataSource, UITableViewDelegate, SRRefreshDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArray;
// 刷新
@property (nonatomic, strong) SRRefreshView * refreshView;

@end

@implementation NotificationMessageViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:SETUP_UNREADAPPLYCOUNT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:ReloadChatList_Notification object:nil];
        _dataArray = @[@[@"系统通知", @"待评价通知", @"课程通知"], @[@"申请通知", @"会        话"]];
    }
    return self;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 0.2)]; // 消除抖动
        header.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = header;
        
        // 去掉多余的空白行
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView addSubview:self.refreshView];
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
    return _tableView;
}

/**
 *  创建SRRefreshView
 */
- (SRRefreshView *)refreshView
{
    if (!_refreshView) {
        _refreshView = [[SRRefreshView alloc] init];
        _refreshView.upInset = 0;
        _refreshView.delegate = self;
        _refreshView.backgroundColor = [UIColor whiteColor];
        _refreshView.slimeMissWhenGoingBack = YES;
        _refreshView.slime.bodyColor = [UIColor grayColor];
        _refreshView.slime.skinColor = [UIColor grayColor];
        _refreshView.slime.shadowColor = [UIColor grayColor];
        _refreshView.slime.lineWith = 1;
        _refreshView.slime.shadowBlur = 4;
    }
    return _refreshView;
}

/**
 *  刷新表格和数据源
 */
- (void)refreshTableView
{
    [_tableView reloadData];
}


- (void)setupUI
{
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [_tableView reloadData];
}

/**
 *  获取未读请求数
 */
- (NSInteger)getApplyCount
{
    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    
    return count;
}

/**
 *  获取未读消息数
 */
- (NSInteger)getMessageCount
{
    // 获取当前会话
    NSArray * conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger count = 0;
    for (EMConversation * conversation in conversations) {
        count += conversation.unreadMessagesCount;
    }
    
    return count;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifiMessageCell * cell = [NotifiMessageCell cellWithTableView:tableView];
    
    NSString * str = _dataArray[indexPath.section][indexPath.row];
    cell.titleLabel.text = str;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 系统通知
        }else if (indexPath.row == 1) {
            // 待评价通知
        }else if (indexPath.row == 2) {
            // 课程通知
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // 申请通知
            cell.unreadApplyCount = [self getApplyCount];
        }else if (indexPath.row == 1) {
            // 会话通知
            cell.unreadMessageCount = [self getMessageCount];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 系统通知
            
        }else if (indexPath.row == 1) {
            // 待评价通知
            NeenedEvaluateMessageViewController *needEvaluateVC = [[NeenedEvaluateMessageViewController alloc] init];
            needEvaluateVC.superNvc = self.superNvc;
            needEvaluateVC.hidesBottomBarWhenPushed = YES;
            [self.superNvc pushViewController:needEvaluateVC animated:YES];
        }else if (indexPath.row == 2) {
            // 课程通知
            
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // 跳转到申请与通知页面
            ApplyViewController * avc = [ApplyViewController shareController];
            avc.hidesBottomBarWhenPushed = YES;
            
            [self.superNvc pushViewController:avc animated:YES];
        }else if (indexPath.row == 1) {
            // 跳转到会话页面
            ChatListViewController * chatListVc = [ChatListViewController sharedChatListController];
            chatListVc.superNav = self.superNvc;
            chatListVc.hidesBottomBarWhenPushed = YES;
            [self.superNvc pushViewController:chatListVc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

#pragma mark - ScrollViewDelegate

// 滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshView scrollViewDidScroll];
}

// 停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshView scrollViewDidEndDraging];
}

#pragma mark - SRRefreshViewDelegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self refreshTableView]; // 刷新
    [_refreshView endRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
