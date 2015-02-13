//
//  NotifiMessageCell.h
//  FunCourse
//
//  Created by 寒竹子 on 15/2/10.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//  通知cell

#import <UIKit/UIKit.h>

@interface NotifiMessageCell : UITableViewCell

@property (nonatomic, assign) NSInteger unreadApplyCount;   // 未读申请数
@property (nonatomic, assign) NSInteger unreadMessageCount; // 未读消息数
@property (nonatomic, assign) NSInteger needEvaluateCount;  // 未评价课程数

@property (nonatomic, strong) UILabel * titleLabel; // 显示title
@property (nonatomic, strong) UILabel * unreadApplyCountLable;   // 未读申请徽标
@property (nonatomic, strong) UILabel * unreadMessageCountLabel; // 未读消息徽标
@property (nonatomic, strong) UILabel * needEvaluateCountLabel; // 未读待评价徽标

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
