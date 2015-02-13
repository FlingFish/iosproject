//
//  AddFriendCell.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/30.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#define kBorder        10
#define kHeaderImage_W 50
#define kHeaderImage_H 50
#define kAddButton_W   40
#define kAddButton_H   25

#import "AddFriendCell.h"

@implementation AddFriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"cellId";
    
    AddFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[AddFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headerImage = [[UIImageView alloc] init];
        self.headerImage.layer.masksToBounds = YES;
        self.headerImage.layer.cornerRadius = 25;
        [self.contentView addSubview:self.headerImage];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameLabel.textColor = RGB(0, 0, 0, 1.0);
        [self.contentView addSubview:self.nameLabel];
        
        self.addButton = [[UIButton alloc] init];
        [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
        [self.addButton setTitleColor:RGBACOLOR(84, 225, 224, 1.0) forState:UIControlStateNormal];
        self.addButton.backgroundColor = RGB(246, 246, 246, 1.0);
        self.addButton.layer.masksToBounds = YES;
        self.addButton.layer.cornerRadius = 3.0;
        [self.addButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addButton];
    }
    
    return self;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置头像
    CGFloat headX = kBorder;
    CGFloat headY = kBorder;
    self.headerImage.frame = CGRectMake(headX, headY, kHeaderImage_W, kHeaderImage_H);
    
    CGFloat nickX = CGRectGetMaxX(self.headerImage.frame) + kBorder;
    CGFloat nickY = 0;
    CGSize nickSize = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    nickSize.height = self.bounds.size.height;
    self.nameLabel.frame = CGRectMake(nickX, nickY, nickSize.width, nickSize.height);
    
    CGFloat addX = SCREEN_SIZE.width - kAddButton_W - kBorder;
    CGFloat addY = (self.bounds.size.height - kAddButton_H) / 2.0;
    self.addButton.frame = CGRectMake(addX, addY, kAddButton_W, kAddButton_H);
}

/**
 *  cell的协议方法 添加好友
 */
- (void)buttonClick:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addButtonClickWithIndex:)] && self.indexPath) {
        [self.delegate performSelector:@selector(addButtonClickWithIndex:) withObject:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
    self.addButton.backgroundColor = RGB(246, 246, 246, 1.0);
}

@end
