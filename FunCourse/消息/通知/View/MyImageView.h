//
//  MyImageView.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/27.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageView : UIImageView

@property (nonatomic, assign) NSInteger index;

// target - action 模式

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

// 添加单击事件
- (void)addTarget:(id)target action:(SEL)action;

@end
