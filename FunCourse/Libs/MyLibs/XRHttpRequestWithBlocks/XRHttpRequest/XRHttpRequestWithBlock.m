//
//  XRHttpRequest.m
//  XRHttpRequestByBlock
//
//  Created by qianfeng on 14-10-1.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "XRHttpRequestWithBlock.h"
#import "XRHttpRequestManager.h"
#import "MyHelper.h"

@interface XRHttpRequest()

// block需要拷贝
@property (nonatomic, copy) downloadFinishedWithBlock downloadSuccessBlock;
@property (nonatomic, copy) downloadFaildWithBlock downloadFaildBlock;

@end

@implementation XRHttpRequest
{
    NSURLConnection * _httpConnection; // 请求链接
}

- (id)init {
    self = [super init];
    if (self) {
        self.downloadData = [[NSMutableData alloc] init];
    }
    
    return self;
}

#pragma mark - 创建GET
- (void)createGETHttpRequestWithUrl:(NSString *)url {
    if (_httpConnection) {
        // 有下载链接
        [_httpConnection cancel];
    }
    
    NSString * urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; // 对中文网址进行编码
    
    // 创建下载请求
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _httpConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // 开启状态栏的风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark - 创建POST
- (void)createPOSTHttpRequestWithUrl:(NSString *)url {
    if (_httpConnection) {
        [_httpConnection cancel];
    }
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray * params = [url componentsSeparatedByString:@"?"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:params[0]]];
    request.HTTPMethod = @"POST";
    NSData * data = [params[1] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    _httpConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

#pragma mark - GET
+ (XRHttpRequest *)GetWithUrl:(NSString *)url successful:(downloadFinishedWithBlock)successBlock faild:(downloadFaildWithBlock)faildBlock requestTag:(NSInteger)requestTag isRefresh:(BOOL)isRefresh {
    XRHttpRequest * oldRequest = [[XRHttpRequestManager sharedHttpRequestManager] isExsitRequestWithUrl:url];
    
    if (oldRequest) {
        return oldRequest;
    }
    
    // 创建新的下载请求
    XRHttpRequest * request = [[XRHttpRequest alloc] init];
    request.downloadSuccessBlock =successBlock;
    request.downloadFaildBlock = faildBlock;
    request.requestTag = requestTag;
    request.requestUrl = url;
    
    // 做缓存进行本地缓存
    NSString * caCheFilePath = [MyHelper getFullCachePathWithUrl:url];
    
    // 现在不是刷新 缓存文件已经存在 并且没有超时 则走本地
    if (!isRefresh && ([[NSFileManager defaultManager] fileExistsAtPath:caCheFilePath]) && ![MyHelper isTimeOutOfCacheFileWithUrl:url time:60 * 60]) {
        // 从本地取数据
        NSData * data = [NSData dataWithContentsOfFile:caCheFilePath];
        [request.downloadData setLength:0];
        [request.downloadData appendData:data];
        request.islocalDownload = YES;
        
        // 执行block
        if (request.downloadSuccessBlock) {
            request.downloadSuccessBlock(request.downloadData);
        }
    }else {
        // 走网络
        [request createGETHttpRequestWithUrl:request.requestUrl];
        // 将下载任务添加到字典中
        [[XRHttpRequestManager sharedHttpRequestManager] addTaskWithRequest:request withUrl:request.requestUrl];
    }
    return request;
}

#pragma mark - POST
+(XRHttpRequest *)PostWithUrl:(NSString *)url successful:(downloadFinishedWithBlock)successBlock faild:(downloadFaildWithBlock)faildBlock {
    XRHttpRequest * postRequest = [[XRHttpRequest alloc] init];
    
    postRequest.downloadSuccessBlock = successBlock;
    postRequest.downloadFaildBlock = faildBlock;
    postRequest.requestUrl = url;
    
    [postRequest createPOSTHttpRequestWithUrl:postRequest.requestUrl];
    
    [[XRHttpRequestManager sharedHttpRequestManager] addTaskWithRequest:postRequest withUrl:postRequest.requestUrl];
    
    return postRequest;
}

#pragma mark - 停止请求
- (void)stopRequest {
    if (_httpConnection) {
        [_httpConnection cancel];
        _httpConnection = nil;
    }
}

#pragma mark - 实现NSURLConnection协议中的方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // 接收到服务器的响应 要清空下载的数据
    [self.downloadData setLength:0];
}

#pragma mark - 接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.downloadData appendData:data];
}

#pragma mark - 下载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // 创建/获取缓存文件路径
    NSString * cachePath = [MyHelper getFullCachePathWithUrl:self.requestUrl];
    [self.downloadData writeToFile:cachePath atomically:YES];
    // 下载完成 删除下载任务
    [[XRHttpRequestManager sharedHttpRequestManager] removeRequestTaskWithUrl:self.requestUrl];
    
    // 执行block
    if (self.downloadSuccessBlock) {
        self.downloadSuccessBlock(self.downloadData);
    }
}

#pragma mark - 下载失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"下载失败:Error:%@", error);
    // 关闭风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // 删除下载任务
    [[XRHttpRequestManager sharedHttpRequestManager] removeRequestTaskWithUrl:self.requestUrl];
    
    // 执行下载失败的block
    if (self.downloadFaildBlock) {
        self.downloadFaildBlock(error);
    }
}

@end
