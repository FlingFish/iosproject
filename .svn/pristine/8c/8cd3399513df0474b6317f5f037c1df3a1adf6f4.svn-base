//
//  XRHttpRequestManager.h
//  XRHttpRequestByBlock
//
//  Created by qianfeng on 14-10-1.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRHttpRequestWithBlock.h"

@interface XRHttpRequestManager : NSObject

// 单例
+ (XRHttpRequestManager *)sharedHttpRequestManager;

// 添加下载任务
- (void)addTaskWithRequest:(XRHttpRequest *)request withUrl:(NSString *)url;

// 删除下载任务
- (void)removeRequestTaskWithUrl:(NSString *)url;

// 判断是否存在网址为url的下载任务
- (XRHttpRequest *)isExsitRequestWithUrl:(NSString *)url;

// 停止所有的下载任务
- (void)stopAllTasks:(NSDictionary *)tasks;

@end
