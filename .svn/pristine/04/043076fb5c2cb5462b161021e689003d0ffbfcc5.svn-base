//
//  LCourseOfflineCell.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/27.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "LCourseOfflineCell.h"

#define TypeFont 9.0
#define TypeTagFont TypeFont
#define LBFont 14.0
#define XBorder 5
#define YBorder 4
#define typeHeight 18
#define LBHeight 25
#define picH 14
#define picW 14

@implementation LCourseOfflineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        _headImge = [[MyImageView alloc] init];
        _headImge.layer.masksToBounds = YES;
        _headImge.layer.cornerRadius = 20;
        [self.contentView addSubview:_headImge];
        
        //类型
        _typeLB = [[UILabel alloc] init];
        _typeLB.font = [UIFont systemFontOfSize:TypeFont];
        _typeLB.text = @"分类";
        [self.contentView addSubview:_typeLB];
        
        //标签
        _typetagLB = [[UILabel alloc] init];
        _typetagLB.font = [UIFont systemFontOfSize:TypeTagFont];
        _typetagLB.text = @"标签";
        [self.contentView addSubview:_typetagLB];
        
        //课程描述
        _introLB = [[UILabel alloc] init];
        _introLB.font = [UIFont systemFontOfSize:LBFont];
        _introLB.text = @"这里是标题哈";
        [self.contentView addSubview:_introLB];
        
        //求学方式
        _howLB = [[UILabel alloc] init];
        _howLB.font = [UIFont systemFontOfSize:LBFont];
        _howLB.text = @"线下求学";
        [self.contentView addSubview:_howLB];
        
        //免费
        _isfreeImg = [[MyImageView alloc] init];
        _isfreeImg.image = [UIImage imageNamed:@"free_selected"];
        [self.contentView addSubview:_isfreeImg];
        
        //价格
        _priceLB = [[ UILabel alloc] init];
        _priceLB.font = [ UIFont systemFontOfSize:LBFont];
        [self.contentView addSubview:_priceLB];
        
        //查看数
        _readCountLb = [[ UILabel alloc] init ];
        _readCountLb.font = [UIFont systemFontOfSize:TypeFont];
        _readCountLb.text = @"121";
        [self.contentView addSubview:_readCountLb];
        
        //查看数标示图片
        _readImg = [[MyImageView alloc] init];
        _readImg.image = [UIImage imageNamed:@"eventShow"];
        [self.contentView addSubview:_readImg];
        
        //评论数
        _commentCountLB = [[UILabel alloc] init];
        _commentCountLB.font = [UIFont systemFontOfSize:TypeFont];
        _commentCountLB.text = @"101";
        [self.contentView addSubview:_commentCountLB];
        
        //评论标示图片
        _commentImg = [[MyImageView alloc ]init];
        _commentImg.image = [UIImage imageNamed:@"pinglun_"];
        [self.contentView addSubview:_commentImg];
        
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
    CGFloat headimgW = 40;
    CGFloat headimgH = 40;
    _headImge.frame = CGRectMake(2*XBorder, 2*YBorder,headimgW, headimgH);
    [_headImge sd_setImageWithURL:[NSURL URLWithString:@"http://ww4.sinaimg.cn/mw690/685dc00djw9dzqfb14c1xj.jpg"] placeholderImage:[UIImage imageNamed:@"personBg1"]];
    
    CGFloat typeX = CGRectGetMaxX(_headImge.frame)+2*XBorder;
    CGFloat typeW = 80;
    _typeLB.frame = CGRectMake(typeX, 2*YBorder, typeW, typeHeight);
    
    CGFloat typetagW = 120;
    _typetagLB.frame = CGRectMake(CGRectGetMaxX(_typeLB.frame)+XBorder, 2*YBorder, typetagW, typeHeight);
    
    CGFloat introLBW = 150;
    _introLB.frame = CGRectMake(typeX, CGRectGetMaxY(_typeLB.frame)+YBorder, introLBW, LBHeight);
    
    _howLB.frame = CGRectMake(typeX, CGRectGetMaxY(_introLB.frame)+YBorder, typeW, LBHeight);
    
    _isfreeImg.frame = CGRectMake(SCREEN_SIZE.width-45, CGRectGetMaxY(_typeLB.frame)+YBorder, 30, 30);
    _isfreeImg.hidden = NO;
    
    _priceLB.frame = CGRectMake(SCREEN_SIZE.width  -45, CGRectGetMaxY(_headImge.frame)+2*YBorder,40, LBHeight);
    _priceLB.hidden = YES;
    
    _readImg.frame = CGRectMake(2*XBorder,86, 14, 14);
    
    _readCountLb.frame = CGRectMake(CGRectGetMaxX(_readImg.frame)+2, 83, typeW, 20);
    
    _commentImg.frame = CGRectMake(SCREEN_SIZE.width-50, 86, 14, 14);
    
    _commentCountLB.frame = CGRectMake(CGRectGetMaxX(_commentImg.frame)+2, 83, 30, 20);
    
    _borderView.frame = CGRectMake(0,103, SCREEN_SIZE.width, 12);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _borderView.backgroundColor = RGB(214, 214, 214, 0.9);
}

@end
