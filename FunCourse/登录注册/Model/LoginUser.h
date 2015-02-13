//
//  LoginUser.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/29.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//
// 单例用户模型

#import <Foundation/Foundation.h>

@interface LoginUser : NSObject

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * passWord;

// 单例
+ (instancetype)sharedUserInfo;

@end
