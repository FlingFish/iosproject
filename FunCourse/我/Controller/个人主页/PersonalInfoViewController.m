
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
#import "ModifyPersonalInfoViewController.h"
#import "EvaluatedViewController.h"
#import "BeenEvaluatedViewController.h"

static CGFloat KImageOrginalHeight = 0;

@interface PersonalInfoViewController ()<UIGestureRecognizerDelegate, UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView          *_tableView;
    MyImageView     * _zoomImageView;
    NSInteger                 picTag;
    MyImageView         *superBGView;
    MyImageView         *courseBGView;
    MyImageView       *courselevelBG;
    MyImageView         *TCourseBG;
    MyImageView           *LCourseBG;
    MyImageView   *courseLevelImgView;
    MyImageView               *header;
    UILabel           * nickNameLabel;
}
@end

@implementation PersonalInfoViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        superBGView = [[MyImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_SIZE.width, KImageOrginalHeight)];
        superBGView.image = [UIImage imageNamed:@"evaluatedBG"];
        [self setupHeaderView];
        
        _zoomImageView = [[MyImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_SIZE.width, KImageOrginalHeight-50)];
        [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/f9198618367adab47d5ff9e48bd4b31c8601e48e.jpg"] placeholderImage:[UIImage imageNamed:@"personBg2.jpg"]];
        _zoomImageView.tag = 100;
        [_zoomImageView addTarget:self action:@selector(editPersonalInfo:)];
        [superBGView addSubview:_zoomImageView];

        
        courseBGView = [[MyImageView alloc] init];
        courseBGView.frame = CGRectMake(0, CGRectGetMaxY(_zoomImageView.frame), SCREEN_SIZE.width, 50);
        courseBGView.image = [UIImage imageNamed:@"evaluatedBG"];
        [superBGView addSubview:courseBGView];
        
        courselevelBG = [[MyImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width/3, 50)];
        courselevelBG.image = [UIImage imageNamed:@"evaluatedBG"];
        [courseBGView addSubview:courselevelBG];
        
        UILabel *courseLevelLB = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_SIZE.width/3, 25)];
        courseLevelLB.font = [UIFont systemFontOfSize:9];
        courseLevelLB.text = @"课程评级";
        courseLevelLB.textAlignment = NSTextAlignmentCenter;
        [courselevelBG addSubview:courseLevelLB];
        
        courseLevelImgView = [[MyImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(courseLevelLB.frame), SCREEN_SIZE.width/3,25)];
        courseLevelImgView.image = [UIImage imageNamed:@"nav_icon_more"];
        [courselevelBG addSubview:courseLevelImgView];
        
        
        TCourseBG = [[MyImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(courselevelBG.frame), 0, SCREEN_SIZE.width/3, 50)];
        TCourseBG.image = [ UIImage imageNamed:@"nav_bar_black"];
        [courseBGView addSubview:TCourseBG];
        
        UILabel *tCourseLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_SIZE.width/3, 25)];
        tCourseLB.font = [UIFont systemFontOfSize:9];
        tCourseLB.text = @"教学";
        tCourseLB.textAlignment = NSTextAlignmentCenter;
        [TCourseBG addSubview:tCourseLB];
        
        UILabel *tCourseCountLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tCourseLB.frame), SCREEN_SIZE.width/4, 25)];
        tCourseCountLB.font = [UIFont systemFontOfSize:12];
        tCourseCountLB.textAlignment = NSTextAlignmentCenter;
        tCourseCountLB.text = @"14";
        [TCourseBG addSubview:tCourseCountLB];
        
        
        LCourseBG = [[MyImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TCourseBG.frame), 0, SCREEN_SIZE.width/3, 50)];
        LCourseBG.image = [UIImage imageNamed:@"evaluatedBG"];
        [courseBGView addSubview:LCourseBG];
        
        UILabel *lCourseLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width/3, 25)];
        lCourseLB.font = [UIFont systemFontOfSize:9];
        lCourseLB.text = @"求学";
        lCourseLB.textAlignment = NSTextAlignmentCenter;
        [LCourseBG addSubview:lCourseLB];
        
        UILabel *lCourseCountLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lCourseLB.frame), SCREEN_SIZE.width/3, 25)];
        lCourseCountLB.font = [UIFont systemFontOfSize:12];
        lCourseCountLB.text = @"17";
        lCourseCountLB.textAlignment  = NSTextAlignmentCenter;
        [LCourseBG addSubview:lCourseCountLB];
    }
    
    return self;
}

-(void)setupNavi
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIBarButtonItem * editItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(editPersonalInfo:)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"个人主页";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:editItem titleView:titleView];
}

