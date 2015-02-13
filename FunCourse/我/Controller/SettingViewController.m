//
//  SettingViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "SettingViewController.h"
#import "ApplyViewController.h"
#import "GetCurrentDevice.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataArray; // 数据源
    UISwitch * _AutoLoginSwitch;
}

@end

@implementation SettingViewController

- (instancetype)init
{
    if (self = [super init]) {
        _dataArray = @[@"自动登录", @"消息推送", @"修改密码", @"关于FunCourse"];
    }
    
    return self;
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"设置";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
    
    [self setupTableView];
}

/**
 *  设置是否自动登录
 */
- (void)isAutoLogin:(UISwitch *)sw
{
    dispatch_queue_t mySeriaQueue = dispatch_queue_create("setting AutoLogin", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(mySeriaQueue, ^{
        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:sw.on];
    });
}

/**
 *  设置是否推送消息
 */
- (void)isPushMessage:(UISwitch *)sw
{
    // 创建一个串行线程队列
    dispatch_queue_t mySerialQueue = dispatch_queue_create("setting push", DISPATCH_QUEUE_SERIAL);
    
    // 异步执行线程任务
    dispatch_async(mySerialQueue, ^{
        // 将状态保存到偏好设置
        [[NSUserDefaults standardUserDefaults] setBool:sw.on forKey:@"pushMessage"];
   });
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  初始化TableView
 */
- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 49 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [self addFootView];
}

/**
 *  添加TableView脚视图
 */
- (void)addFootView
{
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_SIZE.width, 60)];
    [footView setBackgroundColor:[UIColor whiteColor]];
    // 退出登录
    UIButton * logOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, SCREEN_SIZE.width - 40, 44)];
    [logOutBtn setBackgroundColor:RGBACOLOR(222, 0, 20, 1.0)];
    
    // 取出登录的用户信息
    NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
    NSString * userName = [loginInfo objectForKey:kSDKUsername];
    
    [logOutBtn setTitle:[NSString stringWithFormat:@"退出登录(%@)", userName] forState:UIControlStateNormal];
    logOutBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:logOutBtn];
    
    _tableView.tableFooterView = footView;
}

/**
 *  退出登录 (注销)
 */
- (void)logOut
{
    __weak SettingViewController * weakSelf = self;
    
    [self showHudInView:self.view hint:@"正在退出..."];
    // 注销后会把isAutoLogin值设置为NO
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        [weakSelf hideHud];
        
        if (error) {
            [weakSelf showHint:error.description];
        }else {
            // 清空申请消息数据源
            [[ApplyViewController shareController] clear];
            // 发送登录状态变化的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            
            // 清空应用程序提醒数值
            if ([[GetCurrentDevice getCurrentSystemVersion] isEqualToString:iOS8]) {
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil]];
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            }
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
        
    } onQueue:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    static NSString * cellId = @"cellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString * titleStr = _dataArray[indexPath.row];
    cell.textLabel.text = titleStr;
    cell.textLabel.font = [UIFont systemFontOfSize:19];
    
    if (indexPath.row == 0) {
        // 设置是否自动登录
        _AutoLoginSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - 90, 15, 40, 30)];
        [_AutoLoginSwitch addTarget:self action:@selector(isAutoLogin:) forControlEvents:UIControlEventValueChanged];
        [_AutoLoginSwitch setOn:[[EaseMob sharedInstance].chatManager isAutoLoginEnabled] animated:YES];
        [cell.contentView addSubview:_AutoLoginSwitch];
    }else if (indexPath.row == 1) {
        // 设置是否推送消息
        UISwitch * isPushSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - 90, 15, 40, 30)];
        [isPushSwitch addTarget:self action:@selector(isPushMessage:) forControlEvents:UIControlEventValueChanged];
        // 设置状态
        [isPushSwitch setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:@"pushMessage"] boolValue] animated:YES];
        [cell.contentView addSubview:isPushSwitch];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
