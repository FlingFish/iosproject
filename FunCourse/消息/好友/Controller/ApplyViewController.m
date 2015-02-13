//
//  ApplyViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/31.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "ApplyViewController.h"
#import "ApplyFriendCell.h"
#import "ApplyEntity.h" // 数据模型
#import "FriendListScreenViewController.h"

@interface ApplyViewController ()<ApplyFriendCellDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    UILabel * _infoLabel; // 暂无通知
}

@end

@implementation ApplyViewController

- (instancetype)init
{
    if (self = [super init]) {
        _dataSource = [[NSMutableArray alloc] init];
        [self setupTableView]; // 必须在此处初始化TableView
    }
    
    return self;
}

/**
 *  创建单例
 */
+ (instancetype)shareController
{
    static ApplyViewController * controller = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    
    return controller;
}

/**
 *  getter
 */
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

/**
 *  获取登录的用户名
 */
- (NSString *)loginUserName
{
    NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
    
    return [loginInfo objectForKey:kSDKUsername];
}

/**
 *  初始化UItableView
 */
- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // 此方法是去掉多余的空白行
    _tableView.tableFooterView = [[UIView alloc] init];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    
    [self.view addSubview:_tableView];
}

- (void)setupUI
{
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"申请与通知";
    
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
    
    // 暂无消息提醒
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64)];
    _infoLabel.text = @"暂无会话哦，快去寻觅知音吧!";
    _infoLabel.textColor = [UIColor grayColor];
    _infoLabel.font = [UIFont systemFontOfSize:20];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.hidden = YES; // 隐藏
    [self.view addSubview:_infoLabel];
}

/**
 *  viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self loadDataSourceFromLocalDB]; // 获取好友申请的数据
    
    [_tableView reloadData];
}

/**
 *  返回
 */
- (void)back
{
    // 发送通知 通知上一个页面未读申请数变化
    [[NSNotificationCenter defaultCenter] postNotificationName:SETUP_UNREADAPPLYCOUNT object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellId";
    ApplyFriendCell * cell = (ApplyFriendCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (nil == cell) {
        cell = [[ApplyFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    
    // 有请求数据
    if (self.dataSource.count > indexPath.row) {
        // 取出对应的模型数据
        ApplyEntity * entity = [self.dataSource objectAtIndex:indexPath.row];
        if (entity) {
            cell.indexPath = indexPath; // 记录indexPath
            // 取出请求的类型
            ApplyStyle appStyle = [entity.style intValue];
            // 群组邀请通知
            if (appStyle == ApplyStyleGroupInvitation) {
                cell.titleLabel.text = @"群组邀请";
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:entity.headerImage] placeholderImage:nil];
            } else if (appStyle == ApplyStyleJoinGroup) {
                // 加入群组的通知
                cell.titleLabel.text = @"群组通知";
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:entity.headerImage] placeholderImage:nil];
            }else if (appStyle == ApplyStyleFriend) {
                // 好友请求通知
                cell.titleLabel.text = entity.applicantUsername;
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:entity.headerImage] placeholderImage:nil];
            }
            
            cell.contentLabel.text = entity.reason; // 理由
        }
    }
    
    return cell;
}

/**
 *  cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 不允许选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ApplyFriendCellDelegate

/**
 *  接受申请代理方法
 *  接受好友申请和群组申请
 */
- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (indexPath.row < [self.dataSource count]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 有申请
                [self showHudInView:self.view hint:@"正在发送申请..."];
            });
            
            ApplyEntity * entity = [self.dataSource objectAtIndex:indexPath.row];
            ApplyStyle applyStyle = [entity.style intValue];
            
            EMError * error;
            
            if (applyStyle == ApplyStyleGroupInvitation) {
                // 接受并加入群组
                [[EaseMob sharedInstance].chatManager acceptInvitationFromGroup:entity.groupId error:&error];
            }else if (applyStyle == ApplyStyleJoinGroup) {
                // 同意加入群组的申请
                [[EaseMob sharedInstance].chatManager acceptApplyJoinGroup:entity.groupId groupname:entity.groupSubject applicant:entity.applicantUsername error:&error];
            }else if (applyStyle == ApplyStyleFriend) {
                // 接受某个好友发送的好友请求
                [[EaseMob sharedInstance].chatManager acceptBuddyRequest:entity.applicantUsername error:&error];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHud];
            });
            
            if (!error) {
                // 成功
                [self.dataSource removeObject:entity];
                [entity deleteEntity];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
                
                [self save]; // 保存到数据库
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showHint:@"接受失败"];
                });
            }
        }
    });
}

/**
 *  拒绝请求代理方法
 */
- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (indexPath.row < [self.dataSource count]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 有申请
                [self showHudInView:self.view hint:@"正在发送申请..."];
            });
            
            ApplyEntity * entity = [self.dataSource objectAtIndex:indexPath.row];
            ApplyStyle applyStyle = [entity.style intValue];
            EMError * error = nil;
            
            if (applyStyle == ApplyStyleGroupInvitation) {
                // 拒绝群组邀请
                [[EaseMob sharedInstance].chatManager rejectInvitationForGroup:entity.groupId toInviter:entity.applicantUsername reason:nil];
            }else if (applyStyle == ApplyStyleJoinGroup) {
                // 被拒绝加入群组
                NSString * reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", entity.groupSubject];
                [[EaseMob sharedInstance].chatManager rejectApplyJoinGroup:entity.groupId groupname:entity.groupSubject toApplicant:entity.applicantUsername reason:reason];
            }else if (applyStyle == ApplyStyleFriend) {
                // 拒绝好友请求
                [[EaseMob sharedInstance].chatManager rejectBuddyRequest:entity.applicantUsername reason:nil error:&error];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHud];
            });
            
            if (!error) {
                // 成功
                [self.dataSource removeObject:entity]; // 从数据源删除
                [entity deleteEntity]; // 从数据库删除
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
                
                [self save]; // 保存
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showHint:@"拒绝失败"];
                });
            }
        }
    });
}

#pragma mark - 提供给外部的方法

/**
 *  添加新的请求
 */
- (void)addNewApply:(NSDictionary *)dict
{
    if (dict && [dict count] > 0) {
        NSString * applyUserName = [dict objectForKey:@"username"];
        ApplyStyle style = [[dict objectForKey:@"applyStyle"] intValue];
        
        if (applyUserName && applyUserName.length > 0) {
            // 循环遍历所有的请求
            for (NSInteger i = [self.dataSource count] - 1; i >= 0; i--) {
                ApplyEntity * oldEntity = [_dataSource objectAtIndex:i];
                ApplyStyle oldStyle = [oldEntity.style intValue];
                // 判断请求是否和现有的请求一样
                if (oldStyle == style && [applyUserName isEqualToString:oldEntity.applicantUsername]) {
                    if (style != ApplyStyleFriend) {
                        // 不是好友请求
                        NSString * newGroupId = [dict objectForKey:@"groupname"];
                        // 有相同的请求
                        if (newGroupId || [newGroupId length] > 0 || [newGroupId isEqualToString:oldEntity.groupId]) {
                            break;
                        }
                    }
                    
                    oldEntity.reason = [dict objectForKey:@"applyMessage"];
                    [_dataSource removeObject:oldEntity];
                    [_dataSource insertObject:oldEntity atIndex:0];
                    [_tableView reloadData];
                    
                    [self save]; // 保存
                    
                    return;
                }
            }
            
            // 新的请求
            ApplyEntity * newEntity = [ApplyEntity createEntity];
            newEntity.applicantUsername = [dict objectForKey:@"username"];
            newEntity.style = [dict objectForKey:@"applyStyle"];
            newEntity.reason = [dict objectForKey:@"applyMessage"];
            newEntity.headerImage = [dict objectForKey:@"headImage"];
            
            // 得到登录的用户信息
            NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
            NSString * loginName = [loginInfo objectForKey:kSDKUsername];
            // 设置接收者的用户名
            newEntity.receiverUsername = loginName;
            
            // 得到群组信息
            NSString * groupId = [dict objectForKey:@"groupId"];
            newEntity.groupId = (groupId != nil && groupId.length > 0)? groupId : @"";
            
            NSString * groupSubject = [dict objectForKey:@"groupname"];
            newEntity.groupSubject = (groupSubject != nil && groupSubject.length > 0)? groupSubject : @"";
            
            [_dataSource insertObject:newEntity atIndex:0];
            [_tableView reloadData];
            
            if (style != ApplyStyleFriend) {
                [self save];
            }
        }
    }
}

/**
 *  从本地数据库CoreData中加载数据
 */
- (void)loadDataSourceFromLocalDB
{
    [_dataSource removeAllObjects];
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    // 获取当前登录的用户名
    NSString *loginName = [loginInfo objectForKey:kSDKUsername];
    if(loginName && [loginName length] > 0)
    {
        NSPredicate *deletePredicate = [NSPredicate predicateWithFormat:@"receiverUsername = %@ and style = %i", loginName, ApplyStyleFriend];
        [ApplyEntity deleteAllMatchingPredicate:deletePredicate];
        
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"receiverUsername = %@", loginName];
        NSFetchRequest *request = [ApplyEntity requestAllWithPredicate:searchPredicate];
        NSArray *applyArray = [ApplyEntity executeFetchRequest:request];
        [self.dataSource addObjectsFromArray:applyArray];
        [_tableView reloadData];
    }
}

/**
 *  将数据保存到CoreData中
 */
- (void)save
{
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
}

/**
 *  清空数据源
 */
- (void)clear
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_dataSource removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
           [_tableView reloadData]; // 重新刷新数据
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
