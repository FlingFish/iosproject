//
//  FriendListScreenViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

/*
 **************************************************
 *           好友列表 -- 群组列表 -- 黑名单列表       *
 **************************************************
                                                  */

#import "FriendListScreenViewController.h"
#import "XRFriendGroup.h"
#import "XRHeaderView.h"
#import "FriendListCell.h"
#import "SRRefreshView.h"
#import "ChatViewController.h"
#import "EMBuddyModel.h"
#import "EMGroupModel.h"
#import "BlackModel.h"
#import "LoginUser.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

#import "DataBaseManager.h"

@interface FriendListScreenViewController ()<IChatManagerDelegate, UITableViewDataSource, UITableViewDelegate, XRHeaderViewDelegate, SRRefreshDelegate, FriendCellDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) SRRefreshView * srrefreshView;

@property (nonatomic, strong) NSMutableArray * friendDataSource; // 好友列表
@property (nonatomic, strong) NSMutableArray * groupDataSource;  // 群组列表
@property (nonatomic, strong) NSMutableArray * blackDataSource;  // 黑名单
@property (nonatomic, strong) NSMutableArray * groupsArray;

@property (nonatomic, assign) BOOL isRefreshFriendList; // 是否正在刷新好友
@property (nonatomic, assign) BOOL isRefreshGroupList;  // 是否正在刷新群组
@property (nonatomic, assign) BOOL isRefreshBlackList;  // 是否正在刷新黑名单

@property (nonatomic, assign) BOOL isRefresh; // 是否是刷新操作

// 长按cell的索引
@property (nonatomic, strong) NSIndexPath * longPressIndexPath;
@property (nonatomic, assign) GroupOcceptType groupOcceptType; // 群组类型

@property (nonatomic, assign) BOOL isOpenFriendList; // 是否展开好友列表
@property (nonatomic, assign) BOOL isOpenGroupList;  // 是否展开群组列表
@property (nonatomic, assign) BOOL isOpenBlackList;  // 是否展开黑名单列表
@property (nonatomic, assign) BOOL flag;             // 标志是否已经下载完成
@property (nonatomic, strong) MBProgressHUD * progress;

// 数据库管理
@property (nonatomic, strong) DataBaseManager * manager;
@property (nonatomic, assign) BOOL isLoadFromNet; // 是否从网络加载数据
@property (nonatomic, strong) __block UIActionSheet * actionSheet;

@end

static int icount = 0;

@implementation FriendListScreenViewController

/**
 *  AppDelegate助手方法
 */
- (AppDelegate *)defaultDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    if (self = [super init]) {
        // 刷新好友列表
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFriendAndBlack) name:ReloadFriendList_Notification object:nil];
        // 注册环信
        [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
        _groupsArray = [[NSMutableArray alloc] init];
        _friendDataSource = [[NSMutableArray alloc] init];
        _groupDataSource = [[NSMutableArray alloc] init];
        _blackDataSource = [[NSMutableArray alloc] init];
        
        // 加载数据
        [self reloadGroupsData];
    }
    
    return self;
}

- (DataBaseManager *)manager
{
    if (_manager == nil) {
        _manager = [DataBaseManager defaultDataBaseManager];
    }
    return _manager;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64 - 49 - 40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        [_tableView addSubview:self.srrefreshView];
        [_tableView reloadData];
        UIView * view = [[UIView alloc] init];
        _tableView.tableFooterView = view;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 70, 0, 0)];
        }
    }
    
    return _tableView;
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

/**
 *  重排数据源
 */
- (void)reSortMyData
{
    [_groupsArray removeAllObjects];
    // 好友
    XRFriendGroup * frineds = [XRFriendGroup groupWithArray:_friendDataSource groupName:@"我的好友"];
    [_groupsArray addObject:frineds];
    // 群组
    XRFriendGroup * groups = [XRFriendGroup groupWithArray:_groupDataSource groupName:@"我的群组"];
    [_groupsArray addObject:groups];
    // 黑名单
    XRFriendGroup * blacks = [XRFriendGroup groupWithArray:_blackDataSource groupName:@"黑名单"];
    [_groupsArray addObject:blacks];
    
    if (self.isLoadFromNet) { // 从网络加载时存入数据库
        [self addDataToDB];
    }
    
    if (icount == 0) {
        [self setupUI];
        icount++;
    }
    if (_isRefresh) {
        [_srrefreshView endRefresh];
    }
    [_tableView reloadData];
}

