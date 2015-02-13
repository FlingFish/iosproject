//
//  RootTabBarController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "RootTabBarController.h"
#import "ParentViewController.h"
#import "RootNavigationViewController.h"
#import "ApplyViewController.h"
#import "MessageCenterScreenViewController.h"
#import "SettingViewController.h"
#import "ChatListViewController.h"
#import "FriendListScreenViewController.h"
#import "NotificationMessageViewController.h"

// 两次提醒的默认时间间隔
static const CGFloat KDefaultPlaySoundInterval = 2.0;

@interface RootTabBarController ()<IChatManagerDelegate, UIAlertViewDelegate>
{
    EMConnectionState _connectState; // 网络连接状态
    NSMutableArray * _controllers;
    NSMutableArray * _navArray; // 保存导航
}

@property (nonatomic, strong) NSDate * lastPlaySoundDate; // 最后一次提醒的时间

@end

@implementation RootTabBarController

- (instancetype)init
{
    if (self = [super init]) {
        // 添加通知 检测未读请求数的变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:SETUP_UNREADAPPLYCOUNT object:nil];
        _navArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

/**
 *  注册环信
 */
- (void)registerEaseMob
{
    [self registerNotifications];
}

/**
 *  将self注册为SDK的delegate
 */
- (void)registerNotifications
{
    [self removeNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

/**
 *  移除delegate
 */
- (void)removeNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

/**
 *  创建ViewControllers 初始化TabBar
 */
- (void)setupTabBarController
{
    // 设置tabBar背景
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar"];
    
    NSArray * viewControllerNames = @[@"MainScreenViewController", @"MessageCenterScreenViewController", @"PublicEventScreenViewController", @"PersonalScreenViewController"];
    NSArray * titles = @[@"首页", @"消息", @"公众", @"我"];
    NSArray * normalImageNames = @[@"tab_icon_friends", @"tab_icon_chat", @"tab_icon_discovery", @"tab_icon_event"];
    NSArray * selectedImageNames = @[@"tab_icon_friends_selected", @"tab_icon_chat_selected", @"tab_icon_discovery_selected", @"tab_icon_event_selected"];
    
    _controllers = [[NSMutableArray alloc] init];
    
    // 创建子视图控制器
    for (int i = 0; i < viewControllerNames.count; i++) {
        Class subClass = NSClassFromString(viewControllerNames[i]);
        ParentViewController * pvc = [[subClass alloc] init];
        pvc.tabBarItem.title = titles[i];
        pvc.tabBarItem.image = [[UIImage imageNamed:normalImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        pvc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        RootNavigationViewController * nvc = [[RootNavigationViewController alloc] initWithRootViewController:pvc];
        [_controllers addObject:nvc];
    }
    
    self.viewControllers = _controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerEaseMob]; // 设置环信代理
    [self setupTabBarController];
    // 此时没有设置为SDK的delegate 读取的是上一次的消息数
    [self didUnreadMessagesCountChanged];
    [self setupUnreadMessageCount];
}

/**
 *  网络状态发生变化
 */
- (void)networkChanged:(EMConnectionState)ConnetState
{
    _connectState = ConnetState;
    [[ChatListViewController sharedChatListController] networkStateChanged:_connectState];
}

- (void)setupUnreadApplyConut
{
    NSInteger unreadCnt = [[ApplyViewController shareController] dataSource].count;
    MessageCenterScreenViewController * meVc = _controllers[1];
    
    if (meVc) {
        if (unreadCnt > 0) {
            meVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)unreadCnt];
        }else {
            meVc.tabBarItem.badgeValue = nil;
        }
    }
}

/**
 *  设置未读消息数 <申请+未读消息+...>
 */
- (void)setupUnreadMessageCount
{
    // 获取当前会话
    NSArray * conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger count = 0;
    NSString * str = nil;
    
    for (EMConversation * conversation in conversations) {
        count += conversation.unreadMessagesCount;
    }
    count += [[[ApplyViewController shareController] dataSource] count];
    
    MessageCenterScreenViewController * meVc = _controllers[1];
    
    if (meVc) {
        if (count > 0) {
            // 如果count>=100 则显示99+
            if (count >= 100) {
                str = [NSString stringWithFormat:@"%i+", 99]; // 显示99+
            }else {
                str = [NSString stringWithFormat:@"%ld", (long)count];
            }
            meVc.tabBarItem.badgeValue = str;
            
            if ([[GetCurrentDevice getCurrentSystemVersion] isEqualToString:iOS8]) {
                // 在程序图标上显示未读消息数
                UIApplication * application = [UIApplication sharedApplication];
                UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
                
                [application registerUserNotificationSettings:settings];
                
                [application setApplicationIconBadgeNumber:count];
            }
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
        }else {
            meVc.tabBarItem.badgeValue = nil;
            
            if ([[GetCurrentDevice getCurrentSystemVersion] isEqualToString:iOS8]) {
                // iOS 8 设置方法
                UIApplication * application = [UIApplication sharedApplication];
                UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
                
                [application registerUserNotificationSettings:settings];
                
                [application setApplicationIconBadgeNumber:count];
            }
            
            // iOS 8以下设置方法
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
        }
    }
}

#pragma mark - UIAlertView的代理方法

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        // 点击了登出按钮
        if (buttonIndex != [alertView cancelButtonIndex]) {
            [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
                [[ApplyViewController shareController] clear];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            } onQueue:nil];
        }
    }else if (alertView.tag == 100) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }else if (alertView.tag == 101) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
}

