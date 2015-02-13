//
//  AddLCourseViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//


#define XBorder 1
#define ButtonColor RGB(37 , 31, 39, 0.9)

#import "AddLCourseViewController.h"
#import "TypePickerView.h"
#import "GetCurrentDevice.h"



@interface AddLCourseViewController ()<UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSMutableArray    *_typeArray;
    NSInteger                tfTag;
    UIView                *superBG;
    CGFloat                xBorder;
    CGFloat                pbWidth;
    CGFloat              btnHeight;
}

@property (nonatomic, assign) BOOL isMoveUp; // 是否上移

@property (nonatomic, assign) PayState paystate;
@property (nonatomic, assign) OnlineState state;


@end

@implementation AddLCourseViewController

/**
 *  初始化UI
 */
- (void)setupUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"发布求学";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem * submitItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(Submit)];
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:submitItem titleView:titleView];
    
    //根据iphone设备的型号来进行页面布局的适配
    CGFloat     bWidth = 0;
    pbWidth = 0;
    xBorder = 0;
    CGFloat     YBorder = 0;
    btnHeight = 0;
    
    if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5])
    {
        bWidth  = 300;
        xBorder = 10;
        pbWidth = 221;
        btnHeight = 30;
        YBorder = 30;
    } else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5s])
    {
        bWidth = 300;
        xBorder =  10;
        pbWidth = 225;
        btnHeight = 35;
        YBorder = 50;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6])
    {
        bWidth = 335;
        xBorder = 20;
        pbWidth = 260;
        btnHeight = 40;
        YBorder = 75;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6_Plus]) {
        bWidth  = 364;
        xBorder = 24;
        pbWidth = 289;
        btnHeight = 45;
        YBorder = 67;
    }
    
    superBG = [[ UIView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    superBG.backgroundColor = [ UIColor whiteColor];
    [self.view addSubview:superBG];
    
    // 最顶申明文字Label
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(xBorder, 0, bWidth, 50)];
    introLabel.text = @"欢迎您发布课程，请认真填写真实的课程相关信息，请勿包含任何非法信息！";
    introLabel.font = [UIFont systemFontOfSize:13.0];
    introLabel.numberOfLines = 0;
    introLabel.textColor = [ UIColor lightGrayColor];
    [superBG addSubview:introLabel];
    
    // 类型按钮、选择类型按钮背景
    UIView *typeBG = [[ UIView alloc] initWithFrame:CGRectMake(xBorder, 50, bWidth,btnHeight)];
    typeBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:typeBG];
    
    // 类型按钮
    UIButton  *typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(XBorder,1, 70, btnHeight-2)];
    [typeBtn setTitle:@"类型" forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    typeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    typeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    typeBtn.backgroundColor= ButtonColor ;
    [typeBtn.layer setMasksToBounds:YES];
    [typeBtn.layer setCornerRadius:5];
    [typeBG addSubview:typeBtn];
    
    // 点击选择类型按钮
    UIButton *picktypeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeBtn.frame)+1, 1,pbWidth, btnHeight-2)];
    [picktypeBtn setTitle:@"点这选个类型" forState:UIControlStateNormal];
    picktypeBtn.tag = 201;
    [picktypeBtn.layer setMasksToBounds:YES];
    [picktypeBtn.layer setCornerRadius:5];
    [picktypeBtn.layer setBorderWidth:0.6];
    [picktypeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [picktypeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    picktypeBtn.backgroundColor = [UIColor whiteColor];
    picktypeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [picktypeBtn addTarget:self action:@selector(picktypeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [typeBG addSubview:picktypeBtn];
    
    // 标签按钮和标签输入框背景
    UIView *typetagBG = [[UIView alloc] initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(typeBG.frame)+YBorder, bWidth,2*btnHeight)];
    typetagBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:typetagBG];
    
    // 标签按钮
    UIButton   *typetagBtn = [[UIButton alloc]initWithFrame:CGRectMake(XBorder,1, bWidth-4,btnHeight)];
    [typetagBtn setTitle:@"给课程贴个标签" forState:UIControlStateNormal];
    [typetagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    typetagBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    typetagBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    typetagBtn.backgroundColor = ButtonColor ;
    [typetagBtn.layer setMasksToBounds:YES];
    [typetagBtn.layer setCornerRadius:5];
    [typetagBG addSubview:typetagBtn];
    
    // 标签输入框
    UITextField *typetagTF = [[UITextField alloc]initWithFrame:CGRectMake(XBorder, CGRectGetMaxY(typetagBtn.frame)+2,bWidth-4, btnHeight)];
    typetagTF.placeholder = @"这可以写标签";
    typetagTF.delegate = self ;
    typetagTF.tag = 401;
    typetagTF.returnKeyType = UIReturnKeyDone;
    typetagTF.backgroundColor = RGB(128, 128, 128, 0.1);
    typetagTF.font = [UIFont systemFontOfSize:14.0];
    [typetagBG addSubview:typetagTF];
    
    // 描述按钮和描述输入框背景
    UIView *introBG = [[UIView alloc] initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(typetagBG.frame)+YBorder, bWidth, btnHeight*2)];
    introBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:introBG];
    
    // 求学描述标题按钮
    UIButton  *introBtn = [[UIButton alloc]initWithFrame:CGRectMake(XBorder , 1, bWidth-4, btnHeight)];
    [introBtn setTitle:@"描述想学的课程 " forState:UIControlStateNormal];
    [introBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    introBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    introBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    introBtn.backgroundColor = ButtonColor ;
    [introBtn.layer setMasksToBounds:YES];
    [introBtn.layer setCornerRadius:5];
    [introBG addSubview:introBtn];
    
    // 求学输入框
    UITextField *introTF = [[UITextField alloc]initWithFrame:CGRectMake(XBorder, CGRectGetMaxY(introBtn.frame)+2, bWidth-4, btnHeight)];
    introTF.placeholder = @"点这加个标题呗";
    introTF.backgroundColor = RGB(128, 128, 128, 0.1);
    introTF.delegate = self ;
    introTF.tag = 402 ;
    introTF.returnKeyType = UIReturnKeyDone;
    introTF.font = [UIFont systemFontOfSize:14.0];
    [introBG addSubview:introTF];
    
    //授课方式标题按钮和线上线下按钮背景
    UIView *whereBG = [[UIView alloc] initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(introBG.frame)+YBorder, bWidth, btnHeight)];
    whereBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:whereBG];
    
    // 求学方式标题按钮
    UIButton *whereBtn = [[UIButton alloc]initWithFrame:CGRectMake(XBorder, 1, 70, btnHeight-2)];
    [whereBtn setTitle:@"求学方式" forState:UIControlStateNormal];
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
    
    //付费方式背景
    UIView *paymentBG = [[UIView alloc] initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(whereBG.frame)+YBorder, bWidth, 2*btnHeight)];
    paymentBG.backgroundColor = [UIColor clearColor];
    [superBG addSubview:paymentBG];
    
    //付费方式按钮
    UIButton *isWillPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(XBorder, 1, 70, btnHeight)];
    [isWillPayBtn setTitle:@"是否收费" forState:UIControlStateNormal];
    [isWillPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    isWillPayBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    isWillPayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    isWillPayBtn.backgroundColor = ButtonColor;
    [isWillPayBtn.layer setMasksToBounds:YES];
    [isWillPayBtn.layer setCornerRadius:5];
    [paymentBG addSubview:isWillPayBtn];
    
    //免费按钮
    UIButton *freeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(isWillPayBtn.frame)+1, 50, btnHeight)];
    [freeBtn setImage:[UIImage imageNamed:@"free_normal"] forState:UIControlStateNormal];
    [freeBtn setImage:[UIImage imageNamed:@"free_selected"] forState:UIControlStateSelected];
    freeBtn.tag = 303;
    freeBtn.selected = YES;
    [freeBtn addTarget:self action:@selector(choseFreeorNeedPay:) forControlEvents:UIControlEventTouchUpInside];
    [paymentBG addSubview:freeBtn];
    
    //收费按钮
    UIButton *paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(freeBtn.frame)+20, CGRectGetMaxY(isWillPayBtn.frame)+1, 50, btnHeight)];
    [paymentBtn setImage:[UIImage imageNamed:@"needpay_normal"] forState:UIControlStateNormal];
    [paymentBtn setImage:[UIImage imageNamed:@"needpay_selected"] forState:UIControlStateSelected];
    paymentBtn.tag = 304;
    [paymentBtn addTarget:self action:@selector(choseFreeorNeedPay:) forControlEvents:UIControlEventTouchUpInside];
    [paymentBG addSubview:paymentBtn];
    
    //价格标签
    UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(paymentBtn.frame)+20, CGRectGetMaxY(isWillPayBtn.frame)+1, 40, btnHeight-1)];
    priceLB.text = @"价格:";
    priceLB.font = [UIFont systemFontOfSize:14.0];
    priceLB.hidden = YES;
    priceLB.tag = 999;
    [paymentBG addSubview:priceLB];
    
    //价格输入框
    UITextField *priceTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLB.frame),  CGRectGetMaxY(isWillPayBtn.frame)+1, 120, btnHeight - 2)];
    priceTF.placeholder = @"开个价";
    priceTF.backgroundColor = RGB(128, 128, 128, 0.1);
    priceTF.delegate = self ;
    priceTF.tag = 403 ;
    priceTF.keyboardType = UIKeyboardTypeNumberPad;
    priceTF.returnKeyType = UIReturnKeyDone;
    priceTF.font = [UIFont systemFontOfSize:14.0];
    priceTF.hidden =YES;
    [paymentBG addSubview:priceTF];
}

