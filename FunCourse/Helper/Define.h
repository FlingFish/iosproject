//
//  Define.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//  子曰宏定义

#ifndef FunCourse_Define_h
#define FunCourse_Define_h

// 定义线上线下枚举类型
typedef enum TOnlineState {
    Online = 0,
    Offline
} OnlineState;


//定义免费收费枚举类型
typedef enum TFreeState{
    Free = 0,
    NeedPay
}FreeState;

//定义付费枚举类型
typedef enum TPayState{
    GetFree = 0,
    WillPay
}PayState;




// 设备定义
#define iPhone5     @"iPhone5"
#define iPhone5s    @"iPhone5s"
#define iPhone6     @"iPhone6"
#define iPhone6_Plus @"iPhone6 Plus"

// 系统版本
#define iOS6 @"iOS 6"
#define iOS7 @"iOS 7"
#define iOS8 @"iOS 8"

// 宏定义和常量定义
// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

// SwitchColor
#define kGreenColor [UIColor colorWithRed:144/255.0 green: 202/255.0 blue: 119/255.0 alpha: 1.0]
#define kBlueColor [UIColor colorWithRed:129/255.0 green: 198/255.0 blue: 221/255.0 alpha: 1.0]
#define kYellowColor [UIColor colorWithRed:233/255.0 green: 182/255.0 blue: 77/255.0 alpha: 1.0]
#define kOrangeColor [UIColor colorWithRed:288/255.0 green: 135/255.0 blue: 67/255.0 alpha: 1.0]
#define kRedColor [UIColor colorWithRed:158/255.0 green: 59/255.0 blue: 51/255.0 alpha: 1.0]

// RGB
#define RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)];

// 字体
#define Title_Font [UIFont boldSystemFontOfSize:15]

// 数据接口

// 百度视频 数据接口
#define baiduVideo_Url @"http://app.video.baidu.com/adnativeindex/?mtj_cuid=9FAB312FF98096897E89A8D9D7F4895C|127341020584468&mtj_timestamp=1419605272716&mac_address=44:91:db:c9:6e:28&lf=eyJsb25naXR1ZGUiOiIxMTYuNDAwMTA0IiwibGF0aXR1ZGUiOiIzOS45OTU1OTYifQ%3D%3D%0A&channel=1316a&version=7.6.0"


// 环信

// 判断是否是iPhone5
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// RGB颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 登录的状态
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

// 聊天背景颜色
#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

// 是否自动登录
#define AUTOLOGIN_NOTIFICATION @"autoLogin"

// 设置未读请求消息数
#define SETUP_UNREADAPPLYCOUNT @"setupUnreadApplyCount"

// 刷新会话页面的宏
#define ReloadChatList_Notification @"conversationChanged"

// 刷新好友列表 群组列表 黑名单列表页面
#define ReloadFriendList_Notification @"reload friendList data"

#endif
