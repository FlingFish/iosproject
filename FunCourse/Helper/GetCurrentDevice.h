//
//  GetCurrentDevice.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/30.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCurrentDevice : NSObject

/**
 * iPhone4 iPhone4s iPhone5 ----> height 480
 * iPhone5s height ----> 568
 * iPhone6  height ----> 667
 * iPhone6 Plus height ----> 736 物理尺寸大小
 */
+ (NSString *)currentDeviceWithiPhone;

/**
 *  获取systemVersion
 */
+ (NSString *)getCurrentSystemVersion;

@end
