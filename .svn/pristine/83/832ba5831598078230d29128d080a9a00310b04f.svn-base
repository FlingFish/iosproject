//
//  MyImageView.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/27.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES; // 打开用户交互
    }
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 执行action
    
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:self]; // 将self作为传递的参数
    }
}

- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

@end
