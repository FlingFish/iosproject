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
#import "settingCell.h"
#import "MBProgressHUD.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataArray; // 数据源
    UISwitch * _AutoLoginSwitch;
    BOOL _isRefresh; //  是否是正在刷新
}

@end

@implementation SettingViewController

- (instancetype)init
{
    if (self = [super init]) {
        _dataArray = @[@[@"消息推送"], @[@"修改密码", @"关于FunCourse"], @[@"清除缓存", @"版本更新"]];
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
 *  设置是否推送消息
 */
- (void)isPushMessage:(UISwitch *)sw
{
    // 创建一个串行线程队列
    dispatch_queue_t mySerialQueue = dispatch_queue_create("setting push", NULL);
    
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
    [self addFootView];
}

/**
 *  添加TableView脚视图
 */
- (void)addFootView
{
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 84)];
    [footView setBackgroundColor:[UIColor whiteColor]];
    // 退出登录
    UIButton * logOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, SCREEN_SIZE.width - 40, 44)];
    [logOutBtn setBackgroundColor:RGBACOLOR(222, 0, 20, 1.0)];
    
    // 取出登录的用户信息
    NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
    NSString * userName = [loginInfo objectForKey:kSDKUsername];
    
    [logOutBtn setTitle:[NSString stringWithFormat:@"退出登录[%@]", userName] forState:UIControlStateNormal];
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

/**
 *  检测缓存大小
 */
- (NSString *)checkCache
{
    NSString * cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    float cacheSize = [self folderSizeAtPath:cachePath];
    NSString * cacheSizeStr = [NSString stringWithFormat:@"%.1fM", cacheSize];
    
    return cacheSizeStr;
}

/**
 *  清理缓存
 */
- (void)clearnCache
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 取得cache目录
        NSString * cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        NSError * error = nil;
        for (NSString * subPath in files) {
            
            NSString * path = [cachePath stringByAppendingPathComponent:subPath];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    });
    
    [self performSelectorOnMainThread:@selector(clearFinish) withObject:nil waitUntilDone:YES];
}

/**
 *  清理完成
 */
- (void)clearFinish
{
    _isRefresh = YES;
    [_tableView reloadData]; // 刷新表格
    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) / 2.0, (self.view.frame.size.height - 150) / 2.0, 200, 150)];
    progress.labelText = [NSString stringWithFormat:@"清理缓存%@", [self checkCache]];
    progress.labelFont = [UIFont boldSystemFontOfSize:17];
    progress.mode = MBProgressHUDModeText;
    progress.animationType = MBProgressHUDAnimationFade;
    [self.view addSubview:progress];
    
    [progress showAnimated:YES whileExecutingBlock:^{
        sleep(2.0);
    } completionBlock:^{
        [progress removeFromSuperview];
        progress = nil;
    }];
}

/**
 *  单个文件的大小
 */
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/**
 *  遍历文件夹获得文件夹大小，返回多少M
 */
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    settingCell * cell = [settingCell initWithTableView:tableView];
    
    NSString * titleStr = _dataArray[indexPath.section][indexPath.row];
    cell.titleLabel.text = titleStr;
    
    if (indexPath.section == 0 && indexPath.row == 0 && !_isRefresh) {
        // 设置是否推送消息
        UISwitch * isPushSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - 90, 15, 40, 30)];
        [isPushSwitch addTarget:self action:@selector(isPushMessage:) forControlEvents:UIControlEventValueChanged];
        // 设置状态
        [isPushSwitch setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:@"pushMessage"] boolValue] animated:YES];
        [cell.contentView addSubview:isPushSwitch];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        cell.cacheSizeLabel.text = [self checkCache];
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        // 版本更新
        cell.versionLabel.text = @"当前版本 V1.0.0.1";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self clearnCache]; // 清理缓存
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
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
