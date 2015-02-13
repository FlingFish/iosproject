//
//  FriendListCell.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/7.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "FriendListCell.h"

#define KBorder       10
#define HeaderImage_W 50
#define HeaderImage_H 50

@implementation FriendListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * Id = @"friendListCell";
    
    FriendListCell * cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[FriendListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化子控件
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 25;
        [self.contentView addSubview:_headImageView];
        
        _nickLabel = [[UILabel alloc] init];
        _nickLabel.font = [UIFont boldSystemFontOfSize:16];
        _nickLabel.textColor = RGB(0, 0, 0, 1.0);
        [self.contentView addSubview:_nickLabel];
        
        _showLabel = [[UILabel alloc] init];
        _showLabel.font = [UIFont systemFontOfSize:14];
        _showLabel.textColor = RGB(146, 146, 146, 1.0);
        [self.contentView addSubview:_showLabel];
        
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [self addGestureRecognizer:self.longPressGestureRecognizer];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置头像
    CGFloat headX = KBorder;
    CGFloat headY = KBorder;
    _headImageView.frame = CGRectMake(headX, headY, HeaderImage_W, HeaderImage_H);
    
    CGFloat nickX = CGRectGetMaxX(_headImageView.frame) + KBorder;
    CGFloat nickY = headY;
    CGSize nickSize = [_nickLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    CGFloat nickHeight = nickSize.height;
    if (self.type == GroupType) {
        nickY = 0;
        nickSize = [_nickLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
        nickHeight = self.bounds.size.height;
    }
    if (self.type == GroupType) {
        _nickLabel.font = [UIFont boldSystemFontOfSize:18];
    }else {
        _nickLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    _nickLabel.frame = CGRectMake(nickX, nickY, nickSize.width, nickHeight);
    
    CGFloat showX = nickX;
    CGFloat showY = CGRectGetMaxY(_nickLabel.frame) + KBorder;
    CGSize showSize = [_showLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    if (showSize.width >= self.frame.size.width - KBorder - HeaderImage_W - KBorder * 2) {
        showSize.width = self.frame.size.width - KBorder - HeaderImage_W - KBorder * 2;
    }
    _showLabel.frame = CGRectMake(showX, showY, showSize.width, showSize.height);
}

// 长按Action
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (_delegate && _indexPath && [_delegate respondsToSelector:@selector(cellLongPressForRowAtIndePath:)]) {
            [_delegate performSelector:@selector(cellLongPressForRowAtIndePath:) withObject:self.indexPath];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
