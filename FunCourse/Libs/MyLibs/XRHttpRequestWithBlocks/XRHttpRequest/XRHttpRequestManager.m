//
//  XRHttpRequestManager.m
//  XRHttpRequestByBlock
//
//  Created by qianfeng on 14-10-1.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "XRHttpRequestManager.h"

@interface XRHttpRequestManager()
{
    NSMutableDictionary * _tasks; // 存放下载任务
}

@end

@implementation XRHttpRequestManager

// 非标准单例
+ (XRHttpRequestManager *)sharedHttpRequestManager {
    static XRHttpRequestManager * manager = nil;
    
    @synchronized(self) {
        if (manager == nil) {
            manager = [[XRHttpRequestManager alloc] init];
        }
    }
    
    return manager;
}

- (void)addTaskWithRequest:(XRHttpRequest *)request withUrl:(NSString *)url {
    // 网址不为空则添加下载任务
    if (url) {
        [_tasks setObject:request forKey:url];
    }
}

- (void)removeRequestTaskWithUrl:(NSString *)url {
    if (url) {
        [_tasks removeObjectForKey:url];
    }
}

- (XRHttpRequest *)isExsitRequestWithUrl:(NSString *)url {
    return [_tasks objectForKey:url];
}

- (void)stopAllTasks:(NSDictionary *)tasks{
    for (NSString * url in tasks) { // 字典中存放的都是url网址字符串
        XRHttpRequest * request = _tasks[url];
        
        // 停止request
        [request stopRequest];
        
        // 删除下载请求
        [_tasks removeObjectForKey:url];
    }
}

@end
