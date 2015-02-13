//
//  PersonalScreenCell.m
//  Zhizu
//
//  Created by 寒竹子 on 14/12/21.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#define kTitleFont [UIFont systemFontOfSize:18];
#define kBorder 10

#import "PersonalScreenCell.h"

@implementation PersonalScreenCell

+ (instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"personalCellId";
    PersonalScreenCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PersonalScreenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = kTitleFont;
        [self.contentView addSubview:_infoLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _infoLabel.frame = CGRectMake(kBorder, kBorder, 200, 40);
}

@end
