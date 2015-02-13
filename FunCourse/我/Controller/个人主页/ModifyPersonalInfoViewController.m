//
//  ModifyPersonalInfoViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "ModifyPersonalInfoViewController.h"
#import "ModifyPersonalInfoCell.h"


@interface ModifyPersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ModifyPersonalInfoViewController

-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"编辑资料";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
}

-(void)setupTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section  == 0)
    {
        return 4;
    }else
    {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ID";
    ModifyPersonalInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    if (!cell) {
                cell = [[ModifyPersonalInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.titleLB.frame = CGRectMake(5, 0, 120, 30);
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0) {
                cell.titleLB.text = @"昵称";
                cell.dataTF.frame = CGRectMake(CGRectGetMaxX(cell.titleLB.frame)+15,0, SCREEN_SIZE.width-145, 30);
                cell.dataTF.placeholder = @"hello world";
            }else if (indexPath.row == 1)
            {
                cell.titleLB.text = @"性别";
                cell.dataTF.frame = CGRectMake(CGRectGetMaxX(cell.titleLB.frame)+15,0, SCREEN_SIZE.width-145, 30);
                cell.dataTF.text = @"男";
            }
            else if (indexPath.row == 2)
            {
                cell.titleLB.text = @"年龄";
                cell.dataLB.frame = CGRectMake(CGRectGetMaxX(cell.titleLB.frame)+15,0, SCREEN_SIZE.width-145, 30);
                cell.dataLB.text = @"22";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if (indexPath.row == 3)
            {
                cell.titleLB.text = @"邮箱";
                cell.dataLB.frame = CGRectMake(CGRectGetMaxX(cell.titleLB.frame)+15,0, SCREEN_SIZE.width-145, 30);
                cell.dataLB.text = @"22";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }else if (indexPath.section == 1)
        {
            if (indexPath.row == 0) {
                cell.titleLB.text = @"职业";
                cell.dataLB.frame = CGRectMake(CGRectGetMaxX(cell.titleLB.frame)+15,0, SCREEN_SIZE.width-145, 30);
                cell.dataLB.text = @"用户职业";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if (indexPath.row ==1)
            {
                cell.titleLB.text = @"所在地";
                cell.dataLB.frame = CGRectMake(CGRectGetMaxX(cell.titleLB.frame)+15,0, SCREEN_SIZE.width-145, 30);
                cell.dataLB.text = @"上海市宝山区";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    }
    return cell;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self setupTableView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
