//
//  PublicEventCell.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/26.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "PublicEventCell.h"
#define TypeFont 9.0
#define TypeTagFont TypeFont
#define LBFont 14.0
#define XBorder 5
#define YBorder 4
#define typeHeight 18
#define LBHeight 25
#define picH 14
#define picW 14

@implementation PublicEventCell
{
    PublicEventModel * _model; // model
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //活动标题
        _titleLB = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLB];
        
        //活动海报
        _posterImg = [[UIImageView alloc] init];
        [self.contentView addSubview:_posterImg];
        
        //时间
        _timeLB = [[UILabel alloc] init];
        _timeLB.font = [UIFont systemFontOfSize:LBFont];
        _timeLB.text = @"1-25 ~1-28";
        [self.contentView addSubview:_timeLB];
        
        //时间标示图片
        _timeImg = [[MyImageView alloc] init];
        _timeImg.image = [UIImage imageNamed:@"time"];
        [self.contentView addSubview:_timeImg];
        
        
        //地址
        _addressLB = [[UILabel alloc] init];
        _addressLB.font = [UIFont systemFontOfSize:LBFont];
        _addressLB.text = @"宝山顾村";
        [self.contentView addSubview:_addressLB];
        
        //地址标示图片
        _addImg = [[MyImageView alloc] init];
        _addImg.image = [UIImage imageNamed:@"didian"];
        [self.contentView addSubview:_addImg];
        
        
        //备注
        _remarkLB = [[UILabel alloc] init];
        _remarkLB.font = [UIFont systemFontOfSize:LBFont];
        _remarkLB.text = @"顾村公园地铁站";
        [self.contentView addSubview:_remarkLB];
        
        //查看数
        _readCountLb = [[ UILabel alloc] init ];
        _readCountLb.font = [UIFont systemFontOfSize:TypeFont];
        _readCountLb.text = @"121";
        [self.contentView addSubview:_readCountLb];
        
        //查看数标示图片
        _readImg = [[MyImageView alloc] init];
        _readImg.image = [UIImage imageNamed:@"eventShow"];
        [self.contentView addSubview:_readImg];
        
        //分享图片
        _shareImg = [[MyImageView alloc] init];
        [self.contentView addSubview:_shareImg];

        //卡片间隔View
        _borderView = [[UIView alloc] init];
        _borderView.backgroundColor = RGB(214, 214, 214, 0.9);
        [self.contentView addSubview:_borderView];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleLBX=2*XBorder;
    _titleLB.frame = CGRectMake(titleLBX, YBorder, SCREEN_SIZE.width-2*titleLBX, LBHeight);
    _titleLB.font = [UIFont systemFontOfSize:LBFont];
    _titleLB.text = @"互联网创业论坛年度峰会";
    
    _posterImg.frame = CGRectMake(titleLBX, CGRectGetMaxY(_titleLB.frame)+YBorder, SCREEN_SIZE.width/2, 110);
    [_posterImg sd_setImageWithURL:[NSURL URLWithString:@"http://ww4.sinaimg.cn/mw690/685dc00djw9dzqfb14c1xj.jpg"] placeholderImage:[UIImage imageNamed:@"personBg1"]];
    
    _timeImg.frame = CGRectMake(CGRectGetMaxX(_posterImg.frame)+XBorder, CGRectGetMaxY(_titleLB.frame)+YBorder, picW, picH);
    _timeLB.frame = CGRectMake(CGRectGetMaxX(_timeImg.frame)+XBorder, CGRectGetMaxY(_titleLB.frame)+YBorder, SCREEN_SIZE.width/2-picW-XBorder, LBHeight);
    
    _addImg.frame = CGRectMake(CGRectGetMaxX(_posterImg.frame)+XBorder, CGRectGetMaxY(_timeLB.frame)+2*YBorder, picW, picH);
    
    _addressLB.frame = CGRectMake(CGRectGetMaxX(_addImg.frame)+XBorder, CGRectGetMaxY(_timeLB.frame)+YBorder, SCREEN_SIZE.width/2-picW-XBorder, LBHeight);

    _remarkLB.frame = CGRectMake(CGRectGetMaxX(_posterImg.frame)+XBorder, CGRectGetMaxY(_addressLB.frame)+YBorder, SCREEN_SIZE.width/2-picW-XBorder, LBHeight);
 
    _readImg.frame = CGRectMake(titleLBX,CGRectGetMaxY(_posterImg.frame)+18,picW, picH);
    
    _readCountLb.frame = CGRectMake(CGRectGetMaxX(_readImg.frame)+2, CGRectGetMaxY(_posterImg.frame)+15, 40, 20);
    
    _shareImg.frame = CGRectMake(SCREEN_SIZE.width-35, CGRectGetMaxY(_posterImg.frame)+15, picW+4, picH);
    _shareImg.image = [UIImage imageNamed:@"share"];
    
    _borderView.frame = CGRectMake(0,CGRectGetMaxY(_shareImg.frame)+2*YBorder, SCREEN_SIZE.width, 12);
}

@end
