//
//  XRFriendGroup.h
//  FunCourse
//
//  Created by 寒竹子 on 15/1/8.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRFriendGroup : NSObject

@property (nonatomic, copy) NSString * name;

/**
 *  数组中装的是friendList groupList BlackList
 */
@property (nonatomic, strong) NSArray * friends;
@property (nonatomic, assign) NSInteger friendCount; // 好友数

/**
 *  是否要展开这个组
 */
@property (nonatomic, assign, getter = isOpened) BOOL isOpened;

+ (instancetype)groupWithArray:(NSArray *)array groupName:(NSString *)groupname;

- (instancetype)initWithArray:(NSArray *)array groupName:(NSString *)groupname;

@end
