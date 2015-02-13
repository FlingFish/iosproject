//
//  AppDelegate.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

// 个推
#define GETUI_AppKey @"DmJQsFkC6g9kvVLGV21XI3"
#define GETUI_AppId  @"j60d9k5g7pAosQY48bpGJ"
#define GETUI_Secret @"hWuvlhSpJJ9FQfumkrz1Q8"

// 短信验证
#define SMS_AppKey    @"58f9ea636fc0"
#define SMS_AppSecret @"c6dc388697e5707c93a853e1082aeb89"
// 高德
#define AMapKey @"fb60aa4da759ac226db86d2f953798f8"
//友盟
#define UMKey @"54d493f4fd98c59e070003e6"
// 系统偏好
#define kIsFirst_Run @"isFirstRun"

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "RootNavigationViewController.h"
#import "EaseMob.h"
#import <MAMapKit/MAMapServices.h>
#import <CoreLocation/CoreLocation.h>

#import "RegisterViewController1.h"
#import "RegisterViewController3.h"
#import "RegisterViewController4.h"

#import "LoginViewController.h"
#import "LoginUser.h"
#import "NSString+Helper.h"
#import "ApplyViewController.h"
#import "StartPageViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "Reachability.h"
#import "GexinSdk.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"

static NetworkStatus * networkState;

@interface AppDelegate ()<IChatManagerDelegate,CLLocationManagerDelegate>
{
    EMConnectionState  _connectionState; // 链接状态
    RootTabBarController * _rootTabBar; // 主控制器
}

@property(nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) URBAlertView * alertView;

@end

@implementation AppDelegate

// 网络发生变化
- (void)reachabilityChanged:(NSNotification *)nf
{
    Reachability * reach = [nf object];
    
    _netState = [reach currentReachabilityStatus];
    networkState = &(_netState);
}

// 检测是否有网络连接
+ (BOOL)isEnableNetwork
{
    return ([self isEnableWifi] || [self isEnable3G]);
}

// 检测是否是wifi环境
+ (BOOL)isEnableWifi
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 检测是否是3G环境
+ (BOOL)isEnable3G
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

/********************************个推SDK*********************/

/**
 *  启动个推SDK
 */
- (void)startgeXinSDKWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    if (!_gexinPusher) {
        _sdkStatus = GexinSDKStatusStoped;
        
        self.getuiAppId = appId;
        self.getuiAppKey = appKey;
        self.getuiAppSecret = appSecret;
        
        _clientId = nil;
        NSError * err = nil;
        _gexinPusher = [GexinSdk createSdkWithAppId:_getuiAppId
                                             appKey:_getuiAppKey
                                          appSecret:_getuiAppSecret
                                         appVersion:@"0.0.0"
                                           delegate:self
                                              error:&err];
        if (!_gexinPusher) {
            
        }else {
            _sdkStatus = GexinSDKStatusStarting;
        }
    }
}

/**
 *  停止SDK
 */
- (void)stopSDK
{
    if (_gexinPusher) {
        [_gexinPusher destroy];
        _gexinPusher = nil;
        _sdkStatus = GexinSDKStatusStoped;
        _clientId = nil;
    }
}

/**
 *  检测个推SDK是否启动
 */
- (BOOL)checkSDKInstance
{
    if (!_gexinPusher) {
        return NO;
    }else {
        return YES;
    }
}

/**
 *  设置Token
 */
- (void)setDeviceToken:(NSString *)aToken
{
    if (![self checkSDKInstance]) {
        return;
    }
    [_gexinPusher registerDeviceToken:aToken];
}

/**
 *  设置标签
 */
- (BOOL)setTags:(NSArray *)aTag error:(NSError *)error
{
    if (![self checkSDKInstance]) {
        return NO;
    }
    return [_gexinPusher setTags:aTag];
}

// 绑定别名
- (void)bindAlias:(NSString *)aAlias
{
    if (![self checkSDKInstance]) {
        return;
    }
    return [_gexinPusher bindAlias:aAlias];
}

/**
 *  解绑别名
 */
