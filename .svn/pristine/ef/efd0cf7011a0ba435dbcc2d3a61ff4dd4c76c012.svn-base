//
//  MyCATransition.m
//  风行电影
//
//  Created by qianfeng on 14-8-31.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "MyCATransition.h"

@implementation MyCATransition

+ (MyCATransition *)catransitionWithType:(NSString *)type subType:(NSString *)subType duration:(double)duration timingFunction:(NSString *)timingName {
    // 转场动画
    MyCATransition * animation = [MyCATransition animation];
    animation.type = type;
    animation.subtype = subType;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingName];
    
    
    return animation;
}

@end
