//
//  TCourseOnlineCell.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/27.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "TCourseOnlineCell.h"

#define kBorder 10
#define picH  14.0
#define picW  14.0

@implementation TCourseOnlineCell
{
    TCourseOnlineModel * _model; // model
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"TCourseOnlineCellId";
    TCourseOnlineCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TCourseOnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
        _typeLB.font = [UIFont systemFontOfSize:14.0];
        _typeLB.text = @"分类";
        [self.contentView addSubview:_typeLB];
        
        //标签
        _typetagLB = [[UILabel alloc] init];
        _typetagLB.font = [UIFont systemFontOfSize:14.0];
        _typetagLB.text = @"标签";
        [self.contentView addSubview:_typetagLB];
        
        //标题
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont systemFontOfSize:14.0];
        _titleLB.text = @"这里是课程描述";
        [self.contentView addSubview:_titleLB];
        
        //时间
        _timeLB = [[UILabel alloc] init];
        _timeLB.font = [UIFont systemFontOfSize:12.0];
        _timeLB.text = @"1-25 ~1-28";
        [self.contentView addSubview:_timeLB];
        
        //时间标示图片
        _timeImg = [[MyImageView alloc] init];
        _timeImg.image = [UIImage imageNamed:@"time"];
        [self.contentView addSubview:_timeImg];
        

        //人数
        _maxMumberLB = [[UILabel alloc] init];
        _maxMumberLB.font = [ UIFont systemFontOfSize:12.0];
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
        _priceLB.font = [ UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_priceLB];
        
        //查看数
        _readCountLb = [[ UILabel alloc] init ];
        _readCountLb.font = [UIFont systemFontOfSize:12.0];
        _readCountLb.text = @"121";
        [self.contentView addSubview:_readCountLb];
        
        //查看数标示图片
        _readImg = [[MyImageView alloc] init];
        _readImg.image = [UIImage imageNamed:@"eventShow"];
        [self.contentView addSubview:_readImg];
        
        //评论数
        _commentCountLB = [[UILabel alloc] init];
        _commentCountLB.font = [UIFont systemFontOfSize:12.0];
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
    
    // 头像
    CGFloat headimgW = 40;
    CGFloat headimgH = 40;
    _headImge.frame = CGRectMake(kBorder, kBorder,headimgW, headimgH);
    [_headImge sd_setImageWithURL:[NSURL URLWithString:@"http://ww4.sinaimg.cn/mw690/685dc00djw9dzqfb14c1xj.jpg"] placeholderImage:[UIImage imageNamed:@"personBg1"]];
    
    // 类型
    CGFloat typeX = CGRectGetMaxX(_headImge.frame)+kBorder;
    CGFloat typeY = kBorder;
    _typeLB.frame = CGRectMake(typeX, typeY, 80, 25);
    
    // 标签
    CGFloat typeTagX = CGRectGetMaxX(_typeLB.frame) + kBorder;
    CGFloat typeTagY = typeY;
    _typetagLB.frame = CGRectMake(typeTagX, typeTagY, 100, 25);
    
    // 标题
    CGFloat titleX = typeX;
    CGFloat titleY = CGRectGetMaxY(_typeLB.frame) + kBorder;
    _titleLB.frame = CGRectMake(titleX, titleY, 200, 25);
    
    // 时间
    CGFloat timeX = titleX;
    CGFloat timeY = CGRectGetMaxY(_titleLB.frame) + kBorder;
    _timeImg.frame = CGRectMake(timeX, timeY, picW, picH);
    
    // 时间label
    CGFloat timeLabelX = CGRectGetMaxX(_timeImg.frame) + kBorder / 2.0;
    CGFloat timeLabelY = timeY;
    _timeLB.frame = CGRectMake(timeLabelX, timeLabelY, 200, picH);
    
    // 人数image
    CGFloat mumImgX = timeX;
    CGFloat mumImgY = CGRectGetMaxY(_timeImg.frame) + kBorder;
    _mumImg.frame = CGRectMake(mumImgX, mumImgY, picW, picH);
    
    // 人数Label
    CGFloat maxLabelX = CGRectGetMaxX(_mumImg.frame) + kBorder;
    CGFloat maxLabelY = mumImgY;
    _maxMumberLB.frame = CGRectMake(maxLabelX, maxLabelY, 200, picH);
    
    // 免费Image
    CGFloat freeImageX = kBorder;
    CGFloat freeImageY = CGRectGetMaxY(_headImge.frame) + kBorder;
    _isfreeImg.frame = CGRectMake(freeImageX, freeImageY, 30, 30);
    CGPoint freeCenter = _headImge.center;
    freeCenter.y += headimgH / 2.0 + kBorder * 3;
    _isfreeImg.center = freeCenter;
    
    // 价格label
    CGFloat priceX = kBorder;
    CGFloat priceY = CGRectGetMaxY(_headImge.frame) + kBorder;
    _priceLB.frame = CGRectMake(priceX, priceY, 100, 25);
    CGPoint priceCenter = _headImge.center;
    priceCenter.y += headimgH / 2.0 + kBorder * 3;
    
    // 阅读数
    CGFloat readImageX = priceX;
    CGFloat readImageY = CGRectGetMaxY(_mumImg.frame) + kBorder;
    _readImg.frame = CGRectMake(readImageX, readImageY, 14, 14);
    
    // 阅读label
    CGFloat readLabelX = CGRectGetMaxX(_readImg.frame) + kBorder / 3.0;
    CGFloat readLabelY = readImageY;
    _readCountLb.frame = CGRectMake(readLabelX, readLabelY, 100, picH);
    
    // 评论Image
    CGFloat commentImageX = SCREEN_SIZE.width - 60;
    CGFloat commentImageY = readImageY;
    _commentImg.frame = CGRectMake(commentImageX, commentImageY, picW, picH);
    
    // 评论数label
    CGFloat commentLabelX = CGRectGetMaxX(_commentImg.frame) + kBorder / 2.0;
    CGFloat commentLabelY = commentImageY;
    _commentCountLB.frame = CGRectMake(commentLabelX, commentLabelY, 50, picH);
    
    // 间隔view
    CGFloat borderX = 0;
    CGFloat borderY = CGRectGetMaxY(_commentImg.frame) + kBorder;
    _borderView.frame = CGRectMake(borderX, borderY, SCREEN_SIZE.width, 15.0);
}

// 选中cell时调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    _borderView.backgroundColor = RGB(234, 234, 234, 1.0);
}

// 设置控件高亮时的状态
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    _borderView.backgroundColor = RGB(234, 234, 234, 1.0);
}

@end
