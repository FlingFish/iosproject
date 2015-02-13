//
//  NotifiMessageCell.m
//  FunCourse
//
//  Created by 寒竹子 on 15/2/10.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define kBorder 10
#define NOtifi_Title_Font [UIFont systemFontOfSize:18]

#import "NotifiMessageCell.h"

@implementation NotifiMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"notifiMessageCellId";
    
    NotifiMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NotifiMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化子控件
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = NOtifi_Title_Font;
        
        [self.contentView addSubview:_titleLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

/**
 *  未读申请和通知徽标
 */
- (UILabel *)unreadApplyCountLable
{
    if (_unreadApplyCountLable == nil) {
        CGSize size = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName : NOtifi_Title_Font}];
        
        _unreadApplyCountLable = [[UILabel alloc] initWithFrame:CGRectMake(size.width + 5, 5, 20, 20)];
        _unreadApplyCountLable.textAlignment = NSTextAlignmentCenter;
        _unreadApplyCountLable.backgroundColor = [UIColor redColor];
        _unreadApplyCountLable.font = [UIFont boldSystemFontOfSize:12];
        _unreadApplyCountLable.textColor = [UIColor whiteColor];
        _unreadApplyCountLable.layer.masksToBounds = YES;
        _unreadApplyCountLable.layer.cornerRadius = _unreadApplyCountLable.bounds.size.height / 2.0;
        _unreadApplyCountLable.hidden = YES;
        _unreadApplyCountLable.clipsToBounds = YES;
    }
    
    return _unreadApplyCountLable;
}

/**
 *  未读消息徽标
 */
- (UILabel *)unreadMessageCountLabel
{
    if (_unreadMessageCountLabel == nil) {
        CGSize size = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName : NOtifi_Title_Font}];
        
        _unreadMessageCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width + 5, 5, 20, 20)];
        _unreadMessageCountLabel.textAlignment = NSTextAlignmentCenter;
        _unreadMessageCountLabel.backgroundColor = [UIColor redColor];
        _unreadMessageCountLabel.font = [UIFont boldSystemFontOfSize:12];
        _unreadMessageCountLabel.textColor = [UIColor whiteColor];
        _unreadMessageCountLabel.layer.masksToBounds = YES;
        _unreadMessageCountLabel.layer.cornerRadius = _unreadMessageCountLabel.bounds.size.height / 2.0;
        _unreadMessageCountLabel.hidden = YES;
        _unreadMessageCountLabel.clipsToBounds = YES;
    }
    
    return _unreadMessageCountLabel;
}

/**
 *  未读待评价徽标
 */
- (UILabel *)needEvaluateCountLable
{
    if (_needEvaluateCountLabel == nil) {
        CGSize size = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName : NOtifi_Title_Font}];
        
        _needEvaluateCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width + 5, 5, 20, 20)];
        _needEvaluateCountLabel.textAlignment = NSTextAlignmentCenter;
        _needEvaluateCountLabel.backgroundColor = [UIColor redColor];
        _needEvaluateCountLabel.font = [UIFont boldSystemFontOfSize:12];
        _needEvaluateCountLabel.textColor = [UIColor whiteColor];
        _needEvaluateCountLabel.layer.masksToBounds = YES;
        _needEvaluateCountLabel.layer.cornerRadius = _needEvaluateCountLabel.bounds.size.height / 2.0;
        _needEvaluateCountLabel.hidden = YES;
        _needEvaluateCountLabel.clipsToBounds = YES;
    }
    
    return _needEvaluateCountLabel;
}

// layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 标题
    CGSize titleSize = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName : NOtifi_Title_Font}];
    _titleLabel.frame = CGRectMake(kBorder, kBorder / 2.0, titleSize.width, 44);
    
    // 待评价通知
    [self.contentView addSubview:self.needEvaluateCountLabel];
    
    
    // 未读申请通知
    [self.contentView addSubview:self.unreadApplyCountLable];
    
    if (self.unreadApplyCount == 0) {
        _unreadApplyCountLable.hidden = YES;
    }else {
        // 如果count>=100 则显示99+
        NSString * str = nil;
        if (self.unreadApplyCount >= 100) {
            str = [NSString stringWithFormat:@"%i+", 99]; // 显示99+
        }else {
            str = [NSString stringWithFormat:@"%li", (long)_unreadApplyCount];
        }
        
        CGSize size = [str boundingRectWithSize:CGSizeMake(50, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:self.unreadApplyCountLable.font} context:nil].size;
        CGRect rect = self.unreadApplyCountLable.frame;
        rect.size.width = size.width > 20 ? size.width : 20;
        _unreadApplyCountLable.text = str;
        _unreadApplyCountLable.frame = rect;
        _unreadApplyCountLable.hidden = NO;
    }
    
    // 未读会话消息
    [self.contentView addSubview:self.unreadMessageCountLabel];
    if (self.unreadMessageCount == 0) {
        _unreadMessageCountLabel.hidden = YES;
    }else {
        // 如果unreadMessageCount>=100 则显示99+
        NSString * str = nil;
        if (_unreadMessageCount >= 100) {
            str = [NSString stringWithFormat:@"%i+", 99]; // 显示99+
        }else {
            str = [NSString stringWithFormat:@"%li", (long)_unreadMessageCount];
        }
        
        CGSize size = [str boundingRectWithSize:CGSizeMake(50, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:self.unreadMessageCountLabel.font} context:nil].size;
        CGRect rect = self.unreadMessageCountLabel.frame;
        rect.size.width = size.width > 20 ? size.width : 20;
        _unreadMessageCountLabel.text = str;
        _unreadMessageCountLabel.frame = rect;
        _unreadMessageCountLabel.hidden = NO;
        
        // 会话消息数+申请数
        _unreadMessageCount += _unreadApplyCount;
        if ([[GetCurrentDevice getCurrentSystemVersion] isEqualToString:iOS8]) {
            // 在程序图标上显示未读消息数
            UIApplication * application = [UIApplication sharedApplication];
            UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            
            [application registerUserNotificationSettings:settings];
            
            [application setApplicationIconBadgeNumber:_unreadMessageCount];
        }else {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:_unreadMessageCount];
        }
    }
}

// cell被选中时调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // 设置一些控件的颜色属性
    _unreadApplyCountLable.backgroundColor = [UIColor redColor];
    _unreadMessageCountLabel.backgroundColor = [UIColor redColor];
}

// 设置cell高亮时的控件的状态
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    // 设置一些控件的颜色属性
    _unreadApplyCountLable.backgroundColor = [UIColor redColor];
    _unreadMessageCountLabel.backgroundColor = [UIColor redColor];
}

@end
