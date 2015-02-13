//
//  AddTCourseMoreViewController.m
//  FunCourse
//
//  Created by 韩刚 on 15/1/30.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "AddTCourseMoreViewController.h"
#import "AddTCourseNextViewController.h"

#define BHeight 30
#define XBorder 1
#define ButtonColor RGB(37 , 31, 39, 0.9)

@interface AddTCourseMoreViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    NSString        * _dateString; // 时间字符串
    CGFloat                btnHeight;
    UIView              *superBG;
    NSInteger            indexTag;
    CGFloat             xBorder;
    CGFloat             pbWidth;
    NSInteger            TFTag;
}

@property (nonatomic, assign) OnlineState state;

@property (nonatomic, assign) FreeState freestate;

@end

@implementation AddTCourseMoreViewController

-(void)setupUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIBarButtonItem *next = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtnClicked)];

    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"发布课程(2/4)";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:next titleView:titleView];
    
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
    
    superBG =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    superBG.backgroundColor = [ UIColor whiteColor];
    [self.view addSubview:superBG];
    
    // 最顶申明文字Label
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(xBorder, 0, bWidth, 50)];
    introLabel.text = @"欢迎您发布课程，请认真填写真实的课程相关信息，请勿包含任何非法信息！";
    introLabel.font = [UIFont systemFontOfSize:13.0];
    introLabel.numberOfLines = 0;
    introLabel.textColor = [ UIColor lightGrayColor];
    [superBG addSubview:introLabel];
    
    //授课方式标题按钮和线上线下按钮背景
    UIView *whereBG = [[UIView alloc] initWithFrame:CGRectMake(xBorder, 50, bWidth, btnHeight)];
    whereBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:whereBG];
    
    // 授课方式标题按钮
    UIButton *whereBtn = [[UIButton alloc]initWithFrame:CGRectMake(xBorder, 1, 70, btnHeight-2)];
    [whereBtn setTitle:@"授课方式" forState:UIControlStateNormal];
    [whereBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    whereBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    whereBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    whereBtn.backgroundColor = ButtonColor;
    [whereBtn.layer setMasksToBounds:YES];
    [whereBtn.layer setCornerRadius:5];
    [whereBG addSubview:whereBtn];
    
    //线上按钮
    UIButton *onlineBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(whereBtn.frame)+108, 1, 50, btnHeight)];
    [onlineBtn setImage:[UIImage imageNamed:@"online_normal"] forState:UIControlStateNormal];
    [onlineBtn setImage:[UIImage imageNamed:@"online_selected"] forState:UIControlStateSelected];
    [onlineBtn addTarget:self action:@selector(choseOnlineorOffline:) forControlEvents:UIControlEventTouchUpInside];
    onlineBtn.selected = YES;
    self.state = Online;
    onlineBtn.tag = 301;
    [whereBG addSubview:onlineBtn];
    
    //线下按钮
    UIButton *offlineBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(onlineBtn.frame)+10, 1,50, btnHeight)];
    [offlineBtn setImage:[UIImage imageNamed:@"offline_normal"] forState:UIControlStateNormal];
    [offlineBtn setImage:[UIImage imageNamed:@"offline_selected"] forState:UIControlStateSelected];
    [offlineBtn addTarget:self action:@selector(choseOnlineorOffline:) forControlEvents:UIControlEventTouchUpInside];
    offlineBtn.tag = 302;
    [whereBG addSubview:offlineBtn];
    
    //收费方式背景
    UIView *paymentBG = [[UIView alloc] initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(whereBG.frame)+YBorder, bWidth, 2*btnHeight+5)];
    paymentBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:paymentBG];
    
    //收费方式按钮
    UIButton *isneedPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(xBorder, 0, 70, btnHeight)];
    [isneedPayBtn setTitle:@"是否收费" forState:UIControlStateNormal];
    [isneedPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    isneedPayBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    isneedPayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    isneedPayBtn.backgroundColor = ButtonColor;
    [isneedPayBtn.layer setMasksToBounds:YES];
    [isneedPayBtn.layer setCornerRadius:5];
    [paymentBG addSubview:isneedPayBtn];
    
    //免费按钮
    UIButton *freeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(isneedPayBtn.frame)+5, 50, btnHeight)];
    [freeBtn setImage:[UIImage imageNamed:@"free_normal"] forState:UIControlStateNormal];
    [freeBtn setImage:[UIImage imageNamed:@"free_selected"] forState:UIControlStateSelected];
    freeBtn.tag = 303;
    freeBtn.selected = YES;
    [freeBtn addTarget:self action:@selector(choseFreeorNeedPay:) forControlEvents:UIControlEventTouchUpInside];
    [paymentBG addSubview:freeBtn];
    
    //收费按钮
    UIButton *paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(freeBtn.frame)+20, CGRectGetMaxY(isneedPayBtn.frame)+5, 50, btnHeight)];
    [paymentBtn setImage:[UIImage imageNamed:@"needpay_normal"] forState:UIControlStateNormal];
    [paymentBtn setImage:[UIImage imageNamed:@"needpay_selected"] forState:UIControlStateSelected];
    paymentBtn.tag = 304;
    [paymentBtn addTarget:self action:@selector(choseFreeorNeedPay:) forControlEvents:UIControlEventTouchUpInside];
    [paymentBG addSubview:paymentBtn];
    
    //价格输入框
    UITextField *priceTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(paymentBtn.frame)+65,  CGRectGetMaxY(isneedPayBtn.frame)+1, 80, btnHeight - 2)];
    priceTF.placeholder = @"开个价";
    priceTF.backgroundColor = RGB(128, 128, 128, 0.1);
    priceTF.delegate = self ;
    priceTF.tag = 403 ;
    priceTF.keyboardType = UIKeyboardTypeNumberPad;
    priceTF.returnKeyType = UIReturnKeyDone;
    priceTF.font = [UIFont systemFontOfSize:14.0];
    priceTF.hidden =YES;
    [priceTF.layer setCornerRadius:5];
    [priceTF.layer setBorderWidth:0.6];
    [paymentBG addSubview:priceTF];
    
    //价格标签
    UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceTF.frame)+3, CGRectGetMaxY(isneedPayBtn.frame)+1, 40, btnHeight-1)];
    priceLB.text = @"￥";
    priceLB.font = [UIFont systemFontOfSize:14.0];
    priceLB.hidden = YES;
    priceLB.tag = 999;
    [paymentBG addSubview:priceLB];
    
    //授课人数上限背景
    UIView *maxMumberBG = [[UIView alloc] initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(paymentBG.frame)+YBorder, bWidth, btnHeight)];
    maxMumberBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:maxMumberBG];
    
    UIButton *maxMumBtn = [[UIButton alloc]initWithFrame:CGRectMake(xBorder, 1, 70, btnHeight-2)];
    [maxMumBtn setTitle:@"人数上限" forState:UIControlStateNormal];
    [maxMumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    maxMumBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    maxMumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    maxMumBtn.backgroundColor = ButtonColor;
    [maxMumBtn.layer setMasksToBounds:YES];
    [maxMumBtn.layer setCornerRadius:5];
    [maxMumberBG addSubview:maxMumBtn];
    
    UITextField *maxMunTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(paymentBtn.frame)+65, 1, 80, btnHeight-2)];
    maxMunTF.placeholder = @"填写人数";
    maxMunTF.backgroundColor = RGB(128, 128, 128, 0.1);
    maxMunTF.delegate = self ;
    maxMunTF.tag = 400 ;
    maxMunTF.keyboardType = UIKeyboardTypeNumberPad;
    maxMunTF.font = [UIFont systemFontOfSize:14.0];
    [maxMunTF.layer setCornerRadius:5];
    [maxMunTF.layer setBorderWidth:0.6];
    [maxMumberBG addSubview:maxMunTF];
    
    UILabel *perLB = [[ UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(maxMunTF.frame)+3, 1, 30, btnHeight-2)];
    perLB.text = @"人";
    perLB.font = [UIFont systemFontOfSize:13.5];
    [maxMumberBG addSubview:perLB];
    
}

