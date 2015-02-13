//
//  NSString+Helper.h
//
//  Created by xuran on 14/12/2.
//  Copyright (c) 2014年 incorner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Helper)

/**
 *  清空字符串中的空白字符
 *  @return 清空空白字符之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否是空字符串
 *  @return 如果字符串为nil 或长度为0 返回Yes
 */
- (BOOL)isEmptyString;

/**
 *  返回沙盒中的文件路径
 *  @return 返回当前字符串对应在沙盒中得完整文件路径
 */
- (NSString *)documentsPath;

/**
 *  写入系统偏好
 *  @param key 写入键值
 */
- (void)saveToNSUserDefaultsWithKey:(NSString *)key;

/**
 *  返回字符串所占用的尺寸
 *  @param1 字体
 *  @param2 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


@end
