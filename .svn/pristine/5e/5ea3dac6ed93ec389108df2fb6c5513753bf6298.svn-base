//
//  LoginViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/24.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//  登录

#define kBorder 20

#import "LoginViewController.h"
#import "LoginUser.h"
#import "NSString+Helper.h"
#import "EMError.h"
#import "RegisterViewController1.h"
#import "AppDelegate.h"
#import "RootNavigationViewController.h"

@interface LoginViewController ()<IChatManagerDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) URBAlertView * alertView;

@end

@implementation LoginViewController

- (AppDelegate *)defaultDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

// 懒加载
- (UITextField *)userName
{
    if (_userName == nil) {
        _userName = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_SIZE.width - 200) / 2.0f, 0, 200, 44)];
        
        _userName.placeholder = @"手机号";
        _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userName.keyboardType = UIKeyboardTypeNumberPad;
        _userName.returnKeyType = UIReturnKeyDone;
        _userName.delegate = self;
    }
    
    return _userName;
}

- (UITextField *)passWord
{
    if (_passWord == nil) {
        _passWord = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_SIZE.width - 200) / 2.0f, 44.5, 200, 44)];
        _passWord.placeholder = @"密码";
        _passWord.delegate = self;
        _passWord.secureTextEntry = YES; // 密文输入
        _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _passWord.returnKeyType = UIReturnKeyDone;
    }
    return _passWord;
}

/**
 *  配置UI
 */
- (void)setupUI
{
    self.view.backgroundColor = RGB(218, 212, 202, 1.0);
    UIImageView * backGroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backGroundImage.userInteractionEnabled = YES;
    backGroundImage.image = [UIImage imageNamed:@"loginBg.jpg"];
    backGroundImage.alpha = 0.7;
    [self.view addSubview:backGroundImage];
    
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(kBorder, 200, SCREEN_SIZE.width - kBorder * 2, 88.5)];
    backgroundView.backgroundColor = RGB(241, 245, 255, 1.0);
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_SIZE.width - kBorder * 2, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [backgroundView addSubview:line];
    [self.view addSubview:backgroundView];
    
    // 用户名
    [backgroundView addSubview:self.userName];
    
    // 密码
    [backgroundView addSubview:self.passWord];
    
    // 登录按钮
    UIButton * loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(backgroundView.frame) + kBorder, SCREEN_SIZE.width - kBorder * 2, 44)];
    loginBtn.backgroundColor = RGB(67, 170, 255, 1.0);
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 3;
    
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.tag = 101;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [self.view addSubview:loginBtn];
    
    // 忘记密码
    UIButton * losePass = [[UIButton alloc] initWithFrame:CGRectMake(kBorder / 2.0, CGRectGetMaxY(loginBtn.frame) + kBorder / 2.0, 110, 44)];
    [losePass setTitle:@"忘记密码?" forState:UIControlStateNormal];
    losePass.titleLabel.textAlignment = NSTextAlignmentCenter;
    [losePass addTarget:self action:@selector(lossPassword) forControlEvents:UIControlEventTouchUpInside];
    [losePass setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:losePass];
    
    // 注册
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - 80, CGRectGetMaxY(loginBtn.frame) + kBorder / 2.0, 80, 44)];
    registerButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [registerButton setTitle:@"去注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(pushRegisterVc) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
}

/**
 *  注册
 */
- (void)pushRegisterVc
{
    RegisterViewController1 * registerVc = [[RegisterViewController1 alloc] init];
    RootNavigationViewController * rootNav = [[RootNavigationViewController alloc] initWithRootViewController:registerVc];
    [self defaultDelegate].window.rootViewController = rootNav;
}

/**
 *  忘记密码
 */
- (void)lossPassword
{
    NSLog(@"忘记密码");
}

/**
 *  登录
 */
- (void)login
{
    __weak typeof(self) weakSelf = self;
    
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    
    // 检查用户输入是否完整
    NSString * userName = [self.userName.text trimString];
    NSString * passWord = self.passWord.text;
    
    if ([userName isEmptyString] || [passWord isEmptyString]) {
        // 提示
        _alertView = [URBAlertView dialogWithTitle:@"提示" subtitle:@"登录信息输入不完整"];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            weakSelf.userName.text = @"";
            weakSelf.passWord.text = @"";
            [weakSelf.userName becomeFirstResponder];
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        return;
    }
    
    // 将用户登录信息写入系统偏好
    [[LoginUser sharedUserInfo] setUserName:userName];
    [[LoginUser sharedUserInfo] setPassWord:passWord];
    
    [self showHudInView:self.view hint:@"正在登录..."];
    
    
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userName
                                                        password:passWord
                                                        completion:^(NSDictionary *loginInfo, EMError *error) {
        [self hideHud];
        if (loginInfo && !error) {
            // 登录成功 把自动登录设置为YES
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            // 登录成功
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
            EMError * error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
            if (!error) {
                [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
            }
        }else {
            NSString * message = nil;
            // 登录失败
            switch (error.errorCode) {
                case EMErrorServerNotReachable:
                    message = @"连接服务器失败";
                    break;
                case EMErrorServerAuthenticationFailure:
                    message = error.description;
                    break;
                case EMErrorServerTimeout:
                    message = @"连接服务器超时";
                    break;
                default:
                    message = @"登录失败";
                    break;
            }
            // 提示
            _alertView = [URBAlertView dialogWithTitle:message subtitle:nil];
            [_alertView addButtonWithTitle:@"确定"];
            [_alertView showWithAnimation:URBAlertAnimationTumble];
            [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                weakSelf.userName.text = @"";
                weakSelf.passWord.text = @"";
                [weakSelf.userName becomeFirstResponder];
                [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
            }];
            return;
        }
    } onQueue:nil];
}

/**
 *  AlertViewDelegate
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {
        
    }
    return;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupForDismissKeyboard];
    [self setupUI];
}

#pragma mark - UITextFiledDelegate
// 限制用户输入的字符个数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _userName) {
        if (range.location >= 11) {
            return NO;
        }else {
            return YES;
        }
    }else {
        if (range.location >= 16) {
            return NO;
        }else {
            return YES;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
