//
//  NeenedEvaluateMessageViewController.m
//  FunCourse
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//  待评价

#import "NeenedEvaluateMessageViewController.h"
#import "SRRefreshView.h"
#import "NeedEvaluateCell.h"
#import "EvaluateTCourseViewController.h"

@interface NeenedEvaluateMessageViewController ()<UITableViewDataSource,SRRefreshDelegate,UITableViewDelegate>
{
    UITableView * _tableView;
}

// 刷新
@property (nonatomic, strong) SRRefreshView * refreshView;

@end

@implementation NeenedEvaluateMessageViewController

-(void)setupNavi
{

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"待评价课程";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width,  SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
}

#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    
    NeedEvaluateCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NeedEvaluateCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
        if (indexPath.section == 0) {
            
            cell.headerImageView.image = [UIImage imageNamed:@"cornerShare"];
            cell.titleLabel.text = @"待评价课程名称";
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EvaluateTCourseViewController *eVC = [[EvaluateTCourseViewController alloc] init];
    eVC.superNvc = self.superNvc;
    eVC.hidesBottomBarWhenPushed = YES;
    [self.superNvc pushViewController:eVC animated:YES];
}

-(void)back
{
    [self.superNvc popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{   
    [super viewDidLoad];
    [self setupNavi];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