#pragma  mark - choseOnlineorOffline
// 线上或者线下点击事件
-(void)choseOnlineorOffline:(UIButton *)btn
{
    UIButton *onlineBtn = (UIButton *)[self.view viewWithTag:301];
    UIButton *offlineBtn = (UIButton *) [self.view viewWithTag:302];
    if (btn.tag == 301)
    {
        onlineBtn.selected = YES;
        offlineBtn.selected = NO;
        self.state = Online;
    }else if (btn.tag == 302 )
    {
        offlineBtn.selected = YES;
        onlineBtn.selected = NO;
        self.state = Offline;
    }
}

#pragma mark - Chose FreeorNeedPay
// 免费或者收费点击事件
-(void)choseFreeorNeedPay:(UIButton *)btn
{
    UIButton *freeBtn = (UIButton *)[superBG viewWithTag:303];
    UIButton *paymentBtn = (UIButton *)[superBG viewWithTag:304];
    UITextField *priceTF = (UITextField *)[superBG viewWithTag:403];
    UILabel *priceLB = (UILabel *)[superBG viewWithTag:999];
    
    if (btn.tag == 303)
    {
        freeBtn.selected = YES;
        paymentBtn.selected = NO;
        self.freestate = Free;
        priceLB.hidden = YES;
        priceTF.hidden = YES;
    }else if (btn.tag == 304)
    {
        paymentBtn.selected = YES;
        freeBtn.selected = NO;
        self.freestate = NeedPay;
        priceLB.hidden = NO;
        priceTF.hidden = NO;
    }
}
#pragma mark - TextFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    TFTag=textField.tag;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击UITextField
    UITextField *maxMumTF = (UITextField *)[superBG viewWithTag:400];
    UITextField *priceTF = (UITextField *)[superBG viewWithTag:403];
    [maxMumTF resignFirstResponder];
    [priceTF resignFirstResponder];

}

#pragma mark - push NavigationController
// 跳转到下一步页面
-(void)nextBtnClicked
{
    AddTCourseNextViewController *nextVC = [[AddTCourseNextViewController alloc] init];
    nextVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    nextVC.state = self.state;
    nextVC.superNvc = self.superNvc;
    [self.superNvc pushViewController:nextVC animated:YES];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
