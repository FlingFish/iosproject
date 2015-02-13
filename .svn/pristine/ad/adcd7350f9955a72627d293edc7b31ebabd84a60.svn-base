//
//  MyHelper.m
//  XRHttpRequestByBlock
//
//  Created by qianfeng on 14-10-1.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "MyHelper.h"

@implementation MyHelper

#pragma mark - 获取屏幕的大小
+ (CGSize)getScreenSize {
    return [UIScreen mainScreen].bounds.size;
}

#pragma mark - 判断是否是iOS7以上的设备
+ (BOOL)isiOS7Device {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 获取缓存路径
+ (NSString *)getFullCachePathWithUrl:(NSString *)url {
    NSString * cacheFilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/MyCache"];
    
    NSFileManager * fm = [NSFileManager defaultManager]; // 获取文件管理单例
    if (![fm fileExistsAtPath:cacheFilePath]) {
        // 不存在则创建缓存文件目录
        [fm createDirectoryAtPath:cacheFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 使用MD5对网址进行唯一的加密 产生唯一的字符串
    url = [url MD5Hash];
    
    // 将加密产生的唯一的字符串追加到缓存目录后
    cacheFilePath = [cacheFilePath stringByAppendingFormat:@"/%@", url];
    
    return cacheFilePath;
}

#pragma mark - 判断缓存文件是否超时
+ (BOOL)isTimeOutOfCacheFileWithUrl:(NSString *)url time:(double)time {
    // 获取url对应的缓存文件的路径
    NSString * filePath = [MyHelper getFullCachePathWithUrl:url];
    
    // 获取文件的属性
    NSDictionary * fileAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    
    // 获取最近一次的修改时间
    NSDate * localTime = [fileAttr fileModificationDate];
    NSTimeInterval dis_time = [localTime timeIntervalSinceNow]; // 最近一次的修改时间距离现在的时间差值
    
    if (dis_time <= 0) {
        dis_time = -dis_time;
    }
    
    if (dis_time > time) {
        return YES; // 超时
    }else {
        return NO; // 不超时
    }
}

@end
