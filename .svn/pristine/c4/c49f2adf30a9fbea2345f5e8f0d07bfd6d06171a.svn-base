//
//  ChatListCell.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/4.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define KBorder      10
#define KHeadImage_W 50
#define KHeadImage_H 50

#import "ChatListCell.h"

@implementation ChatListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headerImageView = [[UIImageView alloc] init];
        self.headerImageView.layer.masksToBounds = YES;
        self.headerImageView.layer.cornerRadius = 25;
        [self.contentView addSubview:self.headerImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameLabel.textColor = RGB(0, 0, 0, 1.0);
        [self.contentView addSubview:self.nameLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.font = [UIFont systemFontOfSize:15];
        self.detailLabel.textColor = RGB(146, 146, 146, 1.0);
        [self.contentView addSubview:self.detailLabel];
        
        self.unreadCountLabel = [[UILabel alloc] init];
        self.unreadCountLabel.backgroundColor = [UIColor redColor];
        self.unreadCountLabel.textColor = [UIColor whiteColor];
        self.unreadCountLabel.textAlignment = NSTextAlignmentCenter;
        self.unreadCountLabel.clipsToBounds = YES;
        self.unreadCountLabel.layer.masksToBounds = YES;
        self.unreadCountLabel.font = [UIFont boldSystemFontOfSize:12];
        self.unreadCountLabel.layer.cornerRadius = 10;
        [self.contentView addSubview:self.unreadCountLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = RGB(181, 181, 181, 1.0);
        [self.contentView addSubview:self.timeLabel];
    }
    
    return self;
}

/**
 *  重写layoutSubviews方法 设置cell子控件的Frames
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 头像
    CGFloat headImageX = KBorder;
    CGFloat headImageY = KBorder;
    
    _headerImageView.frame = CGRectMake(headImageX, headImageY, KHeadImage_W, KHeadImage_H);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_headerImageView.frame) + KBorder;
    CGFloat nameY = headImageY;
    CGSize nameSize = [_nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    _nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    // 消息
    CGFloat detailX = nameX;
    CGFloat detailY = CGRectGetMaxY(_nameLabel.frame) + KBorder;
    CGSize detailSize = [_detailLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _detailLabel.frame = CGRectMake(detailX, detailY, detailSize.width, detailSize.height);
    
    // 最后消息时间
    CGSize timeSize = [_timeLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat timeX = SCREEN_SIZE.width - timeSize.width - KBorder;
    CGFloat timeY = nameY;
    _timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    CGFloat unreadX = SCREEN_SIZE.width - 20 - KBorder;
    CGFloat unreadY = CGRectGetMaxY(_timeLabel.frame) + KBorder;
    self.unreadCountLabel.frame = CGRectMake(unreadX, unreadY, 20, 20);
    NSString * unreadStr = nil;
    if (self.unreadCount > 0) {
        self.unreadCountLabel.hidden = NO;
        if (self.unreadCount > 99) {
            self.unreadCount = 99;
            unreadStr = [NSString stringWithFormat:@"%li+", (long)self.unreadCount];
        }else {
            unreadStr = [NSString stringWithFormat:@"%li", (long)self.unreadCount];
        }
        CGSize size = [unreadStr boundingRectWithSize:CGSizeMake(50, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont   boldSystemFontOfSize:12]} context:nil].size;
        CGRect rect = self.unreadCountLabel.frame;
        rect.size.width = size.width > 20 ? size.width : 20;
        self.unreadCountLabel.text = unreadStr;
        self.unreadCountLabel.frame = rect;
    }else {
        self.unreadCountLabel.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // 保持控件原有的状态
    if (![_unreadCountLabel isHidden]) {
        _unreadCountLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (![_unreadCountLabel isHidden]) {
        _unreadCountLabel.backgroundColor = [UIColor redColor];
    }
}

@end