- (void)unbindAlias:(NSString *)aAlias
{
    if (![self checkSDKInstance]) {
        return;
    }
    return [_gexinPusher unbindAlias:aAlias];
}

#pragma mark - GexinSDKDelegate

/**
 *  接收到个推消息
 */
- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId
{
    _payloadId = [payloadId copy];
    
    NSData * payload = [_gexinPusher retrivePayloadById:payloadId];
    NSString * payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"收到个推消息：%@", payloadMsg);
}

/**
 *  个推SDK注册成功
 */
- (void)GexinSdkDidRegisterClient:(NSString *)clientId
{
    _sdkStatus = GexinSDKStatusStarted;
    _clientId = [clientId copy];
    NSString * message = nil;
    if (self.sdkStatus == GexinSDKStatusStarted) {
        message = @"geXinSDK已启动";
    }else if (self.sdkStatus == GexinSDKStatusStarting) {
        message = @"gexinSDK正在启动";
    }else {
        message = @"gexinSDK停止运行";
    }
    
    NSLog(@"geXinSDK_Status: %@", message);
}

/**
 *  个推错误
 */
- (void)GexinSdkDidOccurError:(NSError *)error
{
    NSLog(@"geXin_Error: %@", error.description);
}

/**
 *  应用程序启动入口
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 检测网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [_reach startNotifier]; // 开始检测
    // 环信连接状态
    _connectionState = eEMConnectionConnected;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
#ifdef __IPHONE_8_0
    // 注册APNS推送
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
    // 高德LBS
    [MAMapServices sharedServices].apiKey = AMapKey;
    // 友盟
    [UMSocialData setAppKey:UMKey];
    // 新浪微博SSO授权
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    
    // 初始化LocationManager
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    _locationManager.distanceFilter = 1000.f;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
    // 注册观察者 监听登录状态的变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChanged:) name:KNOTIFICATION_LOGINCHANGE object:nil];
    
#pragma mark - 短信验证
    // Mob
    [SMS_SDK registerApp:SMS_AppKey withSecret:SMS_AppSecret];
    
#pragma mark - 个推推送
    [self startgeXinSDKWithAppId:GETUI_AppId appKey:GETUI_AppKey appSecret:GETUI_Secret];

    // 获取启动时收到的APN
    NSDictionary * message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString * payloadMsg = [message objectForKey:@"payload"];
        NSString * record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        
        NSLog(@"接收到APN: %@", record);
    }
    
#pragma mark - 环信推送
    // 推送证书
    NSString * apnsCertName = nil;
    
#if DEBUG
    apnsCertName = @"funcourse_dev"; // 调试时的推送证书
#else
    apnsCertName = @"funcourse_pro"; // 发布时的推送证书
#endif
    
    EMError * error = [[EaseMob sharedInstance] registerSDKWithAppKey:@"cornertech#funcourse" apnsCertName:apnsCertName];
    if (!error) {
        NSLog(@"注册环信SDK成功!");
    }
    
#if DEBUG
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
#endif
    
    // 注册为SDK的ChatManager的delegate 及时监听到申请和通知
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    // 自动登录 异步登录需要监听 didLoginWithInfo: error
    
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 使用CoreData
    NSString * sqliteName = @"FunCourse";
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:[NSString stringWithFormat:@"%@.sqlite", sqliteName]];
    
    // 取出偏好设置
    NSString * strValue = [[NSUserDefaults standardUserDefaults] objectForKey:kIsFirst_Run];
    
    // 开机引导
    if (strValue == nil) {
        // 写入数据到偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:@"not_isFirst" forKey:kIsFirst_Run];
        
        StartPageViewController * startVc = [[StartPageViewController alloc] init];
        self.window.rootViewController = startVc;
    }else {
        [self loginStateChanged:nil];
    }
    
    return YES;
}

#pragma  mark - CoreLoacationDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentPositon = [locations lastObject];
    //获取经度
    NSString *longgitudeStr = [[NSString alloc] init];
    longgitudeStr = [NSString stringWithFormat:@"%3.5f",currentPositon.coordinate.longitude];
    //获取纬度
    NSString *latitudeStr = [[NSString alloc] init];
    latitudeStr = [NSString stringWithFormat:@"%3.5f",currentPositon.coordinate.latitude];
    
    NSLog(@"%@ %@",longgitudeStr,latitudeStr);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@ 无法定位角落的位置！",error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {              [_locationManager requestWhenInUseAuthorization];
            }
        default:
            break;
    }
}

/**
 *  登录状态变化 切换视图控制器
 */
