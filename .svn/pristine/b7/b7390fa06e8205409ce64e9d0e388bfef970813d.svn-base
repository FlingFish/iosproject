//
//  AddTCourseNextViewController.m
//  FunCourse
//
//  Created by ebrohim on 15/1/7.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//


#define XBorder 2
#define ButtonColor RGB(37 , 31, 39, 0.9)

#import "AddTCourseNextViewController.h"
#import "PickAddressViewController.h"
#import "AddTCourseTimeViewController.h"


@interface AddTCourseNextViewController ()<UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate,PickAddressDelegate>
{
    NSInteger            indexTag;  // 用于标注按钮tag
    NSInteger               tfTag;
    UIView               *superBG;
    UIView             *addressBG;
    UIView              *remarkBG;
    UIButton         *pickAddBtn;
    CGFloat            btnHeight;
}

@property (nonatomic, assign) BOOL isMoveUp; // 是否上移

@end

@implementation AddTCourseNextViewController

-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"发布课程(3/4)";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem * nextItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(next)];

    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nextItem titleView:titleView];
    
    //根据iphone设备的型号来进行页面布局的适配
    CGFloat  pbWidth = 0;
    CGFloat  xBorder = 0;
    CGFloat  YBorder = 0;
    CGFloat  bWidth = 0;
    btnHeight = 0;
    xBorder = 0;
    pbWidth = 0;
    YBorder = 0;
    if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5])
    {
        bWidth  = 300;
        btnHeight =30;
        pbWidth = 221;
        YBorder = 25;
    } else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone5s])
    {
        bWidth = 300;
        pbWidth = 225;
        btnHeight =35;
        YBorder = 45;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6])
    {
        bWidth = 335;
        pbWidth = 260;
        btnHeight =40;
        YBorder = 68;
    }else if ([[GetCurrentDevice currentDeviceWithiPhone] isEqualToString:iPhone6_Plus]) {
        bWidth  = 364;
        pbWidth = 291;
        btnHeight =45;
        YBorder = 55;
    }
    xBorder = (SCREEN_SIZE.width-bWidth)/2;
    
    // 用于承载页面上所有控件的容器UIView，用于屏幕偏移等
    superBG = [[ UIView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    superBG.backgroundColor = [ UIColor whiteColor];
    superBG.tag = 1000;
    [self.view addSubview:superBG];
    
    // 通知中心 监控键盘的状态(打开 关闭 中英文切换)
    NSNotificationCenter * notifi = [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 地址背景容器
    addressBG = [[UIView alloc] init];
    if (self.state == Offline)
    {
        addressBG.frame = CGRectMake(0, 50, SCREEN_SIZE.width, btnHeight*2);
        addressBG.backgroundColor = [UIColor clearColor];
        addressBG.tag = 3000;
        [superBG addSubview:addressBG];
    }
    
    // 地址标题按钮
    UIButton*addressBtn = [[UIButton alloc]initWithFrame:CGRectMake(xBorder, 1, bWidth, btnHeight-2)];
    [addressBtn setTitle:@"授课地点" forState:UIControlStateNormal];
    [addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addressBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    addressBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    addressBtn.backgroundColor=ButtonColor;
    [addressBtn.layer setMasksToBounds:YES];
    [addressBtn.layer setCornerRadius:5];
    [addressBG addSubview:addressBtn];
    
    pickAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(xBorder, CGRectGetMaxY(addressBtn.frame)+1, bWidth, btnHeight)];
    [pickAddBtn setTitle:@"点击输入地址" forState:UIControlStateNormal];
    pickAddBtn.tag = 401;
    [pickAddBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pickAddBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    pickAddBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    pickAddBtn.backgroundColor=[UIColor whiteColor];
    [pickAddBtn.layer setMasksToBounds:YES];
    [pickAddBtn.layer setCornerRadius:5];
    [pickAddBtn.layer setBorderWidth:0.6];
    [pickAddBtn addTarget:self action:@selector(pickAddBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [addressBG addSubview:pickAddBtn];
  
    remarkBG = [[UIView alloc] init];
    if (self.state == Offline)
    {
       remarkBG.frame = CGRectMake(xBorder, CGRectGetMaxY(addressBG.frame)+YBorder, bWidth, btnHeight*2);
        remarkBG.backgroundColor = RGB(128, 128, 128, 0.1);
        remarkBG.tag = 3001;
        [superBG addSubview:remarkBG];
    }

    // 地址备注按钮
    UIButton *remarkBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, bWidth, btnHeight-2)];
    [remarkBtn setTitle:@"地点备注" forState:UIControlStateNormal];
    [remarkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    remarkBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    remarkBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    remarkBtn.backgroundColor=ButtonColor;
    [remarkBtn.layer setMasksToBounds:YES];
    [remarkBtn.layer setCornerRadius:5];
    [remarkBG addSubview:remarkBtn];
    
    //地址备注TextField
    UITextField *remarkTF = [[UITextField alloc]initWithFrame:CGRectMake(XBorder, CGRectGetMaxY(remarkBtn.frame)+2, bWidth, btnHeight-2)];
    remarkTF.placeholder = @"您可以备注详细的地址：";
    remarkTF.backgroundColor = [UIColor whiteColor];
    remarkTF.font = [UIFont systemFontOfSize:14];
    remarkTF.tag = 402;
    remarkTF.delegate = self ;
    [remarkBG addSubview:remarkTF];
    
    UIView *introBG = [[UIView alloc] init];
    // 根据地址和地址备注的的hidden属性来布局
    if (self.state == Online) {
        introBG.frame = CGRectMake(xBorder,50, bWidth, btnHeight*3.5);
    }else if (self.state == Offline)
    {
       introBG.frame = CGRectMake(xBorder, CGRectGetMaxY(remarkBG.frame)+YBorder, bWidth, btnHeight*3.5);
    }
    introBG.backgroundColor = [UIColor clearColor];;
    introBG.tag = 3002;
    [superBG addSubview:introBG];
    
    UIButton *introBtn = [[UIButton alloc]initWithFrame:CGRectMake(XBorder,1, bWidth, btnHeight-2)];
    [introBtn setTitle:@"课程介绍" forState:UIControlStateNormal];
    [introBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    introBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    introBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    introBtn.backgroundColor=ButtonColor;
    [introBtn.layer setMasksToBounds:YES];
    [introBtn.layer setCornerRadius:5];
    [introBG addSubview:introBtn];
    
    UITextView *introTV = [[ UITextView alloc]initWithFrame:CGRectMake(XBorder, CGRectGetMaxY(introBtn.frame)+1, bWidth, btnHeight*2.5)];
    introTV.text= @"您可以在这里输入比较详细的课程介绍";
    introTV.backgroundColor = RGB(128, 128, 128, 0.2);
    introTV.tag = 403;
    introTV.delegate = self;
    [introBG addSubview:introTV];
}
#pragma mark - pickAddressBtn Clicked 
-(void)pickAddBtnClicked
{
    PickAddressViewController *pickVc = [[PickAddressViewController alloc] init];
    pickVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    pickVc.delegate = self;
    pickVc.superNvc = self.superNvc;
    [self.superNvc pushViewController:pickVc animated:YES];
}
#pragma mark - Move Methods

// 复位superBG背景View的偏移量
-(void)scrollEnd
{
    [UIView animateWithDuration:0.3 animations:^{
        superBG.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    }];
    self.isMoveUp = NO;
}

#pragma mark - keyboardFrameChanged
/**
 *  接收到通知 键盘边框大小变化
 */
- (void)keyboardFrameChanged:(NSNotification *)nf
{
    // 使用userInfo 的UIKeyBoardFrameEndUserInfoKey数据可以判断键盘的大小
    // 获取键盘的目标区域
    NSDictionary * info = nf.userInfo;
    CGRect rect = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"rect : %lf", rect.size.height);
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 根据rect的orangion.y可以判断键盘是开启还是关闭
    if (rect.origin.y == SCREEN_SIZE.height) {
        // 键盘关闭
        [UIView animateWithDuration:duration animations:^{
            [self scrollEnd];
            
        } completion:^(BOOL finished) {
            
        }];
    }else {
        // 打开键盘或者中英文切换
        // 根据目标位置的高度判断键盘的类型
        if (rect.size.height == 216) {
            // 英文键盘
            [UIView animateWithDuration:duration animations:^{
                if (self.state == Offline) {
                    if (self.isMoveUp == NO ) {
                        if (tfTag == 402 || tfTag == 403) {
                            CGPoint superCenter = superBG.center;
                            superCenter.y -= 216-2*btnHeight;
                            superBG.center = superCenter;
                        }
                        self.isMoveUp = YES; // 已经上移
                    }
                }

            } completion:^(BOOL finished) {
                
            }];
        }else if (rect.size.height == 252) {
            // 中文键盘
            [UIView animateWithDuration:duration animations:^{
                if (self.state == Offline) {
                    if (!self.isMoveUp) {
                        if (tfTag == 402 || tfTag == 403) {
                            CGPoint superCenter = superBG.center;
                            superCenter.y -= 252 -2*btnHeight;
                            superBG.center = superCenter;
                        }
                        self.isMoveUp = YES;
                    }
                }

            } completion:^(BOOL finished) {
                
            }];
        }else if (rect.size.height == 258){
            // 英文键盘 258
            [UIView animateWithDuration:duration animations:^{
                if (self.state == Offline) {
                    if (!self.isMoveUp) {
                        if (tfTag == 402 || tfTag == 403) {
                            CGPoint superCenter = superBG.center;
                            superCenter.y -= 258 -2*btnHeight;
                            superBG.center = superCenter;
                        }
                        self.isMoveUp = YES;
                    }
                }
            } completion:^(BOOL finished) {
                
            }];
        }else if (rect.size.height == 253) {
            // 英文键盘 253
            [UIView animateWithDuration:duration animations:^{
                if (self.state == Offline) {
                    if (!self.isMoveUp) {
                        if (tfTag == 402  || tfTag == 403) {
                            CGPoint superCenter = superBG.center;
                            superCenter.y -= 253 -2*btnHeight;
                            superBG.center = superCenter;
                        }
                        self.isMoveUp = YES;
                    }
                }

            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

// 点击屏幕TextField 和TextVeiw以外的区域收起键盘

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextView *introTV = (UITextView *)[superBG viewWithTag:403];
    [introTV resignFirstResponder];
    if (self.state == Online) {
        UITextField *remarkTF = (UITextField *)[superBG viewWithTag:402];
        [remarkTF resignFirstResponder];
    }
}

#pragma mark - UITextViewDelegate

// UITextView输入完成收起键盘

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    tfTag = textView.tag;
    return YES;
}
#pragma mark - UITextFiled Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    tfTag = textField.tag;
    return YES;
}

// 限制页面内所有TextField输入范围

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger    length = textField.text.length;
    NSInteger   maxlength = 20;
    NSInteger   maxpricelength = 4;
    if (self.state == Online) {
        if (tfTag== 402 && length >= maxlength && string.length>0)
        {
            return  NO;
        }
    }else if (tfTag == 403 && length >=maxpricelength && string.length >0)
    {
        return NO;
    }
    return YES;
}

- (void)sendAddressStr:(NSString *)address
{
    CGSize addressSize = [address sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    NSString *plstr = @"输入并选择地点";
    if (![address isEqualToString: plstr])
    {
        [pickAddBtn setTitle:address forState:UIControlStateNormal];
        CGRect frame = pickAddBtn.frame;
        addressSize.width = frame.size.width;
        frame.size.width = addressSize.width;
    }
}
/**
 *  back
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next
{
    AddTCourseTimeViewController *timeVC = [[AddTCourseTimeViewController alloc] init];
    timeVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    timeVC.superNvc = self.superNvc;
    [self.superNvc pushViewController:timeVC animated:YES];
}

#pragma mark - Life Cycle
/**
 *  视图将要显示
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

/**
 *  视图将要消失
 */

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
