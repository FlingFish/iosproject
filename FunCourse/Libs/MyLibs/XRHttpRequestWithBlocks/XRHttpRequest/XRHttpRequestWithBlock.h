//
//  XRHttpRequest.h
//  XRHttpRequestByBlock
//
//  Created by qianfeng on 14-10-1.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

/*
 * 使用Blocks封装Http下载
 * By xu ran
 */

#import <Foundation/Foundation.h>

@class XRHttpRequest;

// typedef 定义Blocks类型
typedef void (^downloadFinishedWithBlock) (NSMutableData * downloadData); // 成功Block类型定义
typedef void (^downloadFaildWithBlock) (NSError * error); // 失败Block类型定义

@interface XRHttpRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData * downloadData;
@property (nonatomic, assign) NSInteger requestTag;
@property (nonatomic, assign) BOOL islocalDownload;
@property (nonatomic, copy) NSString * requestUrl;

// GET
+ (XRHttpRequest *)GetWithUrl:(NSString *)url successful:(downloadFinishedWithBlock)successBlock faild:(downloadFaildWithBlock)faildBlock requestTag:(NSInteger)requestTag isRefresh:(BOOL)isRefresh;

// POST
+ (XRHttpRequest *)PostWithUrl:(NSString *)url successful:(downloadFinishedWithBlock)successBlock faild:(downloadFaildWithBlock)faildBlock;

// 停止下载请求
- (void)stopRequest;

@end
