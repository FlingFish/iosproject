//
//  MessageCenterScreenViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

// 消息页面

#import "MessageCenterScreenViewController.h"
#import "XRSegmentNavigationController.h"
#import "NotificationMessageViewController.h"
#import "FriendListScreenViewController.h"
#import "AddFriendViewController.h"

@interface MessageCenterScreenViewController ()
{
    XRSegmentNavigationController * _segmentVc;
}

@property (nonatomic, strong) NSMutableArray * viewControllers;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MessageCenterScreenViewController

/**
 *  初始化segmentNav
 */
- (void)setupSegmentNavigationController
{
    NSArray * titles = @[@"通知", @"好友"];
    NSArray * items  = @[@"NotificationMessageViewController", @"FriendListScreenViewController"];
    self.viewControllers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titles.count; i++) {
        Class subCls = NSClassFromString(items[i]);
        ParentViewController * pvc = [[subCls alloc] init];
        [self.viewControllers addObject:pvc];
    }
    
    // 创建segmentNav
    _segmentVc = [[XRSegmentNavigationController alloc] initWithItems:self.viewControllers titles:titles];
    
    [_segmentVc setColorWithBarColor:RGBACOLOR(254, 254, 254, 1.0) lineColor:RGBACOLOR(47, 187, 150, 1.0) lineViewColor:RGBACOLOR(240, 240, 240, 1.0) btnTitleColor:RGBACOLOR(47, 187, 150, 1.0)];
    [_segmentVc setPosition:0];
    [_segmentVc setTitleFont:[UIFont systemFontOfSize:20] barHeight:40 buttonHeight:39];
    // 通知
    NotificationMessageViewController * messageVc = (NotificationMessageViewController *)self.viewControllers[0];
    messageVc.superNvc = self.navigationController;
    // 好友
    FriendListScreenViewController * friendListVc = (FriendListScreenViewController *)[self.viewControllers lastObject];
    friendListVc.superNvc = self.navigationController;
    [self.view addSubview:_segmentVc.view];
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    [self setupSegmentNavigationController];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"消息";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    UIButton * addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [addButton setImage:[[UIImage imageNamed:@"nav_icon_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(pushAddFriendVc) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    [self addNavigationWithTitle:nil leftItem:nil rightItem:addFriendItem titleView:titleView];
    // 执行XRSegmentController的Block回调
    [_segmentVc changedIndexWithCallBack:^(NSInteger index) {
        if (index == 0) {
            addButton.hidden = YES;
        }else {
            addButton.hidden = NO;
        }
    }];
}


/**
 *  push到添加好友页面
 */
- (void)pushAddFriendVc
{
    AddFriendViewController * afVc = [[AddFriendViewController alloc] init];
    afVc.hidesBottomBarWhenPushed = YES;
    afVc.superNav = self.navigationController;
    [self.navigationController pushViewController:afVc animated:YES];
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
