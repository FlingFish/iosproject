//
//  ChatListViewController.h
//  FunCourse
//
//  Created by 寒竹子 on 15/1/3.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

// 会话列表页面

#import "ParentViewController.h"

@interface ChatListViewController : ParentViewController

@property (nonatomic, strong) UINavigationController * superNav;

// 单例
+ (instancetype)sharedChatListController;

// 刷新数据
- (void)refreshDataSource;

// 连接网络
- (void)isConnect:(BOOL)isConnect;

// 网络状态变化
- (void)networkStateChanged:(EMConnectionState)connectState;

@end
