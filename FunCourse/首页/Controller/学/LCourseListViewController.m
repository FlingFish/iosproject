//
//  LCourseListViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "LCourseListViewController.h"
#import "XRSegmentNavigationController.h"

@interface LCourseListViewController ()
{
    XRSegmentNavigationController * _segmentVc;
}

@end

@implementation LCourseListViewController

/**
 *  初始化SegmentNavigationController
 */
- (void)setupSegmentNavigationController
{
    NSArray * titles = @[@"线上", @"线下"];
    NSArray * items  = @[@"LCourseOnlineViewController", @"LCourseOfflineViewController"];
    NSMutableArray * viewControllers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titles.count; i++) {
        Class subCls = NSClassFromString(items[i]);
        ParentViewController * pvc = [[subCls alloc] init];
        [viewControllers addObject:pvc];
    }
    
    // 创建segmentNav
    _segmentVc = [[XRSegmentNavigationController alloc] initWithItems:viewControllers titles:titles];
    
    [_segmentVc setColorWithBarColor:RGBACOLOR(254, 254, 254, 1.0) lineColor:RGBACOLOR(47, 187, 150, 1.0) lineViewColor:RGBACOLOR(240, 240, 240, 1.0) btnTitleColor:RGBACOLOR(47, 187, 150, 1.0)];
    
    [_segmentVc setPosition:0];
    [_segmentVc setTitleFont:[UIFont systemFontOfSize:20] barHeight:40 buttonHeight:39];
    
#warning 若要push操作 必须传导航控制器
    
    [self.view addSubview:_segmentVc.view];
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSegmentNavigationController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