/**
 *  创建头视图
 */
- (void)setupHeaderView
{
    CGFloat height = 0;
    
    if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5]) {
        height = 140;
    } else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5s]) {
        height = 180;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6]) {
        height = 220;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6_Plus]) {
        height = 270;
    }
    
    KImageOrginalHeight = height;
    
    header = [[MyImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    header.image = [UIImage imageNamed:@"header.jpg"];
    header.layer.masksToBounds = YES;
    header.layer.cornerRadius = 25;
    [header addTarget:self action:@selector(editPersonalInfo:)];
    header.tag = 101;
    [superBGView addSubview:header];
    
    nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(header.frame) + 10, header.frame.origin.y + 10, 100, 20)];
    nickNameLabel.text = @"小倩";
    nickNameLabel.font = [UIFont boldSystemFontOfSize:16];
    nickNameLabel.textColor = [UIColor redColor];
    
    [superBGView addSubview:nickNameLabel];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
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
    [_tableView addSubview:superBGView];
    [self.view addSubview:_tableView];
}

/**
 *  头部背景伸缩效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffSet = scrollView.contentOffset.y;
    if (yOffSet < -(KImageOrginalHeight)) {
        CGRect frame = superBGView.frame;
        frame.origin.y = yOffSet;
        frame.size.height = -yOffSet;
        superBGView.frame = frame;
        _zoomImageView.frame = CGRectMake(0,0, SCREEN_SIZE.width, superBGView.frame.size.height-50);
        courseBGView.frame = CGRectMake(0,superBGView.frame.size.height-50, SCREEN_SIZE.width, 50);
        header.frame = CGRectMake(20, _zoomImageView.frame.size.height-120, 50, 50);
        nickNameLabel.frame = CGRectMake(CGRectGetMaxX(header.frame) + 10, header.frame.origin.y + 10, 100, 20);
        
    }
}

#pragma  mark - UItableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headertitle = @"参与课程";
    return  headertitle;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    PersonalInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[PersonalInfoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.headerImageView.image = [UIImage imageNamed:@"cornerShare"];
        
        cell.titleLabel.text = @"这是参与过的课程标题";
        cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        cell.dataLabel.text = @"8";
        cell.dataLabel.font = [ UIFont systemFontOfSize:14.0];
        
    }
    return cell;
}

#pragma  mark - eiditPersonalInfo Method
/*
 *三个点击事件公用一个实践方法来弹出ActionSheet
 */
-(void)editPersonalInfo:(UIImageView *)img
{
    picTag = img.tag;
    if (picTag == 101) {
        //点击头像弹出修改头像ActionSheet
        UIActionSheet *editSheet = [[ UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
        [editSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    }else if (picTag == 100){
        //点击背景图片弹出修改背景墙ActionSheet
        UIActionSheet *editSheet = [[ UIActionSheet alloc] initWithTitle:@"修改背景墙" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"从相册选择",@"拍照", nil];
        [editSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    }else{
        //点击导航栏上编辑按钮弹出编辑资料ActionSheet
        UIActionSheet *editSheet = [[ UIActionSheet alloc] initWithTitle:@"基本资料" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"编辑资料", nil];
        [editSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    }
}

/*
 *ActionSheet方法
 */
#pragma mark - ActionSheet Methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    if (picTag == 100 || picTag == 101) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_black"] forBarMetrics:UIBarMetricsDefault];
        picker.navigationBar.backItem.title = @"fanhui ";
        picker.navigationBar.barTintColor = [UIColor grayColor];

        
  
        switch (buttonIndex) {
            case 0:
            {
                // 从相册选择
                [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                break;
            }
            case 1:{
                // 拍照
                [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                NSLog(@"模拟器无法使用拍照功能");
                break;
            }
            default:
                break;
        }
        // 允许编辑
        [picker setAllowsEditing:YES];
        // 设置代理
        [picker setDelegate:self];
        
        // 显示照片选择器
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        ModifyPersonalInfoViewController *mVC = [[ModifyPersonalInfoViewController alloc] init];
        [self.navigationController pushViewController:mVC animated:YES];
    }

}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  照片选择代理方法
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picTag == 101) {
        // 将选择的图片设置为头像
        header.image = info[UIImagePickerControllerEditedImage];
    }else if (picTag == 100){
        //将选择图片设置为背景墙
        _zoomImageView.image = info[UIImagePickerControllerEditedImage];
    }
    // 关闭照片选择器
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - PopNavigationController

-(void)back
{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    superBGView.frame = CGRectMake(0, -KImageOrginalHeight, SCREEN_SIZE.width, KImageOrginalHeight);
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavi];
    [self setupTableView];
    [self setupHeaderView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
