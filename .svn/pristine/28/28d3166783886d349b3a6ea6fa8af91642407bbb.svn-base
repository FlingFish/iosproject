//
//  LoginUser.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/29.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "LoginUser.h"
#import "NSString+Helper.h"

#define kUSERNAME_KEY @"userName"
#define kPASSWORD_KEY @"password"

@implementation LoginUser

+ (instancetype)sharedUserInfo
{
    static LoginUser * user = nil;
    
    @synchronized (self) {
        if (nil == user) {
            user = [[LoginUser alloc] init];
        }
    }
    return user;
}

#pragma mark 私有方法
- (NSString *)loadStringFromDefaultsWithKey:(NSString *)key
{
    NSString * s = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    return (s) ? s : @"";
}

#pragma mark getter and setter 方法
- (NSString *)userName
{
    return [self loadStringFromDefaultsWithKey:kUSERNAME_KEY];
}

- (void)setUserName:(NSString *)userName
{
    [userName saveToNSUserDefaultsWithKey:kUSERNAME_KEY];
}

- (NSString *)passWord
{
    return [self loadStringFromDefaultsWithKey:kPASSWORD_KEY];
}

- (void)setPassWord:(NSString *)passWord
{
    [passWord saveToNSUserDefaultsWithKey:kPASSWORD_KEY];
}

@end
