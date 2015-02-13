//
//  ChatListViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/3.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatListCell.h"
#import "NSDate+Category.h"
#import "SRRefreshView.h"
#import "ConvertToCommonEmoticonsHelper.h" // 表情转换
#import "ChatViewController.h"

@interface ChatListViewController ()<SRRefreshDelegate, UITableViewDataSource, UITableViewDelegate, IChatManagerDelegate>

// 使用懒加载方式
@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) SRRefreshView * refreshView;
@property (nonatomic, strong) UIView * networkStateView;
@property (nonatomic, strong) UILabel * infoLabel; // 暂无消息

@end

@implementation ChatListViewController

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataSource) name:ReloadChatList_Notification object:nil];
        _dataSource = [[NSMutableArray alloc] init];
        [self setupUI];
    }
    
    return self;
}

/**
 *  单例
 */
+ (instancetype)sharedChatListController
{
    static ChatListViewController * chatVc = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        if (chatVc == nil) {
            chatVc = [[ChatListViewController alloc] init];
        }
    });
    
    return chatVc;
}

/**
 *  初始化
 */
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"会话";
    
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshView];
}

/**
 *  返回
 */
- (void)back
{
    // 发送改变未读会话个数的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMesssage" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter 方法

/**
 *  刷新view
 */
- (SRRefreshView *)refreshView
{
    if (_refreshView == nil) {
        _refreshView = [[SRRefreshView alloc] init];
        _refreshView.delegate = self;
        _refreshView.upInset = 0;
        _refreshView.slimeMissWhenGoingBack = YES;
        _refreshView.slime.bodyColor = [UIColor grayColor];
        _refreshView.slime.skinColor = [UIColor grayColor];
        _refreshView.slime.lineWith = 1;
        _refreshView.slime.shadowBlur = 4;
        _refreshView.slime.shadowColor = [UIColor grayColor];
        _refreshView.backgroundColor = [UIColor whiteColor];
    }
    
    return _refreshView;
}

/**
 *  显示网络状态
 */
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
        _networkStateView.backgroundColor = RGB(255, 199, 199, 0.5);
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"messageSendFail"]];
        [_networkStateView addSubview:imageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"当前网络连接失败，请检查您的网络";
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

/**
 *  UITableView
 */
- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        // 注册cell
        [_tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    }
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    
    return _tableView;
}

#pragma mark - 私有方法

/**
 *  获取会话列表
 */
- (NSMutableArray *)loadDataSource
{
    NSMutableArray * ret = nil;
    
    // 获取会话列表
    NSArray * conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    // 对对话列表进行排序
    NSArray * sorted = [conversations sortedArrayUsingComparator:
                        ^(EMConversation * obj1, EMConversation * obj2) {
                            EMMessage * message1 = [obj1 latestMessage];
                            EMMessage * message2 = [obj2 latestMessage];
                            if (message1.timestamp > message2.timestamp) {
                                return (NSComparisonResult)NSOrderedAscending;
                            }else {
                                return (NSComparisonResult)NSOrderedDescending;
                            }
                        }];
    ret = [[NSMutableArray alloc] initWithArray:sorted];
    
    return ret;
}
                        
/**
 *  得到最后消息时间
 */