#pragma mark - IChatManagerDelegate 登录回调 监听自动登录是否成功

/**
 *  检测自动登录是否成功的回调
 */
- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    // 登录失败的处理
    if (error) {
        NSString *hintText = @"你的账号登录失败，正在重试中... \n点击 '登出' 按钮跳转到登录页面 \n点击 '继续等待' 按钮等待重连成功";
        URBAlertView * alertView = [URBAlertView dialogWithTitle:@"提示" subtitle:hintText];
        alertView.tag = 99;
        [alertView addButtonWithTitle:@"继续等待"];
        [alertView addButtonWithTitle:@"登出"];
        [alertView showWithAnimation:URBAlertAnimationTumble];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        // 改变会话页面的网络状态
        [[ChatListViewController sharedChatListController] isConnect:NO];
    }
}

#pragma mark -IChatManagerDelegate 消息变化

/**
 *  消息变化 刷新会话页面
 */
- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
}

/**
 *  未读消息数变化回调
 */
- (void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
}

/**
 *  成功接收到离线消息
 */
- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self setupUnreadMessageCount];
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
}

/**
 *  接收到透传消息
 */
- (void)didFinishedReceiveOfflineCmdMessages:(NSArray *)offlineCmdMessages
{
    
}

/**
 *  是否需要进行推送 YES  进行推送  NO  不进行推送
 */
- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    // 获取已设置屏蔽消息的群列表
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    if (ret) {
        // 消息推送
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        
        do {
            if (options.noDisturbing) { // 开启了免打扰模式
                NSDate *now = [NSDate date];
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute
                                                                               fromDate:now];
                
                NSInteger hour = [components hour];
                
                
                NSUInteger startH = options.noDisturbingStartH; // 设置免打扰模式的开始时间
                NSUInteger endH = options.noDisturbingEndH;
                if (startH>endH) {
                    endH += 24; // + 1Day
                }
                
                // 免打扰模式下不进行消息推送
                if (hour>=startH && hour<=endH) {
                    ret = NO;
                    break;
                }
            }
        } while (0); // 只做一次判断
    }
    
    return ret;
}

/**
 *  收到消息回调
 */
- (void)didReceiveMessage:(EMMessage *)message
{
    // 设置推送显示的昵称
    [[EaseMob sharedInstance].chatManager setApnsNickname:message.from];
    BOOL needShowNotification = message.isGroup ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        // 获取应用程序的激活状态
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) { // 未激活状态  后台运行 播放声音和震动
            [self showNotificationWithMessage:message];
        }else { // 激活状态 前台运行中
            [self playSoundAndVibration];
        }
#endif
    }
}

/**
 *  收到透传消息
 */
- (void)didReceiveCmdMessage:(EMMessage *)cmdMessage
{
    [self showHint:@"有透传消息"];
}

/**
 *  播放声音和震动
 */
- (void)playSoundAndVibration
{
    // 取出提醒间隔时间
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    // 时间太短
    if (timeInterval < KDefaultPlaySoundInterval) {
        return;
    }
    
    // 保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息 播放声音
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息 震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

/**
 *  显示推送消息
 */
- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    // 设置推送类型
    options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
    
    // 发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject]; // 取出第一条信息
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = @"[图片]";
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = @"[位置]";
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = @"[音频]";
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = @"[视频]";
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = @"您有一条新消息";
    }
    
    notification.alertAction = @"打开";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark - chatManager代理方法 好友变化

/**
 *  好友变化 刷新好友列表
 */
- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadFriendList_Notification object:nil];
}

/**
 *  接受好友请求成功 回调
 */
- (void)didAcceptBuddySucceed:(NSString *)username
{
    // 刷新好友列表页面 （好友请求接受成功时触发）
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadFriendList_Notification object:nil];
}

