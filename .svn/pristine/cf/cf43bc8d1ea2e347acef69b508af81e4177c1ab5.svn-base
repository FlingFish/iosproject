//
//  FriendListCell.h
//  FunCourse
//
//  Created by 寒竹子 on 15/1/7.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义cell被长按的代理协议
@protocol FriendCellDelegate <NSObject>
- (void)cellLongPressForRowAtIndePath:(NSIndexPath *)indexPath;
@end

@interface FriendListCell : UITableViewCell

/**
 *  标记: 好友  群组  黑名单
 */
typedef enum Group_Type {
    FriendType = 0,
    GroupType,
    BlackType
}groupType;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * nickLabel;
@property (nonatomic, strong) UILabel * showLabel;
@property (nonatomic, strong) UILongPressGestureRecognizer * longPressGestureRecognizer;
@property (nonatomic, strong) NSIndexPath * indexPath; // cell的indexPath
@property (nonatomic, weak) id<FriendCellDelegate> delegate;
@property (nonatomic, assign) groupType type; // 类型

@end
