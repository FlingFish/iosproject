//
//  MainScreenViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "MainScreenViewController.h"
#import "TCourseListViewController.h"
#import "LCourseListViewController.h"
#import "AddTCourseViewController.h"
#import "AddLCourseViewController.h"
#import "TypePickerView.h"
#import "RNExpandingButtonBar.h"
#import "AppDelegate.h"
#import "MyImageView.h"

@interface MainScreenViewController ()<RNExpandingButtonBarDelegate>
{
    TCourseListViewController * _tListViewController;
    LCourseListViewController * _lListViewController;
    
    NSInteger _currentIndex; // 当前索引
}

@property (nonatomic, strong) RNExpandingButtonBar * bar;
@property (nonatomic, strong) MyImageView * backImageView;

@end

@implementation MainScreenViewController

// AppDelegate助手方法
- (AppDelegate *)defaultDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    // titleView
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:@[@"教", @"学"]];
    segment.backgroundColor = [UIColor whiteColor];
    segment.frame = CGRectMake(0, 0, 90, 30);
    segment.layer.masksToBounds = YES;
    segment.layer.cornerRadius = 15;
    segment.selectedSegmentIndex = 0; // 默认选中第一个选项
    // segment添加事件
    [segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Add
    UIBarButtonItem * rightAddBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addActionClick)];
    
    [self addNavigationWithTitle:nil leftItem:nil rightItem:rightAddBtn titleView:segment];
    
    // 初始化教和学活动列表控制器
    _tListViewController = [[TCourseListViewController alloc] init];
    _lListViewController = [[LCourseListViewController alloc] init];
    
    // 默认加载教
    _currentIndex = 0;
    [self.view addSubview:_tListViewController.view];
    
    // 添加弹出按钮
    UIImage * image = [UIImage imageNamed:@"red_plus_up"];
    UIImage * selectedImage = [UIImage imageNamed:@"red_plus_down"];
    
    UIImage * toggerImage = [UIImage imageNamed:@"red_x_up"];
    UIImage * toggerSelectedImage = [UIImage imageNamed:@"red_x_down"];
    
    CGPoint center = CGPointMake(SCREEN_SIZE.width - 40, SCREEN_SIZE.height - 64 - 49 - 40);
    NSMutableArray * buttons = [[NSMutableArray alloc] init];
    NSArray * imageArray = @[@"next", @"lightbulb", @"check"];
    
    for (int i = 0; i < 3; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
        button.tag = 1001 + i;
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 20.0;
        [button addTarget:self action:@selector(popButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
    }
    
    self.bar = [[RNExpandingButtonBar alloc] initWithImage:image selectedImage:selectedImage toggledImage:toggerImage toggledSelectedImage:toggerSelectedImage buttons:buttons center:center];
    
    [self.bar setDelegate:self];
    [self.bar setSpin:YES];
    
    [self.view addSubview:self.bar];
    
    [self.view addSubview:self.backImageView];
    _backImageView.alpha = 0.0;
}

// backImageView
- (UIImageView *)backImageView
{
    if (_backImageView == nil) {
        _backImageView = [[MyImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64 - 49)];
        _backImageView.backgroundColor = [UIColor blackColor];
        _backImageView.alpha = 0.5;
        [_backImageView addTarget:self action:@selector(imageTogger)];
    }
    return _backImageView;
}

// 点击灰色图片
- (void)imageTogger
{
    _backImageView.alpha = 0.0;
    [self.bar hideButtonsAnimated:YES];
}

// 筛选按钮Action
- (void)popButtonAction:(UIButton *)button
{
    switch (button.tag) {
        case 1001:
        {
            
        }
            break;
        case 1002:
        {
            
        }
            break;
        case 1003:
        {
            
        }
            break;
        default:
            break;
    }
    [self.bar hideButtonsAnimated:YES];
}

/**
 *  segmentControl索引改变 加载知和足列表界面
 */
- (void)segmentChanged:(UISegmentedControl *)segment
{
    if (0 == segment.selectedSegmentIndex) {
        // 加载教
        _currentIndex = 0;
        [self.view addSubview:_tListViewController.view];
    }else {
        // 加载学
        _currentIndex = 1;
        [self.view addSubview:_lListViewController.view];
    }
}

/**
 *  添加知或足的活动
 */
- (void)addActionClick
{
    if (0 == _currentIndex) {
        AddTCourseViewController * addTCourse = [[AddTCourseViewController alloc] init];
        addTCourse.hidesBottomBarWhenPushed = YES;
        addTCourse.superNvc = self.navigationController;
        [self.navigationController pushViewController:addTCourse animated:YES];
    }else {
        AddLCourseViewController * addLCourse = [[AddLCourseViewController alloc] init];
        addLCourse.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addLCourse animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - RNExpandingBarDelegate

- (void)expandingBarDidAppear:(RNExpandingButtonBar *)bar
{
    
}

- (void)expandingBarDidDisappear:(RNExpandingButtonBar *)bar
{
    
}

- (void)expandingBarWillAppear:(RNExpandingButtonBar *)bar
{
    _backImageView.alpha = 0.5;
}

- (void)expandingBarWillDisappear:(RNExpandingButtonBar *)bar
{
    _backImageView.alpha = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
