//
//  NSString+Valid.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/29.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)

- (BOOL)isChinese
{
    NSString * match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

@end