- (void)loginStateChanged:(NSNotification *)nf
{
    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    BOOL loginSuccess = [nf.object boolValue];
    
    if (isAutoLogin || loginSuccess) {
        // 自动登录开启 || 登录成功
        // 加载数据        loadDataFromLocalDB
        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        
        if (_rootTabBar == nil) {
            _rootTabBar = [[RootTabBarController alloc] init];
            
            [_rootTabBar networkChanged:_connectionState];
        }
        self.window.rootViewController = _rootTabBar;
    }else {
        _rootTabBar = nil;
        LoginViewController * loginVc = [[LoginViewController alloc] init];
        self.window.rootViewController = loginVc;
    }
}

/**
 *  注册推送成功 接收到DeviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 环信推送
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    // 个推推送
    NSString * token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"deviceToken:%@", _deviceToken);
    
    // 向个推服务器注册deviceToken
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:_deviceToken];
    }
}

/**
 *  注册推送失败
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    // 注册APNS失败 通知个推服务器
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:@""];
    }
    NSLog(@"error: %@", error.description);
    
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"注册推送失败"
                                                     message:error.description
                                                    delegate:nil
                                           cancelButtonTitle:nil
                                           otherButtonTitles:@"确定", nil];
    [alert show];
}

/**
 *  收到推送通知跳转到聊天页面
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // 个推
    NSString * payloadMsg = [userInfo objectForKey:@"payload"];
    NSString * record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    
    NSLog(@"payloadMsg: %@", record);
    // 环信
    if (_rootTabBar) {
        [_rootTabBar jumpToChatList];
    }
    
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

/**
 *  接收到个推的推送消息
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // 处理APN
    NSString * payloadMsg = [userInfo objectForKey:@"payload"];
    NSDictionary * aps = [userInfo objectForKey:@"aps"];
    NSNumber * contentAvailable = aps == nil? nil: [aps objectForKeyedSubscript:@"content-available"];
    NSString * record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
    
    NSLog(@"record:%@", record);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

/**
 *  接到本地系统通知
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_rootTabBar) {
        [_rootTabBar jumpToChatList];
    }
    
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
}

// 友盟 回调方法

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

// AppDelegate方法
/**
 *  即将激活应用程序
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

/**
 *  应用程序已经进入后台
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 切后台关闭SDK，让个推优先使用APNS
    [self stopSDK];
    
    // 发送进入后台的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidEnterBackground" object:nil];
    
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

/**
 *  应用程序即将进入前台
 */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 重新启动个推SDK
    [self startgeXinSDKWithAppId:_getuiAppId appKey:_getuiAppKey appSecret:_getuiAppSecret];
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
    // 发送通知 刷新通知页面和会话页面等
    if (_rootTabBar) {
        [_rootTabBar setupUnreadMessageCount];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
}

/**
 *  应用程序已经激活
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

/**
 *  applicationWillTerminate
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

#pragma mark - IChatManagerDelegate 好友变化

/**
 *  收到好友请求 添加好友 / 拒绝好友
 */
- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message
{
    if (username == nil) {
        return;
    }
    if (message == nil) {
        message = [NSString stringWithFormat:@"%@ 想添加你为好友", username];
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"title" : username, @"username" : username, @"applyMessage" : message, @"applyStyle" : [NSNumber numberWithInteger:ApplyStyleFriend], @"headImage" : @"http://g.hiphotos.baidu.com/image/pic/item/f603918fa0ec08fa6f52c9a15aee3d6d55fbda62.jpg"}]; // 添加了头像网址
    
    [[ApplyViewController shareController] addNewApply:dict]; // 添加好友请求
    // 设置未读数
    if (_rootTabBar) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReloadChatList_Notification object:nil];
        [_rootTabBar setupUnreadMessageCount];
    }
}

