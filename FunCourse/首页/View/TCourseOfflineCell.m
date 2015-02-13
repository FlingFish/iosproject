//
//  TCourseOfflineCell.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/27.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "TCourseOfflineCell.h"
#define TypeFont 9.0
#define TypeTagFont TypeFont
#define LBFont 14.0
#define XBorder 5
#define YBorder 4
#define typeHeight 18
#define LBHeight 25
#define picH 14
#define picW 14

@implementation TCourseOfflineCell
{
    TCourseOfflineModel * _model; // model
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"TCourseCellId";
    
    TCourseOfflineCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[TCourseOfflineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

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
        
        //标题
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont systemFontOfSize:LBFont];
        _titleLB.text = @"这里是课程描述";
        [self.contentView addSubview:_titleLB];
        
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
        
        //人数
        _maxMumberLB = [[UILabel alloc] init];
        _maxMumberLB.font = [ UIFont systemFontOfSize:LBFont];
        _maxMumberLB.text = @"2/5";
        [self.contentView addSubview:_maxMumberLB];
        
        //人数标示图片
        _mumImg = [[MyImageView alloc] init];
        _mumImg.image = [UIImage imageNamed:@"TabIconMine@3x"];
        [self.contentView addSubview:_mumImg];
        
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
        _borderView.backgroundColor = RGB(234, 234, 234, 1.0);
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
    
    CGFloat titleLBW = 205;
    _titleLB.frame = CGRectMake(typeX, CGRectGetMaxY(_typeLB.frame)+YBorder, titleLBW, LBHeight);
    
    _timeImg.frame = CGRectMake(typeX, CGRectGetMaxY(_titleLB.frame)+2*YBorder, picW, picH);
    
    _timeLB.frame = CGRectMake(typeX+picW+XBorder, CGRectGetMaxY(_titleLB.frame)+YBorder, titleLBW - XBorder - picW, LBHeight);
    
    _addImg.frame = CGRectMake(typeX, CGRectGetMaxY(_timeLB.frame)+2*YBorder, picW, picH);
    
    _addressLB.frame = CGRectMake(typeX+picW+XBorder, CGRectGetMaxY(_timeLB.frame)+YBorder, 100, LBHeight);
    
    _remarkLB.frame = CGRectMake(CGRectGetMaxX(_addressLB.frame)+XBorder, CGRectGetMaxY(_timeLB.frame)+YBorder, 120, LBHeight);
    ;
    _mumImg.frame = CGRectMake(typeX, CGRectGetMaxY(_addressLB.frame)+2*YBorder, picW, picH);
    
    _maxMumberLB.frame = CGRectMake(typeX+picW+XBorder, CGRectGetMaxY(_addressLB.frame)+YBorder, typeW, LBHeight);
    
    _isfreeImg.frame = CGRectMake(2*XBorder, CGRectGetMaxY(_headImge.frame)+30, 30, 30);
    
    _priceLB.frame = CGRectMake(2*XBorder, CGRectGetMaxY(_headImge.frame)+35,40, LBHeight);
    
    _readImg.frame = CGRectMake(2*XBorder, 152, 14, 14);
    
    _readCountLb.frame = CGRectMake(CGRectGetMaxX(_readImg.frame)+2, 150, 30, 20);
    
    _commentImg.frame = CGRectMake(SCREEN_SIZE.width-46, 152, picW, picH);
    
    _commentCountLB.frame = CGRectMake(CGRectGetMaxX(_commentImg.frame)+2, 150, 30, 20);
    
    _borderView.frame = CGRectMake(0,168, SCREEN_SIZE.width, 12);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    _borderView.backgroundColor = RGB(234, 234, 234, 1.0);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    _borderView.backgroundColor = RGB(234, 234, 234, 1.0);
}

@end
