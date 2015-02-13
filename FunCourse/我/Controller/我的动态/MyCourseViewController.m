//
//  MyCourseViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//
#define BAR_H 40 // Bar的高度
#define BUTTON_H 39 // 按钮的高度

#import "MyCourseViewController.h"
#import "XRSegmentNavigationController.h"
#import "MyRecentCourseViewController.h"
#import "MyHistoryCourseViewController.h"



@interface MyCourseViewController ()
{
  XRSegmentNavigationController * _xsvc;
}

@end

@implementation MyCourseViewController

/**
 *  初始化SegmentNavigationController
 */
- (void)setupSegmentNavigationController
{
    NSArray * titles = @[@"最近", @"历史"];
    NSArray * items  = @[@"MyRecentCourseViewController", @"MyHistoryCourseViewController"];
    NSMutableArray * viewControllers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titles.count; i++) {
        Class subCls = NSClassFromString(items[i]);
        ParentViewController * pvc = [[subCls alloc] init];
        [viewControllers addObject:pvc];
    }
    
    // 创建segmentNav
    _xsvc = [[XRSegmentNavigationController alloc] initWithItems:viewControllers titles:titles];
    
    [_xsvc setColorWithBarColor:RGBACOLOR(240, 240, 240, 1.0) lineColor:RGBACOLOR(47, 187, 150, 1.0) lineViewColor:RGBACOLOR(240, 240, 240, 1.0) btnTitleColor:RGBACOLOR(47, 187, 150, 1.0)];
    
    [_xsvc setPosition:0];
    [_xsvc setTitleFont:[UIFont systemFontOfSize:20] barHeight:BAR_H buttonHeight:BUTTON_H];
    
    [self.view addSubview:_xsvc.view];
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSegmentNavigationController];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"我的动态";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
}



#pragma mark - pullBack NavigationController
// 返回首页
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
     [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
