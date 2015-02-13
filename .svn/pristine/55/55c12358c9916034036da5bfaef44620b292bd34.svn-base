//
//  EMGroupModel.h
//  FunCourse
//
//  Created by 寒竹子 on 15/2/4.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "EMGroup.h"

@interface EMGroupModel : EMGroup

/*!
 @property 
 @brief   群组头像url  add by xu ran
 */
@property (nonatomic, strong) NSString * headurl;

/*!
 @property
 @brief   群组头像Data add by xu ran
 */
@property (nonatomic, strong) NSData * headData;

/*!
 @property
 @brief   群组主题  modify readonly to readwrite  by xu ran
 */
@property (nonatomic, strong, readwrite) NSString * groupSubject;

/*!
 @property
 @brief 群组ID
 */
@property (nonatomic, strong, readwrite) NSString *groupId;

/*!
 @property
 @brief 群组的描述
 */
@property (nonatomic, strong, readwrite) NSString *groupDescription;

/*!
 @property
 @brief 群组的实际总人数
 */
@property (nonatomic, readonly) NSInteger groupOccupantsCount;

/*!
 @property
 @brief 群组的在线人数
 */
@property (nonatomic, readonly) NSInteger groupOnlineOccupantsCount;

/*!
 @property
 @brief 群组的创建者
 @discussion
 群组的所有者只有一人
 */
@property (nonatomic, strong, readwrite) NSString *owner;

/*!
 @property
 @brief 群组的管理员列表
 @discussion
 群组的管理员不止一人,可以通过动态更改群组成员的角色而成为群组的管理员
 */
@property (nonatomic, strong, readonly) NSArray  *admins EM_DEPRECATED_IOS(2_0_3, 2_0_9, "Delete");

/*!
 @property
 @brief 群组的普通成员列表
 */
@property (nonatomic, strong, readwrite) NSArray  *members;

/*!
 @property
 @brief 此群组中的所有成员列表(owner, members)
 */
@property (nonatomic, strong, readwrite) NSArray  *occupants;

/*!
 @property
 @brief 此群组黑名单中的成员列表
 @discussion 需要owner权限才能查看，非owner返回nil
 */
@property (nonatomic, strong, readwrite) NSArray  *bans;

/*!
 @property
 @brief 此群组的密码
 */
@property (nonatomic, strong, readonly) NSString *password;

/*!
 @property
 @brief 此群是否为公开群组
 */
@property (nonatomic, readonly) BOOL isPublic;

/*!
 @property
 @brief  群组属性配置
 */
@property (nonatomic, strong, readonly) EMGroupStyleSetting *groupSetting;

/*!
 @property
 @brief  此群组是否接收推送通知
 */
@property (nonatomic, readwrite) BOOL isPushNotificationEnabled;

/*!
 @property
 @brief  此群组是否被屏蔽
 */
@property (nonatomic, readwrite) BOOL isBlocked;

@end