#pragma mark - IChatManagerDelegate 群组变化

/**
 *  收到群组邀请
 */
- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
                                error:(EMError *)error
{
    if (!groupId || !username) {
        return;
    }
    
    NSString * groupName = groupId;
    if (!message || message.length == 0) {
        message = [NSString stringWithFormat:@"%@ 邀请你加入群组\'%@\'", username, groupName];
        
    }
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:@{@"title" : groupName, @"groupId" : groupId, @"username" : username, @"applyMessage" : message, @"applyStyle" : [NSNumber numberWithInteger:ApplyStyleGroupInvitation]}];
    // 添加请求
    [[ApplyViewController shareController] addNewApply:dict];
    // 设置未读数
    if (_rootTabBar) {
        [_rootTabBar setupUnreadMessageCount];
    }
}

/**
 *  接受到入群申请
 */
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId groupname:(NSString *)groupname applyUsername:(NSString *)username reason:(NSString *)reason error:(EMError *)error
{
    __weak typeof(self) weakSelf = self;
    if (groupId == nil || username == nil) {
        return;
    }
    
    if (reason == nil || reason.length == 0) {
        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\'", username, groupname];
    }else {
        // 有附加信息
        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\':%@", username, groupname, reason];
    }
    
    if (error) {
        // 发送失败
        NSString * message = [NSString stringWithFormat:@"发送申请失败:%@\n原因:%@", reason, error.description];
        _alertView = [URBAlertView dialogWithTitle:@"错误" subtitle:message];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
    }else {
        // 成功
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:@{@"title" : groupname, @"groupId" : groupId, @"username" : username, @"groupname" : groupname, @"applyMessage" : reason, @"applyStyle" : [NSNumber numberWithInteger:ApplyStyleJoinGroup]}];
        // 添加请求
        [[ApplyViewController shareController] addNewApply:dict];
        
        if (_rootTabBar) {
            [_rootTabBar setupUnreadMessageCount];
        }
    }
}

/**
 *  接收到入群拒绝
 */
- (void)didReceiveRejectApplyToJoinGroupFrom:(NSString *)fromId
                                   groupname:(NSString *)groupname
                                      reason:(NSString *)reason
                                       error:(EMError *)error
{
    __weak typeof(self) weakSelf = self;
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", groupname];
    }
    
    _alertView = [URBAlertView dialogWithTitle:@"申请提示" subtitle:reason];
    [_alertView addButtonWithTitle:@"确定"];
    [_alertView showWithAnimation:URBAlertAnimationTumble];
    [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
    }];
}

/**
 *  从组中踢出成员
 */
- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
{
    __weak typeof(self) weakSelf = self;
    NSString * tmpStr = group.groupSubject;
    NSString * str;
    if (!tmpStr || tmpStr.length == 0) {
        NSArray * groups = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup * obj in groups) {
            if ([obj.groupId isEqualToString:group.groupId]) {
                tmpStr = obj.groupSubject;
                break;
            }
        }
    }
    
    if (reason == eGroupLeaveReason_BeRemoved) {
        str = [NSString stringWithFormat:@"你被从群组\'%@\'中踢出", tmpStr];
    }
    
    if ([str length] > 0) {
        _alertView = [URBAlertView dialogWithTitle:@"消息提示" subtitle:str];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
    }
}

#pragma mark - IChatManagerDelegate

/**
 *  网络连接变化
 */
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    [_rootTabBar networkChanged:_connectionState];
}

#pragma mark EMChatManagerPushNotificationDelegate

- (void)didBindDeviceWithError:(EMError *)error
{
    __weak typeof(self) weakSelf = self;
    if (error) {
        _alertView = [URBAlertView dialogWithTitle:@"设备绑定失败" subtitle:nil];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
    }
}

@end
