//
//  PersonalInfoCell.m
//  FunCourse
//
//  Created by 韩刚 on 15/1/20.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//
#define KBorder      10
#define YBorder      5
#define KHeadImage_W 40
#define KHeadImage_H 40
#define DataLabel_W 30

#import "PersonalInfoCell.h"

@implementation PersonalInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.headerImageView = [[UIImageView alloc] init];
        self.headerImageView.layer.masksToBounds = YES;
        self.headerImageView.layer.cornerRadius = 20;
        [self.contentView addSubview:self.headerImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];

        _dataLabel = [[UILabel alloc] init];
        _dataLabel.textColor = [UIColor blackColor];
        _dataLabel.font = [UIFont systemFontOfSize: 15.0];
        [self.contentView addSubview:_dataLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 头像
    CGFloat headImageX = KBorder;
    CGFloat headImageY = YBorder;
    
    _headerImageView.frame = CGRectMake(headImageX, headImageY, KHeadImage_W, KHeadImage_H);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame)+KBorder, headImageY, SCREEN_SIZE.width-2*KBorder-KHeadImage_W-2*YBorder-DataLabel_W, KHeadImage_H);
    
    _dataLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame)+YBorder, headImageY, DataLabel_W, KHeadImage_H);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
