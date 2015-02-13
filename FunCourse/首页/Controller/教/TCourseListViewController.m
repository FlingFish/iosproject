//
//  TCourseListViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#define BAR_H 40 // Bar的高度
#define BUTTON_H 39 // 按钮的高度

#import "TCourseListViewController.h"
#import "XRSegmentNavigationController.h"

@interface TCourseListViewController ()
{
    XRSegmentNavigationController * _xsvc;
}

@end

@implementation TCourseListViewController

/**
 *  初始化SegmentNavigationController
 */
- (void)setupSegmentNavigationController
{
    NSArray * titles = @[@"线上", @"线下"];
    NSArray * items  = @[@"TCourseOnlineViewController", @"TCourseOfflineViewController"];
    NSMutableArray * viewControllers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titles.count; i++) {
        Class subCls = NSClassFromString(items[i]);
        ParentViewController * pvc = [[subCls alloc] init];
        [viewControllers addObject:pvc];
    }
    
    // 创建segmentNav
    _xsvc = [[XRSegmentNavigationController alloc] initWithItems:viewControllers titles:titles];

    [_xsvc setColorWithBarColor:RGBACOLOR(254, 254, 254, 1.0) lineColor:RGBACOLOR(47, 187, 150, 1.0) lineViewColor:RGBACOLOR(240, 240, 240, 1.0) btnTitleColor:RGBACOLOR(47, 187, 150, 1.0)];
    
    [_xsvc setPosition:0];
    [_xsvc setTitleFont:[UIFont systemFontOfSize:20] barHeight:BAR_H buttonHeight:BUTTON_H];
    
#warning 若要push操作 必须传导航控制器
    
    [self.view addSubview:_xsvc.view];
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