/**
 *  已经接受好友请求 回调方法
 */
- (void)didAcceptedByBuddy:(NSString *)username
{
    // 刷新好友列表
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadFriendList_Notification object:nil];
}

/**
 *  好友发生变化方法
 */
- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message
{
    // 接收到好友请求时触发
    /**
     *  真机发送本地推送  声音和震动提醒  通知页面刷新请求数
     */
#if !TARGET_IPHONE_SIMULATOR
    [self playSoundAndVibration];
    
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        //发送本地推送
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = [NSString stringWithFormat:@"%@ %@", username, @"添加你为好友"];
        notification.alertAction = @"打开";
        notification.timeZone = [NSTimeZone defaultTimeZone];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
#endif
    
    // 发送刷新申请页面的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:SETUP_UNREADAPPLYCOUNT object:nil];
}

/**
 *  已经删除好友 刷新好友列表 和 会话列表
 */
- (void)didRemovedByBuddy:(NSString *)username
{
    [[[EaseMob sharedInstance] chatManager] removeConversationByChatter:username deleteMessages:YES];
    // 刷新会话
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
    // 刷新好友
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadFriendList_Notification object:nil];
}

/**
 *  已经接收到好友请求被其他人拒绝回调
 */
- (void)didRejectedByBuddy:(NSString *)username
{
    NSString * message = [NSString stringWithFormat:@"你被'%@'拒绝加为好友", username];
    URBAlertView * alertView = [URBAlertView dialogWithTitle:message subtitle:nil];
    [alertView addButtonWithTitle:@"确定"];
    [alertView showWithAnimation:URBAlertAnimationTumble];
    [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        [alertView hideWithAnimation:URBAlertAnimationTumble];
    }];
}

#pragma mark - 群组变化

/**
 *  收到群组邀请
 */
- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
                                error:(EMError *)error
{
#if !TARGET_IPHONE_SIMULATOR
    // 真机  声音和震动提醒
    [self playSoundAndVibration];
#endif
    
    // 刷新通知的请求数 和 群组列表数据
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
}

/**
 *  接收到入群申请
 */
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
    if (!error) {
#if !TARGET_IPHONE_SIMULATOR
        // 收到消息提醒
        [self playSoundAndVibration];
#endif
        // 刷新通知的请求数 和 群组列表数据
        [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
        
    }
}

/**
 *  被拒绝加入群组
 */
- (void)didReceiveGroupRejectFrom:(NSString *)groupId
                          invitee:(NSString *)username
                           reason:(NSString *)reason
                            error:(EMError *)error
{
    NSString * message = [NSString stringWithFormat:@"你被'%@'拒绝了", username];
    URBAlertView * alertView = [URBAlertView dialogWithTitle:message subtitle:nil];
    [alertView addButtonWithTitle:@"确定"];
    [alertView showWithAnimation:URBAlertAnimationTumble];
    [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        [alertView hideWithAnimation:URBAlertAnimationTumble];
    }];
}

/**
 *  收到入群申请
 */
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId groupname:(NSString *)groupname applyUsername:(NSString *)username reason:(NSString *)reason
{
    NSString * message = [NSString stringWithFormat:@"同意加入群组\'%@\'", groupname];
    [self showHint:message];
}

#pragma mark -IChatManagerDelagate 登录状态变化

/**
 *  账号在其他设备上登录
 */
- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"你的账号已在其他地方登录"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"确定", nil];
        alert.tag = 100;
        [alert show];
    } onQueue:nil];
}

/**
 *  账号被从服务端移除
 */
- (void)didRemovedFromServer
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"你的账号已被从服务器端移除"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"确定", nil];
        alert.tag = 101;
        [alert show];
    } onQueue:nil];
}

#pragma mark - 自动登录回调

/**
 *  将要自动重连
 */
- (void)willAutoReconnect
{
    [self hideHud];
    [self showHudInView:self.view hint:@"正在重连中..."];
}

/**
 *  自动重连成功
 */
- (void)didAutoReconnectFinishedWithError:(NSError *)error
{
    [self hideHud];
    if (!error) {
        [self showHudInView:self.view hint:@"重连成功!"];
    }else {
        [self showHudInView:self.view hint:@"重连失败!"];
    }
    [self hideHud];
}

#pragma mark - 提供给外部的方法

/**
 *  跳转到会话页面
 */
- (void)jumpToChatList
{
    [self.navigationController popToViewController:self animated:YES];
    RootNavigationViewController * nav = (RootNavigationViewController *)self.viewControllers[1];
    [self setSelectedViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
