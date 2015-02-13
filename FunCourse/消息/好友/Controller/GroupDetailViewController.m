//
//  GroupDetailViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/28.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//  群组详情

#import "GroupDetailViewController.h"

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController

- (void)setupUI
{
    [self.view setBackgroundColor:[UIColor grayColor]];

    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleView.text = @"群资料";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont systemFontOfSize:18];
    
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    [backButton setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"nav_icon_back_click"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
}

/**
 *  返回
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
