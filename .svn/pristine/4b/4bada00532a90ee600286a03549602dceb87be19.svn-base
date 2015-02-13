//
//  RegisterViewController1.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/30.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//  注册页面1

#define KBorder 10

#import "RegisterViewController1.h"
#import "RegisterViewController2.h"
#import "CountryListViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "NSString+Helper.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface RegisterViewController1 ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CountryListViewControllerDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UITextField * numberFeild;
@property (nonatomic, strong) NSString * countryName; // 国家名字
@property (nonatomic, strong) NSString * phoneNumber; // 电话号码
@property (nonatomic, strong) NSMutableArray * areaArray; // 地区列表
@property (nonatomic, strong) CountryAndAreaCode * countryInfo; // 国家信息
@property (nonatomic, strong) URBAlertView * alertView;
@property (nonatomic, assign) NetworkStatus netState; // 网络状态
@property (nonatomic, strong) UIView * footerView; // 脚视图

@end

@implementation RegisterViewController1

// AppDelegate 助手方法
+ (AppDelegate *)defaultAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = RGB(236, 235, 241, 1.0);
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleView.text = @"注册(1/4)";
    titleView.font = [UIFont boldSystemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    
    // 下一步按钮
    UIButton * stepButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    stepButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [stepButton setTitle:@"下一步" forState:UIControlStateNormal];
    stepButton.titleLabel.textColor = [UIColor whiteColor];
    stepButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [stepButton addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * stepItem = [[UIBarButtonItem alloc] initWithCustomView:stepButton];
    [self addNavigationWithTitle:nil leftItem:nil rightItem:stepItem titleView:titleView];
    
    
    
    [self getAreaList];
    
    _countryInfo = [[CountryAndAreaCode alloc] init];
    // 默认国家 中国（+86）
    _countryName = @"中国（+86）";
    _countryInfo.areaCode = @"86";
    
    [self.view addSubview:self.tableView];
}

// 脚视图
- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 150)];
        _footerView.backgroundColor = RGB(236, 235, 241, 1.0);
        NSString *info = @"通过手机注册子曰，我们不会在任何地方泄露您的手机号码。";
        CGSize infoSize = [info boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width - KBorder * 2, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(KBorder, KBorder, SCREEN_SIZE.width - KBorder * 2, infoSize.height)];
        infoLabel.text = info;
        infoLabel.textColor = [UIColor grayColor];
        infoLabel.numberOfLines = 0;
        infoLabel.font = [UIFont systemFontOfSize:14];
        [_footerView addSubview:infoLabel];
        
        CGSize infolabel1Size = [@"点击下一步表示用户同意" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        UILabel * infoLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(KBorder, CGRectGetMaxY(infoLabel.frame) + KBorder / 2.0, infolabel1Size.width, infolabel1Size.height)];
        infoLabel1.text = @"点击下一步表示用户同意";
        infoLabel1.font = [UIFont systemFontOfSize:14];
        [_footerView addSubview:infoLabel1];
        
        // 用户协议按钮
        UIButton * userButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(infoLabel1.frame) - KBorder * 2, CGRectGetMaxY(infoLabel.frame) + KBorder / 2.0, 140, infolabel1Size.height)];
        
        [userButton setTitle:@"《子曰用户协议》" forState:UIControlStateNormal];
        [userButton setTitleColor:RGBACOLOR(101, 147, 255, 1.0) forState:UIControlStateNormal];
        userButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        userButton.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
        userButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [userButton addTarget:self action:@selector(lookAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:userButton];
    }
    
    return _footerView;
}

/**
 *  查看用户协议
 */
- (void)lookAction
{
    
}

/**
 *  获取地区列表
 */
- (void)getAreaList
{
    // 获取支持的地区列表
    [SMS_SDK getZone:^(enum SMS_ResponseState state, NSArray *zonesArray) {
        if (state == SMS_ResponseStateSuccess) {
            [self.areaArray addObjectsFromArray:zonesArray];
        }else if (state == SMS_ResponseStateFail) {
            // failed
        }
    }];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(236, 235, 241, 1.0);
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
        headerView.backgroundColor = RGB(236, 235, 241, 1.0);
        _tableView.tableHeaderView = headerView;

        _tableView.tableFooterView = self.footerView;
     }
    
    return _tableView;
}

/**
 *  地区列表
 */
- (NSMutableArray *)areaArray
{
    if (_areaArray == nil) {
        _areaArray = [[NSMutableArray alloc] init];
    }
    
    return _areaArray;
}

- (UITextField *)numberFeild
{
    if (_numberFeild == nil) {
        _numberFeild = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 200, 44)];
        _numberFeild.placeholder = @"请输入手机号码";
        _numberFeild.delegate = self;
        _numberFeild.keyboardType = UIKeyboardTypeNumberPad; // 键盘类型
        _numberFeild.returnKeyType = UIReturnKeyDone;
    }
    
    return _numberFeild;
}

// 检测手机号码是否含有其他字符
- (BOOL)validateNumberic:(NSString *)numberStr
{
    NSCharacterSet * charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSRange range = [numberStr rangeOfCharacterFromSet:charSet];
    
    return (range.location == NSNotFound) ? NO : YES;
}

