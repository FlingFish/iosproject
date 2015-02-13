//
//  DataBaseManager.h
//  FunCourse
//
//  Created by 寒竹子 on 15/2/4.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//  数据库管理类

#import <Foundation/Foundation.h>

@class EMBuddyModel;
@class EMGroupModel;
@class BlackModel;

@interface DataBaseManager : NSObject

// 单例
+ (instancetype)defaultDataBaseManager;

// 判断数据库是否存在
- (BOOL)dbExisistAtPath;

#pragma mark - 好友数据操作

/**
 *  添加一条好友数据
 */
- (void)insertFriendWithEMBuddyModel:(EMBuddyModel *)buddyModel;

/**
 *  根据好友name删除一条好友数据
 */
- (BOOL)deleteFriendWithFriendName:(NSString *)friendName;

/**
 *  查询好友是否存在
 */
- (BOOL)existsFriendWithFriendName:(NSString *)friendName;

/**
 *  根据当前登录的用户来查询好友列表数据
 */
- (NSArray *)fetchFriendListWithLoginUserName:(NSString *)loginName;


#pragma mark - 群组数据操作

/**
 *  添加一条群组数据
 */
- (void)insertGroupWithEMGroupModel:(EMGroupModel *)groupModel;

/**
 *  根据群组groupSubject删除一条群组数据
 */
- (BOOL)deleteGroupWithGroupId:(NSString *)groupId;

/**
 *  查询群组是否存在
 */
- (BOOL)existsGroupWithGroupId:(NSString *)groupId;

/**
 *  根据当前登录的用户来查询群组列表数据
 */
- (NSArray *)fetchGroupListWithLoginUserName:(NSString *)loginName;

#pragma mark - 黑名单数据操作

/**
 *  添加一条黑名单数据
 */
- (void)insertBlackWithBlackModel:(BlackModel *)blackModel;

/**
 *  根据黑名单name删除一条好友数据
 */
- (BOOL)deleteBlackWithBlackName:(NSString *)blackName;

/**
 *  查询黑名单是否存在
 */
- (BOOL)existsBlackWithBlackName:(NSString *)blackName;

/**
 *  根据当前登录的用户来查询黑名单列表数据
 */
- (NSArray *)fetchBlackListWithLoginUserName:(NSString *)loginName;

@end
