//
//  ParentViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "ParentViewController.h"
#import "GetCurrentDevice.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

/**
 *  设置导航栏上的标题和按钮
 */
- (void)addNavigationWithTitle:(NSString *)title leftItem:(UIBarButtonItem *)left rightItem:(UIBarButtonItem *)right titleView:(UIView *)view
{
    if (title) {
        // 设置导航的标题
        self.navigationItem.title = title;
    }
    
    if (left) {
        // 设置左边的itemhangang wo de jiqi shi wo de dSDFsdfdfsdfe
        self.navigationItem.leftBarButtonItem = left;
    }
    
    if (right) {
        // 设置右边的item
        self.navigationItem.rightBarButtonItem = right;
    }
    
    if (view) {
        // 设置标题view
        self.navigationItem.titleView = view;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // 设置状态栏背景为白色
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
