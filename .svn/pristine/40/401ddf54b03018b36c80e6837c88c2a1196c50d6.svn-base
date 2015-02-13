//
//  EvaluatedViewController.m
//  FunCourse
//
//  Created by 韩刚 on 15/1/21.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "EvaluatedViewController.h"

@interface EvaluatedViewController ()

@end

@implementation EvaluatedViewController


-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"评价过的课程";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
 
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
}

#pragma  mark - PopNavigationController
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - MemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
