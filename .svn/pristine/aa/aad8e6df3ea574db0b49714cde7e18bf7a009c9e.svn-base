//
//  ApplyFriendCell.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/30.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//
// 好友请求cell

#define KBorder 10
#define KHEAD_W 50
#define KHEAD_H 50

#import "ApplyFriendCell.h"

@implementation ApplyFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = 25;
        [self.contentView addSubview:self.headImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = RGB(0, 0, 0, 1.0);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textColor = RGB(146, 146, 146, 1.0);
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.contentLabel];
        
        self.addButton = [[UIButton alloc] init];
        [self.addButton setTitle:@"同意" forState:UIControlStateNormal];
        [self.addButton setTitleColor:RGBACOLOR(84, 225, 224, 1.0) forState:UIControlStateNormal];
        self.addButton.backgroundColor = RGB(246, 246, 246, 1.0);
        [self.addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        self.addButton.layer.masksToBounds = YES;
        self.addButton.layer.cornerRadius = 3;
        [self.contentView addSubview:self.addButton];
        
        self.refuseButton = [[UIButton alloc] init];
        [self.refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.refuseButton setTitleColor:RGBACOLOR(84, 225, 224, 1.0) forState:UIControlStateNormal];
        self.refuseButton.backgroundColor = RGB(246, 246, 246, 1.0);
        [self.refuseButton addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];
        self.refuseButton.layer.masksToBounds = YES;
        self.refuseButton.layer.cornerRadius = 3;
        [self.contentView addSubview:self.refuseButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

/**
 *  重写layoutSubViews
 */
- (void)layoutSubviews
{
    // 调用父类layoutSubviews
    [super layoutSubviews];
    
    CGFloat headX = KBorder;
    CGFloat headY = KBorder;
    self.headImageView.frame = CGRectMake(headX, headY, KHEAD_W, KHEAD_H);
    
    CGFloat titleX = CGRectGetMaxX(self.headImageView.frame) + KBorder;
    CGFloat titleY = headY;
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]}];
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);

    CGFloat addX = SCREEN_SIZE.width - 50;
    CGFloat addY = 10;
    self.addButton.frame = CGRectMake(addX, addY, 40, 25);
    
    CGFloat refuseX = addX - 50;
    CGFloat refuseY = addY;
    self.refuseButton.frame = CGRectMake(refuseX, refuseY, 40, 25);
    
    CGFloat contentX = titleX;
    CGFloat contentY = CGRectGetMaxY(_titleLabel.frame) + KBorder;
    
    if (_contentLabel.text) {
        CGSize contentSize = [_contentLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        _contentLabel.frame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    }else {
        _contentLabel.frame = CGRectZero;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  接受请求
 */
- (void)add
{
    if (_delegate && [_delegate respondsToSelector:@selector(applyCellAddFriendAtIndexPath:)]) {
        [_delegate applyCellAddFriendAtIndexPath:self.indexPath];
    }
}

/**
 *  拒绝请求
 */
- (void)refuse
{
    if (_delegate && [_delegate respondsToSelector:@selector(applyCellRefuseFriendAtIndexPath:)]) {
        [_delegate applyCellRefuseFriendAtIndexPath:self.indexPath];
    }
}

@end
