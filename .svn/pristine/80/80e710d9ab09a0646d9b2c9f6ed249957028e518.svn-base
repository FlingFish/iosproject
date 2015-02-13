//
//  AddFriendCell.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/30.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addFriendCellDetegate <NSObject>

- (void)addButtonClickWithIndex:(NSIndexPath *)indexPath;

@end

@interface AddFriendCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView * headerImage;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) NSIndexPath * indexPath;

@property (nonatomic, weak) id<addFriendCellDetegate> delegate;

@end
