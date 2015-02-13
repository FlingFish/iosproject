//
//  TCourseOfflineCell.h
//  FunCourse
//
//  Created by 寒竹子 on 14/12/27.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCourseOfflineModel.h"
#import "MyImageView.h"

@interface TCourseOfflineCell : UITableViewCell

/**
 *  头像
 */
@property (nonatomic, strong) MyImageView * headImge;
/*
 *类型
 */
@property (nonatomic, strong) UILabel *typeLB;
/*
 *标签
 */
@property (nonatomic, strong)  UILabel *typetagLB;
/*
 *课程标题
 */
@property (nonatomic, strong)  UILabel *titleLB;
/*
 *时间
 */
@property (nonatomic, strong) MyImageView *timeImg;
/*
 *时间标示图片
 */

@property (nonatomic, strong) UILabel *timeLB;
/*
 *地址标示图片
 */
@property (nonatomic, strong) MyImageView *addImg;
/*
 *地址
 */
@property (nonatomic, strong) UILabel *addressLB;
/*
 *地址备注
 */
@property (nonatomic, strong) UILabel *remarkLB;
/*
 *人数
 */
@property (nonatomic, strong) UILabel *maxMumberLB;
/*
 *人数标示图片
 */
@property (nonatomic, strong) MyImageView *mumImg;
/*
 *查看数
 */
@property (nonatomic, strong) UILabel *readCountLb;
/*
 *查看标示图片
 */
@property (nonatomic, strong) MyImageView *readImg;
/*
 *评论数
 */
@property (nonatomic, strong) UILabel *commentCountLB;
/**
 *  评论标示图片
 */
@property (nonatomic, strong) MyImageView *commentImg;
/*
 *免费图片
 */
@property (nonatomic, strong) MyImageView *isfreeImg;
/*
 *免费价格
 */
@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) UIView *borderView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
