//
//  settingCell.h
//  FunCourse
//
//  Created by 寒竹子 on 15/1/28.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//  设置cell

#import <UIKit/UIKit.h>

@interface settingCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * versionLabel;
@property (nonatomic, strong) UILabel * cacheSizeLabel;

+ (instancetype)initWithTableView:(UITableView *)tableView;

@end
