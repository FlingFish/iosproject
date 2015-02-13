//
//  StartPageViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/19.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//
// 开机引导页

#define kBorder 30
#define kButton_Width 80
#define kButton_Height 44

#import "StartPageViewController.h"
#import "MyImageView.h"
#import "RegisterViewController1.h"
#import "RootNavigationViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface StartPageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) UIScrollView * startPage;
@property (nonatomic, strong) NSMutableArray * imagesArray;

@end

@implementation StartPageViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.imagesArray = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            [self.imagesArray addObject:[NSString stringWithFormat:@"start%d.jpg", i+1]];
        }
    }
    return self;
}

/**
 *  AppDelegate助手方法
 */
- (AppDelegate *)defaultDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

/**
 *  创建引导页
 */
- (void)setupStartPage
{
    self.startPage = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.startPage.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.startPage];
    
    [self fillData];
}

/**
 *  填充数据
 */
- (void)fillData
{
    for (int i = 0; i < self.imagesArray.count; i++) {
        MyImageView * imageView = [[MyImageView alloc] initWithFrame:CGRectMake(i * SCREEN_SIZE.width, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
        imageView.image = [UIImage imageNamed:self.imagesArray[i]];
        imageView.index = i;
        
        if (i == self.imagesArray.count - 1) {
            // 创建登录注册选择按钮
            UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(kBorder, SCREEN_SIZE.height - 180, kButton_Width, kButton_Height)];
            [registerButton setTitle:@"新用户" forState:UIControlStateNormal];
            registerButton.layer.masksToBounds = YES;
            registerButton.layer.cornerRadius = 5;
            [registerButton setBackgroundColor:RGBACOLOR(66, 176, 230, 1.0)];
            [registerButton addTarget:self action:@selector(pushRegisterVc) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:registerButton];
            
            UIButton * loginButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - kButton_Width - kBorder, SCREEN_SIZE.height - 180, kButton_Width, kButton_Height)];
            [loginButton setTitle:@"登录" forState:UIControlStateNormal];
            [loginButton setBackgroundColor:RGBACOLOR(66, 176, 230, 1.0)];
            loginButton.layer.masksToBounds = YES;
            loginButton.layer.cornerRadius = 5;
            [loginButton addTarget:self action:@selector(pushLoginVc) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:loginButton];
        }
        
        [self.startPage addSubview:imageView];
    }
    
    self.startPage.contentSize = CGSizeMake(SCREEN_SIZE.width * self.imagesArray.count, 0);
    self.startPage.showsHorizontalScrollIndicator = NO;
    self.startPage.showsVerticalScrollIndicator = NO;
    self.startPage.pagingEnabled = YES;
    self.startPage.bounces = NO;
    self.startPage.bouncesZoom = NO;
    self.startPage.delegate = self;
    
    // 创建self.pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_SIZE.height - 100, SCREEN_SIZE.width, 50)];
    self.pageControl.numberOfPages = self.imagesArray.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
}

- (void)pageControlChanged:(UIPageControl *)page
{
    CGPoint point = CGPointMake(page.currentPage * SCREEN_SIZE.width, 0);
    self.startPage.contentOffset = point;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;
    NSInteger currentPage = currentOffset.x / SCREEN_SIZE.width;
    self.pageControl.currentPage = currentPage;
}

/**
 *  注册
 */
- (void)pushRegisterVc
{
    RootNavigationViewController * nav = [[RootNavigationViewController alloc] initWithRootViewController:[[RegisterViewController1 alloc] init]];
    [self defaultDelegate].window.rootViewController = nav;
}

/**
 *  登录
 */
- (void)pushLoginVc
{
    [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupStartPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
