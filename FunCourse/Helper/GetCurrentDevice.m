//
//  GetCurrentDevice.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/30.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "GetCurrentDevice.h"

@implementation GetCurrentDevice
/**
 * iPhone4 iPhone4s iPhone5 ----> height 480
 * iPhone5s height ----> 568
 * iPhone6  height ----> 667
 * iPhone6 Plus height ----> 736 物理尺寸大小
 */
+ (NSString *)currentDeviceWithiPhone
{
    CGFloat height = SCREEN_SIZE.height;
    
    if (480 == height) {
        return iPhone5;
    }else if (568 == height) {
        return iPhone5s;
    }else if (667 == height) {
        return iPhone6;
    }else if (736 == height) {
        return iPhone6_Plus;
    }else {
        return @"未知设备";
    }
}

/**
 *  iPhone SystemVersion: iOS 6 iOS 7  iOS 8
 */
+ (NSString *)getCurrentSystemVersion
{
    float systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    
    NSString * systemVersionName = nil;
    
    if (systemVersion < 7.0) {
        systemVersionName = iOS6;
    }else if (systemVersion < 8.0) {
        systemVersionName  = iOS7;
    }else {
        systemVersionName = iOS8;
    }
    
    return systemVersionName;
}

@end
