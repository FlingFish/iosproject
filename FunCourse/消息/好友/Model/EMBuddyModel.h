//
//  EMBuddyModel.h
//  FunCourse
//
//  Created by 寒竹子 on 15/2/4.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "EMBuddy.h"

@interface EMBuddyModel : EMBuddy

/*!
 @property
 @brief 好友的username
 */
@property (copy, nonatomic, readwrite)NSString *username;

/*!
 @property
 @brief 好友头像的url地址 add by xu ran
 */
@property (nonatomic, strong) NSString * headerUrl;

/*!
 @property
 @brief 好友头像数据 Data类型 add by xu ran
 */
@property (nonatomic, strong) NSData * headerData;

/*!
 @property
 @brief   个性签名   add by xu ran
 */
@property (nonatomic, strong) NSString * showStr;

/*!
 @property
 @brief 好友状态
 */
@property (nonatomic) EMBuddyFollowState followState;

/*!
 @property
 @brief 是否等待对方接受好友请求()
 @discussion A向B发送好友请求,会自动将B添加到A的好友列表中,但isPendingApproval为NO,表示等待B接受A的好友请求,如果在好友列表中,不需要显示isPendingApproval为NO的用户,屏蔽它即可
 */
@property (nonatomic) BOOL isPendingApproval;

@end
