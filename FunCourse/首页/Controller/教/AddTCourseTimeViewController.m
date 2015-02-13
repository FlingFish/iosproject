//
//  AddTCourseTimeViewController.m
//  FunCourse
//
//  Created by 韩刚 on 15/2/9.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define BHeight 30
#define XBorder 1
#define ButtonColor RGB(37 , 31, 39, 0.9)

#import "AddTCourseTimeViewController.h"

@interface AddTCourseTimeViewController ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    CGFloat      btnHeight;
    NSInteger     indexTag;
    CGFloat        xBorder;
    CGFloat        pbWidth;
    NSString        * _dateString; // 时间字符串
    NSInteger        tfTag;
    UILabel        *bTimeLB;
    UILabel      *endTimeLB;
    NSInteger      btnTag;
}

@property (nonatomic, strong) UIDatePicker * datePicker; // 日期选择器

@end

@implementation AddTCourseTimeViewController

-(void)setNavi{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIBarButtonItem *submit = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(Submit)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"发布课程(4/4)";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:submit titleView:titleView];
}

-(void)createUI{
    
    //根据iphone设备的型号来进行页面布局的适配
    CGFloat     bWidth = 0;
    pbWidth = 0;
    xBorder = 0;
    CGFloat     YBorder = 0;
    
    if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5])
    {
        bWidth  = 300;
        pbWidth = 221;
        btnHeight = 30;
        YBorder = 18;
    } else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5s])
    {
        bWidth = 300;
        btnHeight = 35;
        pbWidth = 225;
        YBorder = 35;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6])
    {
        bWidth = 335;
        btnHeight = 40;
        pbWidth = 260;
        YBorder = 53;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6_Plus]) {
        bWidth  = 364;
        btnHeight = 45;
        pbWidth = 289;
        YBorder = 65;
    }
    xBorder = (SCREEN_SIZE.width - bWidth)/2;

    // 开课时间按钮
    UIButton *bTimeBtn =[[UIButton alloc]initWithFrame:CGRectMake(xBorder, 50, bWidth, btnHeight-2)];
    [bTimeBtn setTitle:@"点击选择开课时间" forState:UIControlStateNormal];
    [bTimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    bTimeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    bTimeBtn.backgroundColor=ButtonColor;
    [bTimeBtn.layer setMasksToBounds:YES];
    [bTimeBtn.layer setCornerRadius:5];
    [bTimeBtn addTarget:self action:@selector(timeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    bTimeBtn.tag = 1000;
    [self.view addSubview:bTimeBtn];
    
    // 开课时间
    bTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(bTimeBtn.frame)+5, bWidth, btnHeight-2)];
    bTimeLB.font = [UIFont systemFontOfSize:14.0];
    bTimeLB.text = @"开课时间";
    bTimeLB.textAlignment = NSTextAlignmentCenter;
    bTimeLB.backgroundColor = [UIColor whiteColor];
    [bTimeLB.layer setMasksToBounds:YES];
    [bTimeLB.layer setCornerRadius:5];
    [bTimeLB.layer setBorderWidth:0.6];
    bTimeLB.tag = 100;
    [self.view addSubview:bTimeLB];
    
    // 结束时间按钮
    UIButton *endTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(bTimeLB.frame)+YBorder-5, bWidth, btnHeight)];
    [endTimeBtn setTitle:@"点击选择结课时间" forState:UIControlStateNormal];
    [endTimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    endTimeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    endTimeBtn.backgroundColor=ButtonColor;
    [endTimeBtn.layer setMasksToBounds:YES];
    [endTimeBtn.layer setCornerRadius:5];
    [endTimeBtn addTarget:self action:@selector(timeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    endTimeBtn.tag = 2000;
    [self.view addSubview:endTimeBtn];
    
    // 点击结束时间按钮呼出DatePicker选择时间
    endTimeLB =[[UILabel alloc]initWithFrame:CGRectMake(xBorder,CGRectGetMaxY(endTimeBtn.frame)+5,bWidth, btnHeight-2)];
    endTimeLB.font = [UIFont systemFontOfSize:14.0];
    endTimeLB.text = @"结课时间";
    endTimeLB.textAlignment = NSTextAlignmentCenter;
    endTimeLB.backgroundColor = [UIColor whiteColor];
    [endTimeLB.layer setMasksToBounds:YES];
    [endTimeLB.layer setCornerRadius:5];
    [endTimeLB.layer setBorderWidth:0.6];
    endTimeLB.tag = 101;
    [self.view addSubview:endTimeLB];
    
    [self.view addSubview:self.datePicker];
}


- (void)timeBtnClicked:(UIButton *)btn
{
    btnTag = btn.tag;
}
#pragma mark - DatePicker Methods
// 日期选择
- (UIDatePicker *)datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init]; // 设置datePicker的大小必须单独设置其frame
        _datePicker.frame = CGRectMake(0, SCREEN_SIZE.height - 216, SCREEN_SIZE.width, 162);
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
        // 设定默认值
        NSString * defaultDateStr = @"2015-01-01 00:00:00";
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss +0800"; // 修改为东八区
        // 转换为日期
        NSDate * defaultDate = [formatter dateFromString:defaultDateStr];
        NSLog(@"%@", defaultDate);
        
        [_datePicker setDate:defaultDate];
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

// 时间格式化转换
- (NSString *)timeStrWithDate:(NSDate *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm +0800"; // 修改为东八区
    
    // 格式化时间
    NSString * timeStr = [formatter stringFromDate:date];
    
    // 截取
    NSArray * timeArray = [timeStr componentsSeparatedByString:@"+"];
    timeStr = [timeArray objectAtIndex:0];
    
    return timeStr;
}

// datePicker的值改变
- (void)datePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDate * date = datePicker.date; // 取出日期
    NSString * timeStr = [self timeStrWithDate:date];
    if (btnTag == 1000) {
        
        bTimeLB.text = timeStr;
    }else if (btnTag == 2000){
        
        endTimeLB.text = timeStr;
    }
}

-(void)Submit
{
    NSLog(@"hahah");
    UIActionSheet *backORcheck = [[ UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"返回首页" destructiveButtonTitle:nil otherButtonTitles:@"查看课程", nil];
    [backORcheck showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma  mark - ActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    switch (buttonIndex) {
        case 0:{
            NSLog(@" check button clicked !");
            break;
        }
        case 1:{
            NSLog(@" back button clicked !");
        }
        default:
            break;
    }
}

-(void)back{
    [self.superNvc popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavi];
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
