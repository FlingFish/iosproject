//
//  AppDelegate.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GexinSdk.h"

@class Reachability;

// 个推SDK运行状态
typedef enum {
    GexinSDKStatusStoped,
    GexinSDKStatusStarting,
    GexinSDKStatusStarted
}GexinSDKStatus;

@interface AppDelegate : UIResponder <UIApplicationDelegate, GexinSdkDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Reachability * reach;
@property (nonatomic, assign) NetworkStatus netState; //网络状态
// 个推
@property (nonatomic, strong) NSString * getuiAppKey;
@property (nonatomic, strong) NSString * getuiAppId;
@property (nonatomic, strong) NSString * getuiAppSecret;
@property (nonatomic, strong) NSString * clientId;
@property (nonatomic, strong) NSString * deviceToken;
@property (nonatomic, strong) GexinSdk * gexinPusher;
@property (nonatomic, assign) GexinSDKStatus sdkStatus;

@property (nonatomic, assign) int lastPlayloadIndex;
@property (nonatomic, strong) NSString * payloadId;

- (void)loginStateChanged:(NSNotification *)nf;


/********************************个推SDK*********************/

- (void)startgeXinSDKWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret;
- (void)stopSDK;

- (void)setDeviceToken:(NSString *)aToken;
- (BOOL)setTags:(NSArray *)aTag error:(NSError *)error;

// 绑定别名
- (void)bindAlias:(NSString *)aAlias;
- (void)unbindAlias:(NSString *)aAlias;

// 检测当前网络环境

// 是否是wifi
+ (BOOL)isEnableWifi;

// 是否是3G
+ (BOOL)isEnable3G;

// 是否是无网络
+ (BOOL)isEnableNetwork;

@end

