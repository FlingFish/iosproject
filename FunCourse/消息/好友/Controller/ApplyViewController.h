//
//  ApplyViewController.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/31.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

// 接收到好友请求和群组邀请页面

#import "ParentViewController.h"

// 定义枚举 请求类型
typedef enum {
    ApplyStyleFriend = 0,      // 好友
    ApplyStyleGroupInvitation, // 群组邀请
    ApplyStyleJoinGroup        // 加入群组
}ApplyStyle;

@interface ApplyViewController : ParentViewController
{
    NSMutableArray * _dataSource;
}

@property (nonatomic, strong, readonly) NSMutableArray * dataSource;

// 单例
+ (instancetype)shareController;

// 添加新的请求
- (void)addNewApply:(NSDictionary *)dict;

// 从CoreData中获取数据
- (void)loadDataSourceFromLocalDB;

// 清除
- (void)clear;

@end
