//
//  XRFriendGroup.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/8.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//
// 好友分组模型

#import "XRFriendGroup.h"

@implementation XRFriendGroup

+ (instancetype)groupWithArray:(NSArray *)array groupName:(NSString *)groupname
{
    return [[self alloc] initWithArray:array groupName:groupname];
}

- (instancetype)initWithArray:(NSArray *)array groupName:(NSString *)groupname
{
    if (self = [super init]) {
        _friends = array;
        _name = groupname;
        _friendCount = [array count];
    }
    
    return self;
}

@end
