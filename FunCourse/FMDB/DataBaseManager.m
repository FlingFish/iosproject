//
//  DataBaseManager.m
//  FunCourse
//
//  Created by 寒竹子 on 15/2/4.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "DataBaseManager.h"
#import "fmdb/FMDB.h"
#import "EMBuddyModel.h"
#import "EMGroupModel.h"
#import "LoginUser.h"
#import "BlackModel.h"

@interface DataBaseManager()

@property (nonatomic, strong) FMDatabaseQueue * queue;

@end

@implementation DataBaseManager

- (void)dealloc
{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db close];
    }];
    [self.queue close];
}

- (instancetype)init
{
    if (self = [super init]) {
        // 创建并打开数据库
        [self initizalManagerDB];
    }
    
    return self;
}

/**
 *  创建数据管理单例
 */
+ (instancetype)defaultDataBaseManager
{
    static dispatch_once_t once;
    
    static DataBaseManager * manager = nil;
    dispatch_once(&once, ^{
        if (manager == nil) {
            manager = [[DataBaseManager alloc] init];
        }
    });
    return manager;
}

/**
 *  判断数据库是否存在
 */
- (BOOL)dbExisistAtPath
{
    // 数据库文件路径
    NSString * filePathName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"datamanager.sqlite"];
    NSFileManager * fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePathName]) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - private

/**
 @param 表名
 @brief 判断某张表是否存在  YES 存在  NO 不存在
 */
- (BOOL)tableExistsWithTableName:(NSString *)tableName
{
    __block BOOL ret;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type = 'table' and name = ?", tableName];
        while ([rs next]) {
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count) {
                ret = NO;
            }else {
                ret = YES;
            }
        }
    }];
    
    return ret;
}

/**
 *  创建数据库 datamanager.sqlite
 */
- (void)initizalManagerDB
{
    NSString * filePathName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"datamanager.sqlite"];
    // 创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filePathName];
    
    if (![self tableExistsWithTableName:@"t_friendlist"]) {
        // 创建好友表
        [self setupFriendListTable];
    }
    if (![self tableExistsWithTableName:@"t_grouplist"]) {
        // 创建群组表
        [self setupGroupListTable];
    }
    if (![self tableExistsWithTableName:@"t_blacklist"]) {
        [self setupBlackListTable];
    }
}

#pragma mark - 好友列表数据操作

/**
 *  创建好友表 t_friendlist
 */
- (void)setupFriendListTable
{
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_friendlist (id integer primary key autoincrement, loginname text, friendname text, headdata blob, showstr text);"];
        if (result) {
            
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
    }];
}

/**
 *  添加一条好友数据
 */
- (void)insertFriendWithEMBuddyModel:(EMBuddyModel *)buddyModel
{
    if (buddyModel == nil) {
        return;
    }
    LoginUser * user = [LoginUser sharedUserInfo];
    NSString * loginName = user.userName;
    NSString * friendName = buddyModel.username;
    NSData * headerData = buddyModel.headerData;
    NSString * showStr = buddyModel.showStr;
    
    // 不存在则插入新数据
    if (![self existsFriendWithFriendName:friendName]) {
        [self.queue inDatabase:^(FMDatabase *db) {
            // 插入一条数据到t_friendlist表
            BOOL result = [db executeUpdate:@"insert into t_friendlist(loginname, friendname, headdata, showstr) values(?, ?, ?, ?)", loginName, friendName, headerData, showStr];
            if (result) {
                NSLog(@"插入成功");
            }else {
                NSLog(@"插入失败");
            }
        }];
    }
}

/**
 *  根据好友name删除一条好友数据
 */
- (BOOL)deleteFriendWithFriendName:(NSString *)friendName
{
    __block BOOL ret;
    
    // 查询是否有这个好友
    if ([self existsFriendWithFriendName:friendName]) {
        [self.queue inDatabase:^(FMDatabase *db) {
            ret = [db executeUpdate:@"delete from t_friendlist where friendname = ?", friendName];
        }];
    }
    
    return ret;
}

/**
 *  查询好友是否存在
 */
- (BOOL)existsFriendWithFriendName:(NSString *)friendName
{
    __block NSString * sql = @"select * from t_friendlist where friendname = ?;";
    __block BOOL ret;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        // 查询数据
        FMResultSet * rs = [db executeQuery:sql, friendName];
        
        if ([rs next]) {
            ret = YES;
        }else {
            ret = NO;
        }
        [rs close];
    }];
    
    return ret;
}

/**
 *  根据当前登录的用户来查询好友列表数据
 */
- (NSArray *)fetchFriendListWithLoginUserName:(NSString *)loginName
{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from t_friendlist where loginname = ?;", loginName];
        while ([rs next]) {
            EMBuddyModel * model = [[EMBuddyModel alloc] init];
            model.username = [rs stringForColumn:@"friendname"];
            model.headerData = [rs dataForColumn:@"headdata"];
            model.showStr = [rs stringForColumn:@"showstr"];
            [arr addObject:model];
        }
        [rs close];
    }];
    return [arr copy];
}

#pragma mark - 群组列表数据操作

/*!
 @property
 @brief    创建群组表
 */
