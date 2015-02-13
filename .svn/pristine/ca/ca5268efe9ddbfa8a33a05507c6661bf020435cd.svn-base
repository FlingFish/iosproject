//
//  FriendListScreenViewController.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "ParentViewController.h"

/**
 *  群组类型
 */
typedef enum GroupOccept_Type {
    GroupOcceptTypeOwner = 0, // 创建者
    GroupOcceptTypeMemer      // 成员
} GroupOcceptType;

@interface FriendListScreenViewController : ParentViewController

@property (nonatomic, strong) UINavigationController * superNvc;

// 重新刷新好友列表
- (void)reloadMyFriendList;

// 重新刷新群组列表
- (void)reloadMyGroupList;

// 重新刷新黑名单
- (void)reloadMyBlackList;

// 刷新数据
- (void)reloadGroupsData;

@end
