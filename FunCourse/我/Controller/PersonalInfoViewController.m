
//
//  PersonalInfoViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "GetCurrentDevice.h"
#import "MyImageView.h"
#import "PersonalInfoCell.h"

static CGFloat KImageOrginalHeight = 0;

@interface PersonalInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    MyImageView * _zoomImageView;
}
@end

@implementation PersonalInfoViewController

- (instancetype)init
{
    if (self = [super init]) {
        _zoomImageView = [[MyImageView alloc] init];
        [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/f9198618367adab47d5ff9e48bd4b31c8601e48e.jpg"] placeholderImage:[UIImage imageNamed:@"personBg2.jpg"]];
        [self setupHeaderView];
    }
    
    return self;
}

-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"个人主页";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
}

/**
 *  创建头视图
 */
- (void)setupHeaderView
{
    CGFloat height = 0;
    
    if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5]) {
        height = 120;
    } else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5s]) {
        height = 150;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6]) {
        height = 200;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6_Plus]) {
        height = 250;
    }
    
    KImageOrginalHeight = height;
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    header.image = [UIImage imageNamed:@"header.jpg"];
    header.layer.masksToBounds = YES;
    header.layer.cornerRadius = 25;
    [_zoomImageView addSubview:header];
    
    UILabel * nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(header.frame) + 10, header.frame.origin.y + 10, 100, 20)];
    nickNameLabel.text = @"小倩";
    nickNameLabel.font = [UIFont boldSystemFontOfSize:16];
    nickNameLabel.textColor = [UIColor redColor];
    
    [_zoomImageView addSubview:nickNameLabel];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(KImageOrginalHeight, 0, 0, 0);
    
    // 去掉cell留白 iOS 7
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // iOS 8
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView addSubview:_zoomImageView];
    [self.view addSubview:_tableView];
}

/**
 *  头部背景伸缩效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffSet = scrollView.contentOffset.y;
    if (yOffSet < -KImageOrginalHeight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = yOffSet;
        frame.size.height = -yOffSet;
        _zoomImageView.frame = frame;
    }
}

#pragma  mark - UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else
    {
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 30;
    }else
    {
        return 30;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSString *headertitle = @"评价历史";
        return    headertitle;
    }else
    {
      NSString *headertitle = @"参与课程";
      return  headertitle;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    PersonalInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    if (!cell) {
        cell = [[PersonalInfoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        if (indexPath.section == 0) {
            cell.headImge.hidden = YES;
            cell.titleLabel.frame = CGRectMake(5, 2, 150, 40);
            cell.dataLabel.frame = CGRectMake(CGRectGetMaxX(cell.titleLabel.frame)+ 5, 2, SCREEN_SIZE.width-(CGRectGetMaxX(cell.titleLabel.frame))-10, 40);
            if (indexPath.row == 0)
            {
                cell.titleLabel.text = @"我的课程评级";
                cell.dataLabel.text = @"三星";
            }else if (indexPath.row == 1)
            {
               cell.titleLabel.text = @"评价过的课程";
              cell.dataLabel.text = @"23次";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }else if (indexPath.row == 2)
            {
              cell.titleLabel.text = @"被评价的课程";
              cell.dataLabel.text = @"89次";
              cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
  
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
    
}
#pragma mark - cellButtonClicked
-(void)evaluatedCourse
{
    NSLog(@"hello");
}

-(void)MyevaluatedCourse
{
    NSLog(@"hello");
}

#pragma mark - PopNavigationController
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _zoomImageView.frame = CGRectMake(0, -KImageOrginalHeight, SCREEN_SIZE.width, KImageOrginalHeight);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