// 检测手机号码是否正确
- (BOOL)isValidPhoneNumber:(NSString *)phoneNumber
{
    BOOL isMatch = false;
    int compareResult = 0;
    
    // 检测areaArray是否为空数据 为空则重新加载地区列表
    if ([_areaArray count] == 0) {
        [self getAreaList];
    }
    
    for (int i=0; i<_areaArray.count; i++) {
        NSDictionary* dict1=[_areaArray objectAtIndex:i];
        NSString* code1=[dict1 valueForKey:@"zone"];
        if ([code1 isEqualToString:_countryInfo.areaCode]) {
            compareResult=1;
            NSString* rule1=[dict1 valueForKey:@"rule"];
            NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
            
            isMatch = [pred evaluateWithObject:phoneNumber];
            break;
        }
    }
    
    return isMatch;
}

/**
 *  下一步
 */
- (void)nextStepAction
{
    __weak typeof(self) weakSelf = self;
    // 取出phoneNumber
    _phoneNumber = _numberFeild.text;
    
    // 判断手机号是否为空
    if ([_phoneNumber isEmptyString]) {
        _alertView = [URBAlertView dialogWithTitle:@"手机号不能为空" subtitle:nil];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        return;
    }
    
    // 判断用户是否输入了除了数字之外的字符
    BOOL isValid = [self validateNumberic:_phoneNumber];
    
    if (_phoneNumber.length < 11 || isValid) {
        _alertView = [URBAlertView dialogWithTitle:@"请输入合法的手机号" subtitle:nil];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        return;
    }
    
    // 检测是否有网络
    _netState = [RegisterViewController1 defaultAppDelegate].netState;
    
    if (_netState == NotReachable) {
        _alertView = [URBAlertView dialogWithTitle:@"网络连接失败，请检查您的网络" subtitle:nil];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        return;
    }
    
    // 检测手机号码不正确
    BOOL isTurePhoneNumber = [self isValidPhoneNumber:_phoneNumber];
    
    if (!isTurePhoneNumber) {
        _alertView = [URBAlertView dialogWithTitle:@"手机号码不正确" subtitle:nil];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        return;
    }
    
#warning 判断是否已经是注册过的手机号
    
    NSString * message = [NSString stringWithFormat:@"(+%@) %@", _countryInfo.areaCode, _phoneNumber];
    _alertView = [URBAlertView dialogWithTitle:@"确认手机号" subtitle:message];
    _alertView.blurBackground = NO;
    [_alertView addButtonWithTitle:@"修改"];
    [_alertView addButtonWithTitle:@"确认"];
    [_alertView showWithAnimation:URBAlertAnimationTumble];
    
    [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        
        if (buttonIndex == 0) {
            // 使Textfiled为第一焦点
            [weakSelf.numberFeild becomeFirstResponder];
        }else {
            __block NSString * message = nil;
            // 获取验证码
            [SMS_SDK getVerifyCodeByPhoneNumber:weakSelf.phoneNumber AndZone:weakSelf.countryInfo.areaCode result:^(enum SMS_GetVerifyCodeResponseState state) {
                if (state == SMS_ResponseStateGetVerifyCodeSuccess) {
                    message = @"获取验证码成功";
                    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                    progress.labelText = message;
                    progress.labelFont = [UIFont boldSystemFontOfSize:17];
                    progress.mode = MBProgressHUDModeText;
                    progress.animationType = MBProgressHUDAnimationFade;
                    [weakSelf.view addSubview:progress];
                    
                    [progress showAnimated:YES whileExecutingBlock:^{
                        sleep(2.0);
                    } completionBlock:^{
                        [progress removeFromSuperview];
                        progress = nil;
                    }];
                    RegisterViewController2 * registerVc2 = [[RegisterViewController2 alloc] init];
                    // 传入手机号和地区码
                    registerVc2.phoneNumber = weakSelf.phoneNumber;
                    registerVc2.areaCode = weakSelf.countryInfo.areaCode;
                    
                    [weakSelf.navigationController pushViewController:registerVc2 animated:YES];
                }else if (state == SMS_ResponseStateGetVerifyCodeFail) {
                    message = @"获取验证码失败，请重新获取";
                    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                    progress.labelText = message;
                    progress.labelFont = [UIFont boldSystemFontOfSize:17];
                    progress.mode = MBProgressHUDModeText;
                    progress.animationType = MBProgressHUDAnimationFade;
                    [weakSelf.view addSubview:progress];
                    
                    [progress showAnimated:YES whileExecutingBlock:^{
                        sleep(2.0);
                    } completionBlock:^{
                        [progress removeFromSuperview];
                        progress = nil;
                    }];
                    
                    return;
                }
            }];
        }
        
        [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"CodeCellId";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
     }
    
    if (indexPath.row == 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _countryName; // 国家
    }else if (indexPath.row == 1) {
        // 手机号码
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.contentView addSubview:self.numberFeild];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        // 选择国家和地区
        CountryListViewController * countryListVc = [[CountryListViewController alloc] init];
        countryListVc.delegate = self;
        [self.navigationController pushViewController:countryListVc animated:YES];
    }
}

#pragma mark - CountryListViewControllerDelegate

- (void)sendCountryData:(CountryAndAreaCode *)countryData
{
    _countryInfo = countryData;
    NSString * areaCodeStr = [NSString stringWithFormat:@"%@ +%@", _countryInfo.countryName, _countryInfo.areaCode];
    _countryName = areaCodeStr;
    
    [_tableView reloadData];
}

#pragma mark - UITextFeildDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 限制手机号输入为11位
    if (range.location >= 11) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