- (NSString *)getLastMessageTimeWithConversation:(EMConversation *)conversation
{
    NSString * timeStr = nil;
    EMMessage * lastMessage = [conversation latestMessage];
    if (nil != lastMessage) {
        timeStr = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return timeStr;
}

/**
 *  得到未读消息条数
 */
- (NSInteger)getUnreadMessageCountWithConversation:(EMConversation *)conversation
{
    NSInteger count = 0;
    count = conversation.unreadMessagesCount;
    
    return count;
}

/**
 *  得到最后的消息文字或者消息类型
 */
- (NSString *)getSubTitleMessageWithConversation:(EMConversation *)conversation
{
    NSString * subStr = nil;
    EMMessage * lastMessage = [conversation latestMessage];
    
    if (nil != lastMessage) {
        // 得到最后一条消息
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:
            {
                subStr = @"[图片]"; // 图片消息
            }
                break;
            case eMessageBodyType_Text:
            {
                // 表情或者是文字消息
                NSString * receiveText = [ConvertToCommonEmoticonsHelper convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                subStr = receiveText;
            }
                break;
            case eMessageBodyType_Voice:
            {
                subStr = @"[声音]";
            }
                break;
            case eMessageBodyType_Location:
            {
                subStr = @"[位置]";
            }
                break;
            case eMessageBodyType_Video:
            {
                subStr = @"[视频]";
            }
                break;
            default:
                break;
        }
    }
    
    return subStr;
}

#pragma mark - 注册EaseMob的代理和移除代理

/**
 *  注册EaseMob代理
 */
- (void)registerEaseMobDelegate
{
    [self removeEaseMobDelegate];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

/**
 *  移除IchatManager代理
 */
- (void)removeEaseMobDelegate
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeEaseMobDelegate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 暂无消息提醒
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64)];
    _infoLabel.text = @"暂无会话哦，快去寻觅知音吧!";
    _infoLabel.textColor = [UIColor grayColor];
    _infoLabel.font = [UIFont systemFontOfSize:20];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.hidden = YES;
    [self.view addSubview:_infoLabel];
    
    [self registerEaseMobDelegate]; // 添加代理
    [self refreshDataSource]; // 刷新数据
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _infoLabel.hidden = YES;
    [self removeEaseMobDelegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UITableViewDelegate

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
    static NSString * cellId = @"chatListCell";
    
    ChatListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    EMConversation * conversation = self.dataSource[indexPath.row];
    
    cell.nameLabel.text = conversation.chatter;
    
    // 判断是否是群组会话
    if (conversation.isGroup == NO) {
        // 好友聊天
        [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/34fae6cd7b899e510e96ee1241a7d933c8950d9f.jpg"] placeholderImage:nil];
        
    }else {
        // 群聊
        NSString * imageName = @"groupPublicHeader"; // 公有群头像
        NSArray * groupList = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup * group in groupList) {
            if ([group.groupId isEqualToString:conversation.chatter]) {
                // 获取群组会话的群组name
                cell.nameLabel.text = group.groupSubject;
                imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                cell.headerImageView.image = [UIImage imageNamed:imageName];
                break;
            }
        }
    }
    // 详细信息
    cell.detailLabel.text = [self getSubTitleMessageWithConversation:conversation];
    // 时间
    cell.timeLabel.text = [self getLastMessageTimeWithConversation:conversation];
    
    // 未读消息数
    NSInteger count = [self getUnreadMessageCountWithConversation:conversation];
    cell.unreadCount = count;
    // 检测会话列表是否为空
    if (_dataSource.count == 0) {
        _infoLabel.hidden = NO;
    }else {
        _infoLabel.hidden = YES;
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
    
    // 跳转到聊天页面
    EMConversation * conversation = [self.dataSource objectAtIndex:indexPath.row];
    
    ChatViewController * chatVc;
    
    NSString * title = conversation.chatter;
    if (conversation.isGroup) {
        // 群聊
        NSArray * groupArray = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup * group in groupArray) {
            if ([group.groupId isEqualToString:conversation.chatter]) {
                title = group.groupSubject;
                break;
            }
        }
    }
    
    NSString * chatter = conversation.chatter;
    chatVc = [[ChatViewController alloc] initWithChatter:chatter isGroup:conversation.isGroup];
    chatVc.nickName = title;
    [self.navigationController pushViewController:chatVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

#pragma mark - UITableViewEdit

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/**
 *  删除会话列表
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除操作
        EMConversation * delConversation = [_dataSource objectAtIndex:indexPath.row];
        
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:delConversation.chatter deleteMessages:NO];
        [_dataSource removeObjectAtIndex:indexPath.row];
        
        // 检测会话列表是否为空
        if (_dataSource.count == 0) {
            _infoLabel.hidden = NO;
        }else {
            _infoLabel.hidden = YES;
        }
        
        // 动态刷新tableview
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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

#pragma mark - RefreshViewDelegate

/**
 *  刷新操作
 */
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    // 开始刷新
    [self refreshDataSource];
    [_refreshView endRefresh]; // 结束刷新
}

#pragma mark - IChatManagerDelagate

/**
 *  收到未读消息条数变化
 */
- (void)didUnreadMessagesCountChanged
{
    // 刷新数据源
    [self refreshDataSource];
    // 检测会话列表是否为空
    if (_dataSource.count == 0) {
        _infoLabel.hidden = NO;
    }else {
        _infoLabel.hidden = YES;
    }
}

/**
 *  更新群组变化
 */
- (void)didUpdateGroupList:(NSArray *)groupList error:(EMError *)error
{
    // 刷新数据源
    [self refreshDataSource];
    // 检测会话列表是否为空
    if (_dataSource.count == 0) {
        _infoLabel.hidden = NO;
    }else {
        _infoLabel.hidden = YES;
    }
}

#pragma mark - 公有方法

/**
 *  重新刷新数据
 */
- (void)refreshDataSource
{
    self.dataSource = [self loadDataSource];
    [_tableView reloadData];

    // 检测会话列表是否为空
    if (_dataSource.count == 0) {
        _infoLabel.hidden = NO;
    }else {
        _infoLabel.hidden = YES;
    }
    [self hideHud];
}

/**
 *  检测网络连接
 */
- (void)isConnect:(BOOL)isConnect
{
    if (NO == isConnect) {
        _tableView.tableHeaderView = _networkStateView;
    }else {
        _tableView.tableHeaderView = nil;
    }
}

/**
 *  网络变化
 */
- (void)networkStateChanged:(EMConnectionState)connectState
{
    // 无连接
    if (connectState == eEMConnectionDisconnected) {
        _tableView.tableHeaderView = self.networkStateView; // 调用getter方法
    }else {
        _tableView.tableHeaderView = nil;
    }
}

/**
 *  将要接收离线消息
 */
- (void)willReceiveOfflineMessages
{
    // do notings
}

/**
 *  接收到离线消息
 */
- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages
{
    // 刷新数据源
    [self refreshDataSource];
    // 检测会话列表是否为空
    if (_dataSource.count == 0) {
        _infoLabel.hidden = NO;
    }else {
        _infoLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
