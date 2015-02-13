//
//  settingCell.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/28.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define kBorder 10
#define kTitleFont [UIFont systemFontOfSize:18]

#import "settingCell.h"

@implementation settingCell

+ (instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"settingCellId";
    settingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[settingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kTitleFont;
        [self.contentView addSubview:_titleLabel];
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.font = kTitleFont;
        _versionLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_versionLabel];
        _cacheSizeLabel = [[UILabel alloc] init];
        _cacheSizeLabel.font = kTitleFont;
        _cacheSizeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_cacheSizeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleSize = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName : kTitleFont}];
    _titleLabel.frame = CGRectMake(kBorder, kBorder * 2, titleSize.width, titleSize.height);
    CGSize versionSize = [_versionLabel.text sizeWithAttributes:@{NSFontAttributeName : kTitleFont}];
    _versionLabel.frame = CGRectMake(self.frame.size.width - kBorder * 4 - versionSize.width, _titleLabel.frame.origin.y, versionSize.width, versionSize.height);
    CGSize cacheSize = [_cacheSizeLabel.text sizeWithAttributes:@{NSFontAttributeName:kTitleFont}];
    _cacheSizeLabel.frame = CGRectMake(self.frame.size.width - kBorder * 4 - cacheSize.width, _titleLabel.frame.origin.y, cacheSize.width, cacheSize.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
