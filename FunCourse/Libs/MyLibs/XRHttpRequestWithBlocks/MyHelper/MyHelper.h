//
//  MyHelper.h
//  XRHttpRequestByBlock
//
//  Created by qianfeng on 14-10-1.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Hashing.h" // 使用MD5加密
#import <UIKit/UIKit.h>

/*
 * 自定义的帮助文件 提供类方法
 */

@interface MyHelper : NSObject

// 获取设备的屏幕的大小
+ (CGSize)getScreenSize;

// 获取设备的版本
+ (BOOL)isiOS7Device;

// 获取缓存文件的路径 沙盒下的 /Library/Caches/MyCache/xxx
+ (NSString *)getFullCachePathWithUrl:(NSString *)url;

// 判断缓存的文件是否超过一定的时间
+ (BOOL)isTimeOutOfCacheFileWithUrl:(NSString *)url time:(double)time;

@end
