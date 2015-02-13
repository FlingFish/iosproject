//
//  ApplyFriendCell.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/30.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ApplyFriendCellDelegate <NSObject>

// 添加好友
- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath;
// 拒绝好友请求
- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ApplyFriendCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) UIButton * refuseButton;

@property (nonatomic, strong) NSIndexPath * indexPath;

// 代理
@property (nonatomic, weak) id <ApplyFriendCellDelegate>delegate;

@end
