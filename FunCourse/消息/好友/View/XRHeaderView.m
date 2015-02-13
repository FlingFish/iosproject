//
//  XRHeaderView.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/8.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "XRHeaderView.h"
#import "XRFriendGroup.h"

@implementation XRHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    // headerView重用
    static NSString * headerId = @"headerView";
    
    XRHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    
    if (header == nil) {
        header = [[XRHeaderView alloc] initWithReuseIdentifier:headerId];
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        _nameButton = [[UIButton alloc] init];
        [_nameButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [_nameButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置按钮内部控件的位置
        [_nameButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [_nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮内容左对齐
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的字体
        _nameButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        // 设置按钮的内边距
        _nameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _nameButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _nameButton.imageView.contentMode = UIViewContentModeCenter;
        _nameButton.imageView.clipsToBounds = NO;
        
        [_nameButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_nameButton];
        
        // 设置好友数
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_countLabel];
    }
    
    return self;
}

/**
 *  重写layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮
    _nameButton.frame = self.bounds;
    
    // label
    CGFloat countY = 0;
    CGFloat countH = self.bounds.size.height;
    CGFloat countW = 150;
    CGFloat countX = self.bounds.size.width - 10 - countW;
    
    _countLabel.frame = CGRectMake(countX, countY, countW, countH);
}

- (void)setGroup:(XRFriendGroup *)group
{
    _group = group;
    
    // 设置按钮文字（组名）
    [_nameButton setTitle:group.name forState:UIControlStateNormal];
    
    // 设置好友数
    _countLabel.text = [NSString stringWithFormat:@"（%li）", (long)_group.friendCount];
}

/**
 *  当子控件移到父控件上时调用
 */
- (void)didMoveToSuperview
{
    if (_group.isOpened) {
        self.nameButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else {
        self.nameButton.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

/**
 *  点击组
 */
- (void)buttonClick
{
    _group.isOpened = !_group.isOpened;
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickNameView:)]) {
        [self.delegate performSelector:@selector(headerViewDidClickNameView:) withObject:self];
    }
}

@end