- (void)setupGroupListTable
{
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_grouplist (id integer primary key autoincrement, loginname text, groupid text, groupsubject text, headdata blob);"];
        if (result) {
            
            NSLog(@"创建群组表成功");
        }else {
            NSLog(@"创建群组表失败");
        }
    }];
}

/**
 *  插入一条群组数据
 */
- (void)insertGroupWithEMGroupModel:(EMGroupModel *)groupModel
{
    if (groupModel == nil) {
        return;
    }
    NSString * loginName = [[LoginUser sharedUserInfo] userName];
    NSString * groupId = groupModel.groupId;
    NSString * groupSubject = groupModel.groupSubject;
    NSData * headData = groupModel.headData;
    
    if (![self existsGroupWithGroupId:groupId]) {
        [self.queue inDatabase:^(FMDatabase *db) {
            BOOL ret = [db executeUpdate:@"insert into t_grouplist(loginname, groupid, groupsubject, headdata) values(?, ?, ?, ?)", loginName, groupId, groupSubject, headData];
            if (ret) {
                NSLog(@"插入群组成功");
            }else {
                NSLog(@"插入群组失败");
            }
        }];
    }
}

/**
 *  根据群组groupId删除一条群组数据
 */
- (BOOL)deleteGroupWithGroupId:(NSString *)groupId
{
    __block BOOL ret;
    [self.queue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:@"delete from t_grouplist where groupid = ?", groupId];
    }];
    
    return ret;
}

/**
 *  查询群组是否存在
 */
- (BOOL)existsGroupWithGroupId:(NSString *)groupId
{
    __block BOOL ret;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from t_grouplist where groupid = ?", groupId];
        if ([rs next]) {
            ret = YES;
        }else {
            ret = NO;
        }
        [rs close]; // 关闭FMResultSet 避免崩溃
    }];
    
    return ret;
}

/**
 *  根据当前登录的用户来查询群组列表数据
 */
- (NSArray *)fetchGroupListWithLoginUserName:(NSString *)loginName
{
    NSMutableArray * groupArray = [[NSMutableArray alloc] init];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from t_grouplist where loginname = ?", loginName];
        // 遍历结果集
        while ([rs next]) {
            EMGroupModel * model = [[EMGroupModel alloc] init];
            model.groupId = [rs stringForColumn:@"groupid"];
            model.groupSubject = [rs stringForColumn:@"groupsubject"];
            model.headData = [rs dataForColumn:@"headdata"];
            [groupArray addObject:model];
        }
        [rs close];
    }];
    
    return [groupArray copy];
}

#pragma mark - 黑名单操作

/**
 *  创建黑名单表 t_blacklist
 */
- (void)setupBlackListTable
{
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_blacklist (id integer primary key autoincrement, loginname text, blackname text, headdata blob, showstr text);"];
        if (result) {
            
            NSLog(@"创建黑名单表成功");
        }else {
            NSLog(@"创建黑名单表失败");
        }
    }];
}

/**
 *  添加一条黑名单数据
 */
- (void)insertBlackWithBlackModel:(BlackModel *)blackModel
{
    if (blackModel == nil) {
        return;
    }
    LoginUser * user = [LoginUser sharedUserInfo];
    NSString * loginName = user.userName;
    NSString * blackName = blackModel.blackName;
    NSData * headerData = blackModel.headdata;
    NSString * showStr = blackModel.showStr;
    
    // 不存在则插入新数据
    if (![self existsBlackWithBlackName:blackName]) {
        [self.queue inDatabase:^(FMDatabase *db) {
            // 插入一条数据到t_blacklist表
            BOOL result = [db executeUpdate:@"insert into t_blacklist(loginname, blackname, headdata, showstr) values(?, ?, ?, ?)", loginName, blackName, headerData, showStr];
            if (result) {
                NSLog(@"插入成功");
            }else {
                NSLog(@"插入失败");
            }
        }];
    }
}

/**
 *  根据黑名单name删除一条好友数据
 */
- (BOOL)deleteBlackWithBlackName:(NSString *)blackName
{
    __block BOOL ret;
    
    // 查询是否有这个黑名单
    if ([self existsBlackWithBlackName:blackName]) {
        [self.queue inDatabase:^(FMDatabase *db) {
            ret = [db executeUpdate:@"delete from t_blacklist where blackname = ?", blackName];
        }];
    }
    
    return ret;
}

/**
 *  查询黑名单是否存在
 */
- (BOOL)existsBlackWithBlackName:(NSString *)blackName
{
    __block NSString * sql = @"select * from t_blacklist where blackname = ?;";
    __block BOOL ret;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        // 查询数据
        FMResultSet * rs = [db executeQuery:sql, blackName];
        
        if ([rs next]) {
            ret = YES;
        }else {
            ret = NO;
        }
        [rs close];
    }];
    
    return ret;
}

/**
 *  根据当前登录的用户来查询黑名单列表数据
 */
- (NSArray *)fetchBlackListWithLoginUserName:(NSString *)loginName
{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from t_blacklist where loginname = ?;", loginName];
        while ([rs next]) {
            BlackModel * model = [[BlackModel alloc] init];
            model.blackName = [rs stringForColumn:@"blackname"];
            model.headdata = [rs dataForColumn:@"headdata"];
            model.showStr = [rs stringForColumn:@"showstr"];
            [arr addObject:model];
        }
        [rs close];
    }];
    
    return [arr copy];
}

@end