- (void)reloadFriendAndBlack
{
    [self reloadMyFriendList];
}

/**
 *  刷新好友列表
 */
- (void)reloadMyFriendList
{
    NSInvocationOperation * op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadFriendData) object:nil];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

/**
 *  获取好友列表
 */
- (void)loadFriendData
{
    if (_friendDataSource.count > 0) {
        [_friendDataSource removeAllObjects];
    }
    EMError * error = nil;
    NSArray * friendArray = [[[EaseMob sharedInstance].chatManager fetchBuddyListWithError:&error] copy];
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    // 判断双方是不是好友
    for (EMBuddy * buddy in friendArray) {
        if (buddy.followState != eEMBuddyFollowState_NotFollowed) {
            // 是好友
            // 转为EMBuddyModel
            EMBuddyModel * buddyModel = [[EMBuddyModel alloc] init];
            buddyModel.username = buddy.username;
            buddyModel.followState = buddy.followState;
            buddyModel.headerUrl = @"";
            buddyModel.headerData = UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/pic/item/9f510fb30f2442a709ebdda2d243ad4bd01302cb.jpg"]]], 1.0);;
            buddyModel.showStr = @"追求卓越，成功就会在不经意间追上你。"; // 个性签名
            [arr addObject:buddyModel];
        }
    }
    if (_friendDataSource.count > 0) {
        [_friendDataSource removeAllObjects];
    }
    [_friendDataSource addObjectsFromArray:arr];
    
    [[NSOperationQueue mainQueue] addOperation:[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(reSortMyData) object:nil]];
}

/**
 *  刷新群组列表
 */
- (void)reloadMyGroupList
{
    NSInvocationOperation * op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadGroupData) object:nil];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

/**
 *  获取群组列表
 */
- (void)loadGroupData
{
    if (_groupDataSource.count > 0) {
        [_groupDataSource removeAllObjects];
    }
    EMError * error = nil;
    
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    
    NSArray * groupArray = [[[[EaseMob sharedInstance] chatManager] fetchMyGroupsListWithError:&error] copy];
    // 将EMGroup转为EMGroupModel
    for (EMGroup * group in groupArray) {
        EMGroupModel * groupModel = [[EMGroupModel alloc] init];
        groupModel.groupSubject = group.groupSubject;
        groupModel.groupDescription = group.groupDescription;
        groupModel.groupId = group.groupId;
        groupModel.owner = group.owner;
        groupModel.occupants = group.occupants;
        groupModel.headData = UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pic.qqtn.com/file/2013/2014-7/2014070809064941012.png"]]], 1.0);
        [arr addObject:groupModel];
    }
    
    if ([_groupDataSource count] > 0) {
        [_groupDataSource removeAllObjects];
    }
    
    [_groupDataSource addObjectsFromArray:arr];
    
    [[NSOperationQueue mainQueue] addOperation:[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(reSortMyData) object:nil]];
}

/**
 *  刷新黑名单列表
 */
- (void)reloadMyBlackList
{
    NSInvocationOperation * op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadBlackListData) object:nil];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

/**
 *  获取黑名单列表
 */
- (void)loadBlackListData
{
    self.isRefreshBlackList = YES;
    if (_blackDataSource.count > 0) {
        [_blackDataSource removeAllObjects];
    }
    EMError * error = nil;
    
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    
    NSArray * blackArray = [[EaseMob sharedInstance].chatManager fetchBlockedList:&error];
    // 将黑名单转为blackModel
    for (NSString * blackName in blackArray) {
        BlackModel * blackModel = [[BlackModel alloc] init];
        blackModel.blackName = blackName;
        blackModel.headdata = UIImageJPEGRepresentation([UIImage imageNamed:@"header.jpg"], 1.0);
        blackModel.showStr = @"宠辱不惊，任庭前花开花落。去留无意，望天上云卷云舒。";
        [arr addObject:blackModel];
    }
    
    if ([_blackDataSource count] > 0) {
        [_blackDataSource removeAllObjects];
    }
    
    [_blackDataSource addObjectsFromArray:arr];
    
    NSInvocationOperation * op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(reSortMyData) object:nil];
    [[NSOperationQueue mainQueue] addOperation:op];
}

