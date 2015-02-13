//
//  RootNavigationViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "RootNavigationViewController.h"

@interface RootNavigationViewController ()

@end

@implementation RootNavigationViewController

/**
 *  初始化导航控制器
 */
- (void)setupNavi
{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_black"] forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [self.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        self.navigationBar.barStyle = UIBarMetricsDefault;
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_black"] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.layer.masksToBounds = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