/**
 *  选择课程类型
 */
#pragma mark - picktypeBtnClicked

-(void)picktypeBtnClicked:(UIButton *)btn
{
    //创建下拉列表
    UIButton *picktypeBtn = (UIButton *)[superBG viewWithTag:201];
    CGPoint pickerViewPoint = CGPointMake(picktypeBtn.center.x, picktypeBtn.center.y+130);
    NSArray *titles = @[@"学运动类就点我", @"学音乐类就点我", @"学摄影类就点我",@"搞娱乐类就点我",@"等等等等等等等"];
    _typeArray = [titles copy];
    TypePickerView *timePickView = [[TypePickerView alloc] initWithPoint:pickerViewPoint titles:titles images:nil];
    timePickView.selectRowAtIndex = ^(NSInteger index)
    {
        NSLog(@"select index:%ld", (long)index);
        [picktypeBtn setTitle:_typeArray[index] forState:UIControlStateNormal];
    };
    [timePickView show];
    [picktypeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

/*
 *限制页面内所有TextField输入范围
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger    length = textField.text.length;
    NSInteger   maxlength = 20;
    NSInteger   maxpricelength = 4;
    if ((textField.tag == 401||textField.tag== 402) && length >= maxlength && string.length>0)
    {
        return  NO;
    }else if (textField.tag == 403 && length >=maxpricelength && string.length >0)
    {
        return NO;
    }
    return YES;
}


#pragma mark - UITextFieldDelegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击UITextField 和UItextView以外任何区域收回键盘
    UIView *introTF = (UIView *)[superBG viewWithTag:401];
    UIView *typetagTF = (UIView *)[superBG viewWithTag:402];
    UIView *priceTF = (UIView *)[superBG viewWithTag:403];
    [introTF resignFirstResponder];
    [typetagTF resignFirstResponder];
    [priceTF resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    tfTag = textField.tag;
    [textField resignFirstResponder];
    return YES;
}

/*
 *UITextField 输入完成后起键盘
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma  mark - choseOnlineorOffline
// 线上或者线下点击事件
-(void)choseOnlineorOffline:(UIButton *)btn
{
    UIButton *onlineBtn = (UIButton *)[superBG viewWithTag:301];
    UIButton *offlineBtn = (UIButton *) [superBG viewWithTag:302];
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

#pragma mark - Chose FreeorWillPay
// 免费或者付费点击事件
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
        self.paystate = GetFree;
        priceLB.hidden = YES;
        priceTF.hidden = YES;
    }else if (btn.tag == 304)
    {
        paymentBtn.selected = YES;
        freeBtn.selected = NO;
        self.paystate = WillPay;
        priceLB.hidden = NO;
        priceTF.hidden = NO;
    }
}

/*
 *提交
 */
-(void)Submit
{
    NSLog(@"hahah");
    UIActionSheet *backORcheck = [[ UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"返回首页" destructiveButtonTitle:nil otherButtonTitles:@"查看求学", nil];
    [backORcheck showInView:[[UIApplication sharedApplication] keyWindow]];
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

/**
 *  返回首页
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  视图将要显示
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
}

/**
 *  视图将要消失
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [super viewWillDisappear:animated];
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