/**
 *  刷新view
 */
- (SRRefreshView *)srrefreshView
{
    if (_srrefreshView == nil) {
        _srrefreshView = [[SRRefreshView alloc] init];
        _srrefreshView.delegate = self;
        _srrefreshView.upInset = 0;
        _srrefreshView.slimeMissWhenGoingBack = YES;
        _srrefreshView.slime.bodyColor = [UIColor grayColor];
        _srrefreshView.slime.skinColor = [UIColor grayColor];
        _srrefreshView.slime.lineWith = 1;
        _srrefreshView.slime.shadowBlur = 4;
        _srrefreshView.slime.shadowColor = [UIColor grayColor];
        _srrefreshView.backgroundColor = [UIColor whiteColor];
    }
    
    return _srrefreshView;
}

#pragma mark - 刷新数据操作

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_srrefreshView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_srrefreshView scrollViewDidEndDraging];
}

#pragma mark - 本地数据库操作

/**
 *  添加好友列表数据到数据库中
 */
- (void)addFriendListToDB
{
    for (EMBuddyModel *buddyModel in _friendDataSource) {
        [self.manager insertFriendWithEMBuddyModel:buddyModel];
    }
}

/**
 *  添加群组列表到数据库中
 */
- (void)addGroupListToDB
{
    for (EMGroupModel * groupModel in _groupDataSource) {
        [self.manager insertGroupWithEMGroupModel:groupModel];
    }
}

/**
 *  添加黑名单列表到数据库中
 */
- (void)addBlackListToDB
{
    for (BlackModel * model in _blackDataSource) {
        [self.manager insertBlackWithBlackModel:model];
    }
}

- (void)addDataToDB
{
    // 加载到数据库中
    [self addFriendListToDB];
    [self addGroupListToDB];
    [self addBlackListToDB];
}

/**
 *  从本地缓存加载数据
 */
- (void)loadDataFromLocalDB
{
    // 此处不能起线程 会影响UI
    // 加载好友列表
    NSArray * fArray = [self.manager fetchFriendListWithLoginUserName:[[LoginUser sharedUserInfo] userName]];
    if ([_friendDataSource count] > 0) {
        [_friendDataSource removeAllObjects];
    }
    [_friendDataSource addObjectsFromArray:fArray];
    
    // 加载群组列表
    NSArray * gArray = [self.manager fetchGroupListWithLoginUserName:[[LoginUser sharedUserInfo] userName]];
    if ([_groupDataSource count] > 0) {
        [_groupDataSource removeAllObjects];
    }
    [_groupDataSource addObjectsFromArray:gArray];
    
    // 加载黑名单
    NSArray * bArray = [self.manager fetchBlackListWithLoginUserName:[[LoginUser sharedUserInfo] userName]];
    if ([_blackDataSource count] > 0) {
        [_blackDataSource removeAllObjects];
    }
    
    [_blackDataSource addObjectsFromArray:bArray];
    
    [self reSortMyData];
}

#pragma mark - 从网络加载数据

/**
 *  从网络加载数据
 */
