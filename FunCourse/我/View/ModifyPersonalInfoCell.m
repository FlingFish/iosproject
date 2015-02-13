//
//  ModifyPersonalInfoCell.m
//  FunCourse
//
//  Created by 韩刚 on 15/1/19.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "ModifyPersonalInfoCell.h"

@implementation ModifyPersonalInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLB = [[ UILabel alloc ] init];
        _titleLB.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_titleLB];
        
        _dataLB = [[UILabel alloc] init];
        _dataLB.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_dataLB];
        
        _dataTF = [[UITextField alloc] init];
        _dataTF.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_dataTF];
        
        _imgview = [[ UIImageView alloc] init];
        [self.contentView addSubview:_imgview];

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
