//
//  EvaluateTCourseViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//
#define XBorder 15
#define YBorder 25
#define Height  30

#import "EvaluateTCourseViewController.h"

@interface EvaluateTCourseViewController ()

@end

@implementation EvaluateTCourseViewController


-(void)setupNavi
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"课程评价";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
}


- (void)createUI
{
    // 头像
    UIImageView *headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(XBorder, 2*YBorder, 2*YBorder, 2*YBorder) ];
    headerImg.image = [UIImage imageNamed:@"cornerShare"];
    [self.view addSubview:headerImg];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc ] initWithFrame:CGRectMake(CGRectGetMaxX(headerImg.frame)+XBorder, 2*YBorder+XBorder, SCREEN_SIZE.width-3*XBorder-2*YBorder, Height)];
    titleLabel.text = @"钢琴教学";
    titleLabel.backgroundColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:titleLabel];
    
    // 分数标题
    UILabel *scoreLB = [[UILabel alloc] initWithFrame:CGRectMake(XBorder,CGRectGetMaxY(titleLabel.frame)+YBorder, 2*YBorder, Height)];
    scoreLB.text = @"评分";
    scoreLB.backgroundColor = [UIColor grayColor];
    scoreLB.textAlignment = NSTextAlignmentCenter;
    scoreLB.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:scoreLB];
    
    // 评分textfiled
    UITextField *scoreTF = [[ UITextField alloc ] initWithFrame:CGRectMake(SCREEN_SIZE.width - 150, CGRectGetMaxY(titleLabel.frame)+YBorder, 4*YBorder, Height)];
    scoreTF.font = [UIFont systemFontOfSize:14.0];
    scoreTF.backgroundColor = [UIColor grayColor];
    scoreTF.placeholder = @"评分为0-10分";
    scoreTF.tag = 400;
    [self.view addSubview:scoreTF];
    
    // 评论标题
    UILabel *commentLB = [[UILabel alloc] initWithFrame:CGRectMake(XBorder, CGRectGetMaxY(scoreTF.frame)+YBorder, 2*YBorder, Height)];
    commentLB.font = [ UIFont systemFontOfSize:14.0];
    commentLB.text = @"评论";
    commentLB.backgroundColor = [UIColor grayColor];
    commentLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:commentLB];
    
    // 评论内容textview
    UITextView *commentTV = [[ UITextView alloc ] initWithFrame:CGRectMake(XBorder, CGRectGetMaxY(commentLB.frame)+YBorder, SCREEN_SIZE.width-2*XBorder, 80)];
    commentTV.font = [UIFont systemFontOfSize:14.0];
    commentTV.backgroundColor = [UIColor grayColor];
    commentTV.text = @"在这里评论.";
    commentTV.tag = 401;
    [self.view addSubview:commentTV];
    
    UIView *bottomBG = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_SIZE.height-64-50, SCREEN_SIZE.width, 50)];
    bottomBG.backgroundColor = RGB(37 , 31, 39, 0.2);
    [self.view addSubview:bottomBG];
    [self.view bringSubviewToFront:bottomBG];
    
    UIButton   *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 3, SCREEN_SIZE.width-40, 44)];
    sureButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [sureButton setTitle:@"确认评价" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureEvaluate) forControlEvents:UIControlEventTouchUpInside];
    sureButton.backgroundColor = RGB(67 , 170, 255, 1.0);
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 3;
    [bottomBG addSubview:sureButton];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击UITextField 和UItextView以外任何区域收回键盘
    UITextField *scoreTF = (UITextField *)[self.view viewWithTag:400];
    UITextView *commentTV = (UITextView *)[self.view viewWithTag:401];
    [scoreTF resignFirstResponder];
    [commentTV resignFirstResponder];
}

- (void)sureEvaluate{
    [self.superNvc popViewControllerAnimated: YES];
}

- (void)back
{
    [self.superNvc popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI ];
    [self setupNavi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