- (void)loadDataFromNet
{
    // 将数据下载放到操作队列中
    NSInvocationOperation * op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

- (void)loadData
{
    [self reloadMyFriendList];
    usleep(70000);
    [self reloadMyGroupList];
    usleep(70000);
    [self reloadMyBlackList];
    usleep(10000);
}

/**
 *  刷新好友 群组 黑名单
 */
- (void)reloadGroupsData
{
    if ([AppDelegate isEnableNetwork]) {
        // 有网络
        self.isLoadFromNet = YES;
        [self loadData]; // 从网络加载
    }else {
        self.isLoadFromNet = NO;
        [self loadDataFromLocalDB]; // 从本地加载
    }
}

#pragma mark - SRRefreshViewDelegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    self.isRefresh = YES;
    [self reloadGroupsData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _groupsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XRFriendGroup * group = _groupsArray[section];
    if (section == 0 && self.isOpenFriendList == YES) {   // 好友操作 展开好友列表
        group.isOpened = YES;
    }else if (section ==1 && self.isOpenGroupList) {
        group.isOpened = YES;
    }else if (section == 2 && self.isOpenBlackList) {
        group.isOpened = YES;
    }
    return (group.isOpened == YES? group.friends.count : 0);
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
    FriendListCell * cell = [FriendListCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    XRFriendGroup * group = [_groupsArray objectAtIndex:indexPath.section];
    if (indexPath.section == 0) {
        if (indexPath.row < _friendDataSource.count) {
            // 好友列表
            EMBuddyModel * buddyModel = group.friends[indexPath.row];
            cell.type = FriendType;
            cell.headImageView.image = [UIImage imageWithData:buddyModel.headerData];
            cell.nickLabel.text = buddyModel.username;
            cell.showLabel.text = buddyModel.showStr;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row < _groupDataSource.count) {
            // 群组列表
            EMGroupModel * groupModel = group.friends[indexPath.row];
            cell.type = GroupType;
            cell.headImageView.image = [UIImage imageWithData:groupModel.headData];
            cell.nickLabel.text = groupModel.groupSubject;
            cell.showLabel.text = nil;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row < _blackDataSource.count) {
            // 黑名单
            BlackModel * model = group.friends[indexPath.row];
            cell.type = BlackType;
            cell.headImageView.image = [UIImage imageWithData:model.headdata];
            cell.nickLabel.text = model.blackName;
            cell.showLabel.text = model.showStr;
        }
    }
    
    return cell;
}

/**
 *  选中cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        // 好友
        EMBuddyModel * buddyModel = [self.friendDataSource objectAtIndex:indexPath.row];
        ChatViewController * chatVc = [[ChatViewController alloc] initWithChatter:buddyModel.username isGroup:NO];
        chatVc.superNav = self.superNvc;
        chatVc.nickName = buddyModel.username;
        chatVc.hidesBottomBarWhenPushed = YES;
        // 跳转到单聊页面
        [self.superNvc pushViewController:chatVc animated:YES];
    }else if (indexPath.section == 1) {
        // 群组
        EMGroupModel * groupModel = _groupDataSource[indexPath.row];
        ChatViewController * chatVc = [[ChatViewController alloc] initWithChatter:groupModel.groupId isGroup:YES];
        chatVc.superNav = self.superNvc;
        chatVc.nickName = groupModel.groupSubject; // 群组主题
        chatVc.hidesBottomBarWhenPushed = YES;
        // 跳转到群聊页面
        [self.superNvc pushViewController:chatVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

#pragma mark - FriendCellDelegate

- (void)cellLongPressForRowAtIndePath:(NSIndexPath *)indexPath
{
    _longPressIndexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    __block NSString * message;
    if (indexPath.section == 0) {
        // 好友操作
        message = @"删除该好友";
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:message otherButtonTitles:@"移入黑名单", nil];
        [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    }else if (indexPath.section == 1) {
        if (![AppDelegate isEnableNetwork]) {
            // 没有网络
            NSString * message = @"群组操作失败，请检查网络";
            __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
            progress.labelText = message;
            progress.labelFont = [UIFont boldSystemFontOfSize:17];
            progress.mode = MBProgressHUDModeText;
            progress.animationType = MBProgressHUDAnimationFade;
            [weakSelf.view addSubview:progress];
            
            [progress showAnimated:YES whileExecutingBlock:^{
                sleep(2.0);
            } completionBlock:^{
                [progress removeFromSuperview];
                progress = nil;
            }];
        }else {
            // 群组操作 判断是自己的群组 还是加的群组
            __block EMGroupModel * groupModel = [_groupDataSource objectAtIndex:indexPath.row];
            NSString * loginUserName = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
            
            [[EaseMob sharedInstance].chatManager asyncFetchGroupInfo:groupModel.groupId completion:^(EMGroup *group, EMError *error) {
                groupModel.owner = group.owner;
            } onQueue:nil];
            if ([groupModel.owner isEqualToString:loginUserName]) {
                // 自己创建的群组
                self.groupOcceptType = GroupOcceptTypeOwner;
                message = @"解散该群";
            }else {
                // 别人创建的群组
                self.groupOcceptType = GroupOcceptTypeMemer;
                message = @"退出该群";
            }
            self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:message otherButtonTitles:nil, nil];
            [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
        }
    }else if (indexPath.section == 2) {
        // 黑名单操作
        message = @"移除黑名单";
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:message otherButtonTitles:nil, nil];
        [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak typeof(self) weakSelf = self;
    if (buttonIndex != actionSheet.cancelButtonIndex && _longPressIndexPath) {
        if (_longPressIndexPath.section == 0) {
            if (buttonIndex == 0) {
                // 检测网络
                if ([AppDelegate isEnableNetwork]) {
                    // 有网络 可以执行删除操作
                    // 删除好友操作
                    EMBuddyModel * buddyModel = [_friendDataSource objectAtIndex:_longPressIndexPath.row];
                    // 从数据源删除
                    [_friendDataSource removeObject:buddyModel];
                    // 从数据库删除
                    [_manager deleteFriendWithFriendName:buddyModel.username];
                    
                    self.isOpenFriendList = YES; // 展开好友列表
                    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_longPressIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    // 从环信删除
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        EMError * error = nil;
                        [[EaseMob sharedInstance].chatManager removeBuddy:buddyModel.username removeFromRemote:YES error:&error];
                        if (error == nil) {
                            // 删除会话
                            [[EaseMob sharedInstance].chatManager removeConversationByChatter:buddyModel.username deleteMessages:YES];
                        }
                    });
                }else {
                    // 无网络 提示删除失败 请检查网络
                    NSString * message = @"删除好友失败，请检查网络";
                    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                    progress.labelText = message;
                    progress.labelFont = [UIFont boldSystemFontOfSize:17];
                    progress.mode = MBProgressHUDModeText;
                    progress.animationType = MBProgressHUDAnimationFade;
                    [weakSelf.view addSubview:progress];
                    
                    [progress showAnimated:YES whileExecutingBlock:^{
                        sleep(2.0);
                    } completionBlock:^{
                        [progress removeFromSuperview];
                        progress = nil;
                    }];
                }
            }else {
                // 检测网络
                if ([AppDelegate isEnableNetwork]) {
                    // 有网络
                    // 移到黑名单
                    EMBuddyModel * buddyModel = [_friendDataSource objectAtIndex:_longPressIndexPath.row];
                    // 从数据源删除
                    [_friendDataSource removeObject:buddyModel];
                    // 从数据库删除
                    [_manager deleteFriendWithFriendName:buddyModel.username];
                    
                    self.isOpenFriendList = YES; // 展开好友列表
                    
                    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_longPressIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    
                    [[EaseMob sharedInstance].chatManager blockBuddy:buddyModel.username relationship:eRelationshipBoth];
                    [self reloadGroupsData];
                }else {
                    // 无网络
                    NSString * message = @"移入黑名单失败，请检查网络";
                    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                    progress.labelText = message;
                    progress.labelFont = [UIFont boldSystemFontOfSize:17];
                    progress.mode = MBProgressHUDModeText;
                    progress.animationType = MBProgressHUDAnimationFade;
                    [weakSelf.view addSubview:progress];
                    
                    [progress showAnimated:YES whileExecutingBlock:^{
                        sleep(2.0);
                    } completionBlock:^{
                        [progress removeFromSuperview];
                        progress = nil;
                    }];
                }
            }
        }else if (_longPressIndexPath.section == 1) {
            // 解散群组/退出群组操作
            self.isOpenGroupList = YES; // 展开群组列表
            EMGroupModel * groupModel = _groupDataSource[_longPressIndexPath.row];
            if (self.groupOcceptType == GroupOcceptTypeOwner) {
                if ([AppDelegate isEnableNetwork]) {
                    // 有网络
                    // 解散群组
                    __weak FriendListScreenViewController * weakSelf = self;
                    [[EaseMob sharedInstance].chatManager asyncDestroyGroup:groupModel.groupId completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {
                        [weakSelf hideHud];
                        
                        if (error) {
                            [weakSelf showHudInView:weakSelf.view hint:@"解散群组失败"];
                        }else {
                            [_manager deleteGroupWithGroupId:groupModel.groupId];
                            [weakSelf showHudInView:weakSelf.view hint:@"解散成功"];
                            [weakSelf hideHud];
                        }
                    } onQueue:nil];
                }else {
                    // 无网络
                    NSString * message = @"解散群组失败，请检查网络";
                    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                    progress.labelText = message;
                    progress.labelFont = [UIFont boldSystemFontOfSize:17];
                    progress.mode = MBProgressHUDModeText;
                    progress.animationType = MBProgressHUDAnimationFade;
                    [weakSelf.view addSubview:progress];
                    
                    [progress showAnimated:YES whileExecutingBlock:^{
                        sleep(2.0);
                    } completionBlock:^{
                        [progress removeFromSuperview];
                        progress = nil;
                    }];
                }
            }else {
                if ([AppDelegate isEnableNetwork]) {
                    // 有网络
                    // 退出群组
                    __weak typeof(self) weakSelf = self;
                    [[EaseMob sharedInstance].chatManager asyncLeaveGroup:groupModel.groupId completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {
                        [weakSelf hideHud];
                        if (error) {
                            [weakSelf showHudInView:weakSelf.view hint:@"退出群组失败"];
                        }else {
                            [_manager deleteGroupWithGroupId:groupModel.groupId];
                            [weakSelf showHudInView:weakSelf.view hint:@"退出群组成功"];
                            [weakSelf hideHud];
                        }
                    } onQueue:nil];
                }else {
                    // 无网络
                    NSString * message = @"退出群组失败，请检查网络";
                    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                    progress.labelText = message;
                    progress.labelFont = [UIFont boldSystemFontOfSize:17];
                    progress.mode = MBProgressHUDModeText;
                    progress.animationType = MBProgressHUDAnimationFade;
                    [weakSelf.view addSubview:progress];
                    
                    [progress showAnimated:YES whileExecutingBlock:^{
                        sleep(2.0);
                    } completionBlock:^{
                        [progress removeFromSuperview];
                        progress = nil;
                    }];
                }
            }
            [self reloadMyGroupList];
        }else if (_longPressIndexPath.section == 2){
            if ([AppDelegate isEnableNetwork]) {
                // 有网络
                // 移除黑名单操作
                BlackModel * model = [_blackDataSource objectAtIndex:_longPressIndexPath.row];
                [_blackDataSource removeObject:model];
                [_manager deleteBlackWithBlackName:model.blackName]; // 从数据库中移除
                self.isOpenBlackList = YES; // 展开黑名单列表
                [[EaseMob sharedInstance].chatManager unblockBuddy:model.blackName];
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_longPressIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [self reloadMyBlackList];
            }else {
                // 无网络
                NSString * message = @"移除黑名单失败，请检查网络";
                __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                progress.labelText = message;
                progress.labelFont = [UIFont boldSystemFontOfSize:17];
                progress.mode = MBProgressHUDModeText;
                progress.animationType = MBProgressHUDAnimationFade;
                [weakSelf.view addSubview:progress];
                
                [progress showAnimated:YES whileExecutingBlock:^{
                    sleep(2.0);
                } completionBlock:^{
                    [progress removeFromSuperview];
                    progress = nil;
                }];
            }
        }
    }
}

/**
 *  返回每个section的头视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 创建头部控件
    XRHeaderView * header = [XRHeaderView headerViewWithTableView:tableView];
    header.delegate = self;
    // 传递模型
    header.group = _groupsArray[section];
    
    return header;
}

/**
 *  iOS8 之后 必须实现这个方法  才会调用上面的- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 方法
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

#pragma mark - XRHeaderViewDelegate

- (void)headerViewDidClickNameView:(XRHeaderView *)header
{
    if ([header.group.name isEqualToString:@"我的好友"]) {
        self.isOpenFriendList = !self.isOpenFriendList; // 是否展开好友列表 YES 展开  NO 关闭
    }
    
    if ([header.group.name isEqualToString:@"我的群组"]) {
        self.isOpenGroupList = !self.isOpenGroupList;
    }
    
    if ([header.group.name isEqualToString:@"黑名单"]) {
        self.isOpenBlackList = !self.isOpenBlackList;
    }
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end