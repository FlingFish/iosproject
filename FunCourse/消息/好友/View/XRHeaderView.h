//
//  XRHeaderView.h
//  FunCourse
//
//  Created by 寒竹子 on 15/1/8.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XRFriendGroup, XRHeaderView;

@protocol XRHeaderViewDelegate <NSObject>
@optional
- (void)headerViewDidClickNameView:(XRHeaderView *)header;

@end

@interface XRHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) XRFriendGroup * group;
@property (nonatomic, strong) UILabel * countLabel;
@property (nonatomic, strong) UIButton * nameButton;

@property (nonatomic, weak) id <XRHeaderViewDelegate>delegate;

@end
